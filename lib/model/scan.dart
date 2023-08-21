import 'my_user.dart';

class ScanModel {
  static int idIncrement = 0;
  final String id;
  final DateTime date;
  final String? endHour;
  final MyUserModel data;

  ScanModel({
    required this.id,
    required this.date,
    this.endHour,
    required this.data,
  });

  static List<ScanModel> scans = [];
}
