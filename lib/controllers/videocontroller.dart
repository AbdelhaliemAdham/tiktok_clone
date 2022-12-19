import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/video_model.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videos = Rx<List<Video>>([]);
  List<Video> get videos => _videos.value;

  @override
  void onInit() {
    super.onInit();
    _videos.bindStream(
      firestore.collection('videos').snapshots().map((QuerySnapshot query) {
        List<Video> newVideos = [];
        for (var element in query.docs) {
          newVideos.add(Video.fromSnap(element));
        }
        return newVideos;
      }),
    );
  }

  likeVideo(String id) async {
    DocumentSnapshot doc = await firestore.collection('videos').doc(id).get();
    String uid = authController.user.uid;
    if ((doc.data() as dynamic)['likes'].contains(uid)) {
      await firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }

  deleteVideo(String id) async {
    await firebaseStorage.ref().child('videos').child(id).delete();
    await firestore.collection('videos').doc(id).delete();
    Get.snackbar('video', 'video Deleted');
    update();
  }
}
