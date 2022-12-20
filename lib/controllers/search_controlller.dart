import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';

import '../models/user.dart';

class SearchController extends GetxController {
  late Rx<List<UserModel>> _searchedUser = Rx<List<UserModel>>([]);
 List<UserModel> get searchedUser => _searchedUser.value;

  searchUser(String user) {
    _searchedUser.bindStream(firestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: user)
        .snapshots()
        .map((query) {
      List<UserModel> list = [];
      for (var element in query.docs) {
        list.add(UserModel.fromSnap(element));
      }
      return list;
    }));
  }
}
