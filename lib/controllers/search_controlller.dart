import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';

import '../models/user.dart';

class SearchController extends GetxController {
  late Rx<List<User>> _searchedUser = Rx<List<User>>([]);
 List<User> get searchedUser => _searchedUser.value;

  searchUser(String user) {
    _searchedUser.bindStream(firestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: user)
        .snapshots()
        .map((query) {
      List<User> list = [];
      for (var element in query.docs) {
        list.add(User.fromSnap(element));
      }
      return list;
    }));
  }
}
