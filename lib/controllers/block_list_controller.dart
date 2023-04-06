import 'package:clust/models/block_list_model.dart';

import 'api_helper.dart';

class BlockListController {
  String path = "blockList/";
  Future<List<BlockList>> getAll() async {
    dynamic jsonObject = await ApiHelper().get(path);
    List<BlockList> result = [];
    jsonObject.forEach((json) {
      result.add(BlockList.fromJson(json));
    });
    return result;
  }

  Future<BlockList> getByID(int id) async {
    dynamic jsonObject = await ApiHelper().get("$path$id");
    BlockList result = BlockList.fromJson(jsonObject);
    return result;
  }

  Future<BlockList> create(BlockList blockList) async {
    dynamic jsonObject = await ApiHelper().post(path, body: blockList.toJson());
    BlockList result = BlockList.fromJson(jsonObject);
    return result;
  }

  Future<BlockList> update(BlockList blockList) async {
    dynamic jsonObject = await ApiHelper().put(path, blockList.toJson());
    BlockList result = BlockList.fromJson(jsonObject);
    return result;
  }

  Future<void> distroy(int id) async {
    dynamic jsonObject = await ApiHelper().delete("$path$id");
    // BlockList result = BlockList.fromJson(jsonObject);
    // return result;
  }
}
