import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_controller.dart';
import 'package:getx_mvvm_boilerplate/models/user_model.dart';

class HompageScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomepageScreenVM>(
      () => HomepageScreenVM(),
    );
  }
}

class HomepageScreenVM extends BaseController {
// สร้างลิสต์ว่างของ MOdel User
  final RxList<User> userList = <User>[].obs;

  //สร้าง set เก็บข้อมูล จังหวัดที่ไม่แสดงไม่ซ้ำกัน
  final RxSet<String> province = <String>{}.obs;

  // สร้าง RxList เพื่อเก็บข้อมูล user ที่ถูกเลือกในการลบ
  final RxList<User> selectedUsersList = <User>[].obs;

//เพิ่มข้อมูล Map ใส่ไว้ในลิสต์
  addUser(Map<String, dynamic> user) {
    userList.add(
      User(user['name'], user['lastName'], user['province'],
          [user['phone_number']], user['files']),
    );

    province.add(user['province']);
  }

  updateData(User newUser) {
    userList.value = userList.map((User userItem) {
      if (newUser.name == userItem.name) {
        return newUser; // เฉพาะ item ที่อัพเดตเท่านั้น
      }
      return userItem; // คืนค่า item ที่ไม่ได้อัพเดต
    }).toList();
  }

  // เพิ่มหรือลบ user ที่ถูกเลือกในเพื่อลบ
  selectedUser(User user) {
    if (selectedUsersList.contains(user)) {
      selectedUsersList.remove(user);
      userList.refresh();
    } else {
      selectedUsersList.add(user);
      userList.refresh();
    }
  }

  // ลบ user ที่ถูกเลือก // วนลูปหา user ที่เพิ่มไปใน List selectedUsersList
  deleteSelectedUsers() {
    for (var user in selectedUsersList.toList()) {
      userList.remove(user);
    }
    selectedUsersList.clear();
  }

//สร้างปุ่มลบข้อมูล//โดยรับค่า index//.removeAt

  delete(int index) {
    userList.removeAt(index);
  }

  // แสดงข้อมูลใน masterList
  showData(List<User> userList) {
    for (var user in userList) {
      print(
          'Name: ${user.name}, Lastname: ${user.lastName},province: ${user.province}, Tel: ${user.phoneNumbers}');
    }
  }
}
