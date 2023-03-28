import 'package:clust/models/block_list_model.dart';

import 'api_helper.dart';

class BlockListController {
  String domain = "192.168.1.24:3333";
  String path = "blockList/";
  Future<List<BlockList>> getAll() async {
    dynamic jsonObject = await ApiHelper(domain: domain).get(path);
    List<BlockList> result = [];
    jsonObject.forEach((json) {
      result.add(BlockList.fromJson(json));
    });
    return result;
  }

  Future<BlockList> getByID(int id) async {
    dynamic jsonObject = await ApiHelper(domain: domain).get("$path$id");
    BlockList result = BlockList.fromJson(jsonObject);
    return result;
  }

  Future<BlockList> create(BlockList blockList) async {
    dynamic jsonObject =
        await ApiHelper(domain: domain).post(path, blockList.toJson());
    BlockList result = BlockList.fromJson(jsonObject);
    return result;
  }

  Future<BlockList> update(BlockList blockList) async {
    dynamic jsonObject =
        await ApiHelper(domain: domain).put(path, blockList.toJson());
    BlockList result = BlockList.fromJson(jsonObject);
    return result;
  }

  Future<void> distroy(int id) async {
    dynamic jsonObject = await ApiHelper(domain: domain).delete("$path$id");
    // BlockList result = BlockList.fromJson(jsonObject);
    // return result;
  }
}
