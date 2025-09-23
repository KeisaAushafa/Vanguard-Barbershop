import 'person.dart';

class Employee extends Person {
  String _position;

  Employee(String name, String email, String phone, this._position)
      : super(name, email, phone);

  String get position => _position;
  set position(String value) => _position = value;

  @override
  String getRole() => "Employee ($_position)";
}
