import 'dart:collection';

class SafeList<T> extends ListBase<T> {
  final List<T> _list;
  // 调用 set 方法修改 length 的时候，若大于当前数组的长度时，就使用 defaultValue 填充
  final T defaultValue;

  // 在数组中查询不存在的值时，即数组越界时，返回 absentValue
  final T absentValue;

  SafeList({
    required this.defaultValue,
    required this.absentValue,
    List<T>? values,
  }) : _list = values ?? [];

  @override
  T operator [](int index) => index < _list.length ? _list[index] : absentValue;

  @override
  void operator []=(int index, T value) => _list[index] = value;

  @override
  int get length => _list.length;

  @override
  T get first => _list.isNotEmpty ? _list.first : absentValue;

  @override
  T get last => _list.isNotEmpty ? _list.last : absentValue;

  @override
  set length(int newValue) {
    if (newValue < _list.length) {
      _list.length = newValue;
    } else {
      _list.addAll(List.filled(newValue - _list.length, defaultValue));
    }
  }
}