import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_controller.dart';

class HompageScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomepageScreenController>(
      () => HomepageScreenController(),
    );
  }
}

class User {
  final String name;
  final String lastName;
  final String province;
  List<String>? phoneNumbers;

  User(this.name, this.lastName, this.province, this.phoneNumbers);
}

class HomepageScreenController extends BaseController {
  RxList<User> usersInProvince = <User>[].obs;
// สร้างลิสต์ว่างของ MOdel User
  final RxList<User> userList = <User>[].obs;

  //สร้าง set เก็บข้อมูล จังหวัดที่ไม่แสดงไม่ซ้ำกัน
  final RxSet<String> province = <String>{}.obs;

//เพิ่มข้อมูล Map ใส่ไว้ในลิสต์
  addUser(Map<String, dynamic> user) {
    userList.add(
      User(user['name'], user['lastName'], user['province'],
          [user['phone_number']]),
    );
    print('Added user: $userList');
    province.add(user['province']);
  }

  updateData(User newUser) {
    userList.value = userList.map((User userItem) {
      if (newUser.name == userItem.name) {
        userItem = newUser;
      }
      return newUser;
    }).toList();
  }

//สร้างปุ่มลบข้อมูล
//โดยรับค่า index
//.removeAt
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
