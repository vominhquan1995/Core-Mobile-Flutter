// class NotificationModel {
//   int notifi_id;
//   String tieu_de;
//   String noi_dung;
//   String noi_dung_html;
//   String time_sent;
//   String time_create;
//   bool is_view;
//   NotificationModel(params) {
//     notifi_id = int.parse(params['notifi_id']);
//     tieu_de = params['tieu_de'];
//     noi_dung = params['noi_dung'];
//     noi_dung_html = params['noi_dung_html'];
//     time_sent = params['time_sent'];
//     time_create = params['time_create'];
//     is_view = params['is_view'];
//   }
//   NotificationModel.isView(params) {
//     tieu_de = params['tieu_de'];
//     noi_dung = params['noi_dung'];
//     noi_dung_html = params['noi_dung_html'];
//     time_sent = params['time_sent'];
//     time_create = params['time_create'];
//     is_view = params['is_view'];
//   }
// }

class NotificationModel {
  String notifiid;
  String tieude;
  String noidung;
  String noidunghtml;
  String timesent;
  String timecreate;
  bool isview;
  NotificationModel(
      {this.notifiid = '',
      this.tieude = '',
      this.noidung = '',
      this.noidunghtml = '',
      this.timecreate = '',
      this.timesent = '',
      this.isview = false});
}
