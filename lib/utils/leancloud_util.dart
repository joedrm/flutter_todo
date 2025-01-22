// import 'package:leancloud_storage/leancloud.dart';

class LeanCloudUtil {
  static String dichanNews = "dichan_news";

  static initSDK() {
    // LeanCloud.initialize(
    //     "ksBmXTHr6nNKU3BcqV1EZHUh-gzGzoHsz", "ZNf7lcaQv2n9y8ita2xwZkzz",
    //     server: "https://dichan.nnxkcloud.com", queryCache: LCQueryCache());
  }

  // static Future<List<LCObject>> query(String className, int limit, {int skip = 0}) async {
    // LCQuery<LCObject> query = LCQuery<LCObject>(className);
    // query.limit(limit);
    // query.orderByDescending('createdAt');
    // query.skip(skip);
    // return await query.find() ?? [];
  // }


  // static Future<List<LCObject>> findOneMusic(
  //     String playId, String source) async {
  //   LCQuery<LCObject> query = LCQuery<LCObject>(LeanCloudUtil.dichanNews);
  //   query.whereEqualTo("playId", playId);
  //   query.whereEqualTo("source", source);
  //   return await query.find() ?? [];
  // }
}
