// 抽象工厂：家具工厂
import 'package:flutter/cupertino.dart';
import 'dart:developer' as devtools show log;

abstract class FurnitureFactory {
  Sofa createSofa();

  Table createTable();

  Chair createChair();
}

// 产品接口：沙发
abstract class Sofa {
  void describe();
}

// 产品接口：桌子
abstract class Table {
  void describe();
}

// 产品接口：椅子
abstract class Chair {
  void describe();
}

// 现代风格家具工厂
class ModernFurnitureFactory implements FurnitureFactory {
  @override
  Sofa createSofa() {
    return ModernSofa();
  }

  @override
  Table createTable() {
    return ModernTable();
  }

  @override
  Chair createChair() {
    return ModernChair();
  }
}

// 欧式风格家具工厂
class EuropeanFurnitureFactory implements FurnitureFactory {
  @override
  Sofa createSofa() {
    return EuropeanSofa();
  }

  @override
  Table createTable() {
    return EuropeanTable();
  }

  @override
  Chair createChair() {
    return EuropeanChair();
  }
}

// 现代风格沙发
class ModernSofa implements Sofa {
  @override
  void describe() {
    print('A modern style sofa');
  }
}

// 现代风格桌子
class ModernTable implements Table {
  @override
  void describe() {
    print('A modern style table');
  }
}

// 现代风格椅子
class ModernChair implements Chair {
  @override
  void describe() {
    print('A modern style chair');
  }
}

// 欧式风格沙发
class EuropeanSofa implements Sofa {
  @override
  void describe() {
    print('A European style sofa');
  }
}

// 欧式风格桌子
class EuropeanTable implements Table {
  @override
  void describe() {
    print('A European style table');
  }
}

// 欧式风格椅子
class EuropeanChair implements Chair {
  @override
  void describe() {
    print('A European style chair');
  }
}

void createFurniture(FurnitureFactory factory) {
  final sofa = factory.createSofa();
  final table = factory.createTable();
  final chair = factory.createChair();

  sofa.describe();
  table.describe();
  chair.describe();
}

void main() {
  // 创建现代风格家具
  createFurniture(ModernFurnitureFactory());
  //  A modern style sofa
  //  A modern style table
  //  A modern style chair

  // 创建欧式风格家具
  createFurniture(EuropeanFurnitureFactory());
  // A European style sofa
  // A European style table
  // A European style chair
}

@immutable
class Person<P> {
  final String name;
  final P property;

  const factory Person(String name, P property) = Person.fromProperties;

  const Person.fromProperties(this.name, this.property);

  factory Person.fromPropertiesFactory(String name, P property) =>
      Person.fromProperties(name, property);

  static Person<P> fromPropertiesStatic<P>(String name, P property) =>
      Person.fromProperties(name, property);

  factory Person.fooBar(P property) =>
      Person.fromProperties('Foo Bar', property);

  static Person<P> bazQux<P>(P property) =>
      Person.fromProperties('Baz Qux', property);
}



