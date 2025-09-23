class Person {
  String name;
  String email;
  String phone;

  Person(this.name, this.email, this.phone);

  String getRole() => "Person";

  @override
  String toString() {
    return "Name: $name, Email: $email, Phone: $phone, Role: ${getRole()}";
  }
}

class Customer extends Person {
  Customer(String name, String email, String phone) : super(name, email, phone);

  @override
  String getRole() => "Customer";
}

class Employee extends Person {
  String position;

  Employee(String name, String email, String phone, this.position)
      : super(name, email, phone);

  @override
  String getRole() => "Employee ($position)";
}
