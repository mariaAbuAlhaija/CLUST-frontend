
// import '../models/report_model.dart';
// import 'api_helper.dart';

// class ReportController {
//   Future<List<Report>> getAll() async {
//     dynamic jsonObject = await ApiHelper(domain: '').getReports();
//     List<Report> result = [];
//     jsonObject.forEach((json) {
//       result.add(Report.fromJson(json));
//     });
//     return result;
//   }

//   Future<Report> getByID(int id) async {
//     dynamic jsonObject = await ApiHelper(domain: '').getReport(id);
//     Report result = Report.fromJson(jsonObject);
//     return result;
//   }

// //   Future<Report> createReport(Report report) async {
// //   dynamic jsonObject = await ApiHelper(domain: '').postReport(report);
// //   Report result = Report.fromJson(jsonObject);
// //   return result;
// // }

// }