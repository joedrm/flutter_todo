/// tb: 同比指数
/// hb: 环比指数
/// dj: 定基指数
enum IndexType { tb, hb, dj }

extension IndexTypeExtension on IndexType {
  String get name {
    switch (this) {
      case IndexType.tb:
        return "同比";
      case IndexType.hb:
        return "环比";
      case IndexType.dj:
        return "定基";
    }
  }

  String get typeCode {
    switch(this){
      case IndexType.tb:
        return 'A010804';
      case IndexType.hb:
        return 'A010805';
      case IndexType.dj:
        return 'A01080S';
    }
  }
}
