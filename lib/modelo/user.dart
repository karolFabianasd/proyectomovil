class User {
  String nombre;
  String apellido;
  String telefono;
  String correo;
  String password;


  User({required this.nombre, required this.apellido, required this.telefono, required this.correo, required this.password});

  // Método para convertir un mapa (json) en un objeto Registro
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      nombre: json['nombre'],
      apellido: json['apellido'],
      telefono: json['telefono'],
      correo: json['correo'],
      password: json['password'],
    );
  }

  // Método para convertir un objeto Registro en un mapa (json)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombre'] = this.nombre;
    data['apellido'] = this.apellido;
    data['telefono'] = this.telefono;
    data['correo'] = this.correo;
    data['password'] = this.password;
    return data;
  }
}