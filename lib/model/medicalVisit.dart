class MedicalVisit {
  final specialist;
  final address;
  final date;
  final observations;

  const MedicalVisit(
      {this.specialist, this.address, this.date, this.observations});

  MedicalVisit.fromJson(Map<String, dynamic> json)
      : specialist = json['specialist'],
        address = json['address'],
        date = json['datetime'],
        observations = json['observations'];
}
