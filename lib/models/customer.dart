import 'person.dart';

class Customer extends Person {
  Customer(String name, String email, String phone) : super(name, email, phone);

  @override
  String getRole() => "Customer";
}
