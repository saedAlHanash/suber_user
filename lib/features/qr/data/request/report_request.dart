
class ReportRequest {
  ReportRequest({
    required this.busId,
    required this.tripId,
    required this.busMemberId,
  });

  int busId;
  int tripId;
  int busMemberId;


  factory ReportRequest.fromJson(Map<String, dynamic> json) {
    return ReportRequest(
      busId: json["busId"] ?? 0,
      tripId: json["tripId"] ?? 0,
      busMemberId: json["busMemberId"] ?? 0,

    );
  }

  Map<String, dynamic> toJson() => {
        "busId": busId,
        "tripId": tripId,
        "busMemberId": busMemberId,

      };
}
