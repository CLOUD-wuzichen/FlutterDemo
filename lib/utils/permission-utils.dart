import 'package:permission_handler/permission_handler.dart';

class PermissionType {
  static const PermissionGroup camera = PermissionGroup.camera;
  static const PermissionGroup contacts = PermissionGroup.contacts;
  static const PermissionGroup location = PermissionGroup.location;
  static const PermissionGroup phone = PermissionGroup.phone;
  static const PermissionGroup photos = PermissionGroup.photos;
  static const PermissionGroup storage = PermissionGroup.storage;
}

class PermissionUtils {
  static const int denied_forever = -2;
  static const int denied = -1;
  static const int granted = 0;

  static Future<int> checkPermission(PermissionGroup name) async {
    int result = denied;
    PermissionStatus status =
        await PermissionHandler().checkPermissionStatus(name);
    bool isShown = await PermissionHandler().shouldShowRequestPermissionRationale(name);
    if (status == PermissionStatus.granted) {
      result = granted;
    } else {
      Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler().requestPermissions([name]);
      permissions.forEach((item, status) {
        if (item == name) {
          result = changeStatus(status,isShown);
        }
      });
    }
    return result;
  }

  static int changeStatus(PermissionStatus status, bool isShown) {
    switch (status) {
      case PermissionStatus.granted:
        return granted;
        break;
      case PermissionStatus.denied:
        if(isShown){
          //可选不再显示
          return denied;
        }else{
          //永久拒绝
          return denied_forever;
        }
        break;
      case PermissionStatus.disabled:
        return denied;
        break;
      case PermissionStatus.restricted:
        return denied;
        break;
      default:
        return denied;
    }
  }
}
