class Customer {
  final String firstname;
  final String lastname;
  final String email;
  final String password;

  Customer(this.email, this.password, this.firstname, this.lastname);
}

class CustomerRegisterDto {
  final String firstname;
  final String lastname;
  final String email;
  final String password;

  CustomerRegisterDto(this.email, this.password, this.firstname, this.lastname);
}

class CustomerLoginDto {
  final String email;
  final String password;

  CustomerLoginDto(this.email, this.password);
}
