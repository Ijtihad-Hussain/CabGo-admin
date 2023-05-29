class Riders {
  String name;
  String email;
  String phoneNumber;

  Riders({required this.name, required this.email, required this.phoneNumber});
}

final List<Riders> riders = [
  Riders(name: 'John Doe', email: 'johndoe@email.com', phoneNumber: '555-555-5555'),
  Riders(name: 'Jane Doe', email: 'janedoe@email.com', phoneNumber: '555-555-5556'),
  Riders(name: 'Jim Brown', email: 'jimbrown@email.com', phoneNumber: '555-555-5557'),
  Riders(name: 'Julie Smith', email: 'juliesmith@email.com', phoneNumber: '555-555-5558'),
  Riders(name: 'Jim Wilson', email: 'jimwilson@email.com', phoneNumber: '555-555-5559'),
];