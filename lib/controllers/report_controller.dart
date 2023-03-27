
import '../models/report_model.dart';
import 'api_helper.dart';

class ReportController {
  String path = "report/";
  Future<List<Report>> getAll() async {
    dynamic jsonObject = await ApiHelper().get(path);
    List<Report> result = [];
    jsonObject.forEach((json) {
      result.add(Report.fromJson(json));
    });
    return result;
  }

  Future<Report> getByID(int id) async {
    dynamic jsonObject = await ApiHelper().get("$path$id");
    Report result = Report.fromJson(jsonObject);
    return result;
  }

  Future<Report> create(Report report) async {
    dynamic jsonObject =
        await ApiHelper().post(path, report.toJson());
    Report result = Report.fromJson(jsonObject);
    return result;
  }

  Future<Report> update(Report report) async {
    dynamic jsonObject =
        await ApiHelper().put(path, report.toJson());
    Report result = Report.fromJson(jsonObject);
    return result;
  }

  Future<void> destroy(int id) async {
    dynamic jsonObject = await ApiHelper().delete("$path$id");
    // Report result = Report.fromJson(jsonObject);
    // return result;
  }

}