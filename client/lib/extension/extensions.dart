import '../const/enums.dart';

extension GetKey on Map {
  keyAt(int index) => keys.elementAt(index);
  valueAt(int index) => values.elementAt(index);
}

extension MapFromString on String {
  toMap() {
    final newStr = replaceAll(RegExp(r'[^\w\s]+'), '').split(' ');
    final keys = [];
    final values = [];
    for (int i = 0; i < newStr.length; i++) {
      if (i.isEven) {
        keys.add(int.parse(newStr[i]));
      } else {
        values.add(int.parse(newStr[i]));
      }
    }
    Map<int, int> map = {};
    for (int i = 0; i < keys.length; i++) {
      map[keys[i]] = values[i];
    }
    return map;
  }

  toOrderStatus() {
    final newStr = replaceAll(RegExp(r'[^\w\s]+'), ' ').split(' ');
    switch (newStr[1]) {
      case 'creationInProggress':
        return OrderStatus.creationInProggress;
      case 'readyForDelivery':
        return OrderStatus.readyForDelivery;
      case 'issued':
        return OrderStatus.issued;
      default:
        return null;
    }
  }
}
