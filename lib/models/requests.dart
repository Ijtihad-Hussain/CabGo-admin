class Requests {
  String riderName;
  String dateTime;
  String driverName;

  Requests({required this.riderName, required this.dateTime, required this.driverName});
}

final List<Requests> requests = [
  Requests(riderName: 'John Doe', dateTime: '2022-05-01 10:00', driverName: 'Mr. Smith'),
  Requests(riderName: 'Jane Doe', dateTime: '2022-05-02 11:00', driverName: 'Mr. Johnson'),
  Requests(riderName: 'Jim Brown', dateTime: '2022-05-03 12:00', driverName: 'Mr. Brown'),
  Requests(riderName: 'Julie Smith', dateTime: '2022-05-04 13:00', driverName: 'Mr. Williams'),
  Requests(riderName: 'Jim Wilson', dateTime: '2022-05-05 14:00', driverName: 'Mr. Wilson'),
];
