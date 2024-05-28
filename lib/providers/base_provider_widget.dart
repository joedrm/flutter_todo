import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart' as provider;
// import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:flutter/foundation.dart' show immutable;

class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget? child) builder;
  final T model;
  final Widget child;
  final Function(T) onReady;

  const ProviderWidget({
    super.key,
    required this.model,
    required this.child,
    required this.onReady,
    required this.builder,
  });

  @override
  _ProviderWidgetState<T> createState() => _ProviderWidgetState<T>();
}

class _ProviderWidgetState<T extends ChangeNotifier>
    extends State<ProviderWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return provider.ChangeNotifierProvider<T>(
      create: (_) => widget.model,
      child: provider.Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}

Iterable<int> fibonacciSequence(int count) sync* {
  int a = 0;
  int b = 1;
  for (int i = 0; i < count; i++) {
    yield a; // 生成斐波那契数列中的当前值
    int temp = a + b; // 计算下一个值
    a = b;
    b = temp;
  }
}

void main() {
  // 生成前 10 个值
  Iterable<int> fibonacciNumbers = fibonacciSequence(10);
  for (int number in fibonacciNumbers) {
    print(number);
  }
}

