// 定义设备行为接口
abstract class SmartDevice {
  void turnOn(); // 打开设备
  void turnOff() {} // 关闭设备
  bool getStatus(); // 查询设备状态
}

enum DeviceType implements SmartDevice {
  // 嵌套枚举表示灯光子类型
  // enum LightType {
  //   standard('普通灯'),
  //   ambient('氛围灯');
  //
  //   final String description;
  //   const LightType(this.description);
  // };

  lamp("灯光", "lamp_icon", 1, true), // 灯光
  airConditioner("空调", "air_conditioner_icon", 2, true), // 空调
  camera("摄像头", "camera_icon", 3, false), // 摄像头
  doorLock("智能门锁", "door_lock_icon", 4, true), // 智能门锁
  gateway("网关", "gateway_icon", 5, false), // 网关
  fridge("冰箱", "fridge_icon", 6, true), // 冰箱
  unknown("", "", -1, false);

  final String title;
  final String icon;
  final int value;
  final bool isGroup;
  final String desc;

  const DeviceType(this.title, this.icon, this.value, this.isGroup,
      {this.desc = ""});

  factory DeviceType.fromValue(int value) {
    return DeviceType.values.firstWhere((type) => type.value == value,
        orElse: () => DeviceType.lamp);
  }

  static const defaultDeviceType = DeviceType.unknown;

  static DeviceType withValue(int value) {
    return DeviceType.values.firstWhere((type) => type.value == value,
        orElse: () => DeviceType.unknown);
  }

  void performCustomAction(String command) {
    switch (this) {
      case DeviceType.lamp:
        print('$name：$command 灯光已调整亮度。');
        break;
      case DeviceType.airConditioner:
        print('$name：$command 温度设置成功。');
        break;
      case DeviceType.camera:
        print('$name：$command 已启动录像。');
        break;
      case DeviceType.doorLock:
        print('$name：$command 门锁状态已更新。');
        break;
      case DeviceType.gateway:
        print('$name：$command 网关已上线。');
        break;
      case DeviceType.fridge:
        print('$name：$command 冰箱门已关闭。');
        break;
      case DeviceType.unknown:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  // 设备状态存储在 Map 中
  static final Map<DeviceType, bool> _deviceStates = {
    DeviceType.lamp: false,
    DeviceType.airConditioner: false,
    DeviceType.camera: false,
    DeviceType.doorLock: false,
    DeviceType.gateway: false,
    DeviceType.fridge: false,
  };

  @override
  bool getStatus() => _deviceStates[this] ?? false;

  @override
  void turnOff() {
    _deviceStates[this] = false;
  }

  @override
  void turnOn() {
    _deviceStates[this] = true;
  }
}

final List<Map<String, dynamic>> allDeviceTypes = [
  {
    "name": "灯",
    "value": 1,
    "type": DeviceType.lamp,
    "icon": "lamp_icon",
    "is_group": true
  },
  //...
];

/// 这里将上面的 List 转成 Map
/// 其结构为：{"lamp": {"name":"灯","value":1,"type":DeviceType.lamp,"icon":"lamp_icon","is_group":true}}
Map<String, dynamic> get allDeviceTypesMap => allDeviceTypes.asMap().map(
    (key, value) => MapEntry((value["type"] as DeviceType).typeName, value));

extension DeviceTypeExtension on DeviceType {
  String get typeName => toString().split(".").last;

  int get value => allDeviceTypesMap[typeName]["value"];

  String get name => allDeviceTypesMap[typeName]["name"];

  String get icon => allDeviceTypesMap[typeName]["icon"];
}

mixin Loggable {
  void log(String message) {
    print('[Log] $message');
  }
}

enum DeviceStatus with Loggable {
  active('设备正在运行'),
  inactive('设备未激活'),
  error('设备出现故障');

  final String desc;

  const DeviceStatus(this.desc);

  void performAction() {
    log('当前状态：$desc');
    switch (this) {
      case DeviceStatus.active:
        print('执行运行中的逻辑...');
        break;
      case DeviceStatus.inactive:
        print('执行未激活时的逻辑...');
        break;
      case DeviceStatus.error:
        print('执行故障处理逻辑...');
        break;
    }
  }
}

enum DeviceAttribute<T> {
  // 灯的属性，有亮度、色温
  brightness<int>(),
  colorTemperature<int>(),

  // 冰箱的属性，有当前温度、目标温度
  currentTemperature<double>(),
  targetTemperature<double>();

  const DeviceAttribute();
}

class Device {
  /// 设备类型
  DeviceType? type;

  /// 存储不同设备类型的属性
  Map<DeviceAttribute, dynamic>? properties;

  // 获取设备属性
  T? getProperty<T>(DeviceAttribute<T> property) {
    return properties?[property] as T?;
  }

  // 设置设备属性
  void setProperty<T>(DeviceAttribute<T> property, T value) {
    properties?[property] = value;
  }

  Device.fromJson(Map<String, dynamic> json) {
    type = DeviceType.fromValue(json["value"]);
    Map<String, dynamic> attribute = json["attribute"];
    switch (type) {
      case DeviceType.lamp:
        setProperty<int>(DeviceAttribute.brightness, attribute["brightness"]);
        setProperty<int>(
            DeviceAttribute.colorTemperature, attribute["colorTemperature"]);
        break;
      case DeviceType.fridge:
        setProperty<double>(DeviceAttribute.currentTemperature,
            attribute["currentTemperature"]);
        setProperty<double>(
            DeviceAttribute.targetTemperature, attribute["targetTemperature"]);
        break;
      default:
        break;
    }
  }
}

main() {
  print(allDeviceTypesMap);
  print(DeviceType.fromValue(2));
  DeviceType.lamp.performCustomAction("brightness to 80%");

  DeviceType.lamp.turnOn();
  print(DeviceType.lamp.getStatus());

  // 模拟从接口返回的数据
  Map<String, dynamic> json = {};
  // 创建一个灯设备
  var device = Device.fromJson(json);
  var brightness = device.getProperty<int>(DeviceAttribute.brightness);
  print(brightness);
}
