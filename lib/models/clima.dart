class Clima {
  final String cidade;
  final String estado;
  final double temperatura;
  final double umidade;
  final String descricao;
  final String icone;

  Clima({
    required this.cidade,
    required this.estado,
    required this.temperatura,
    required this.umidade,
    required this.descricao,
    required this.icone,
  });

  factory Clima.fromJson(Map<String, dynamic> json) {
    return Clima(
      cidade: json['name'] as String? ?? '',
      estado: json['sys']?['country'] as String? ?? '',
      temperatura: (json['main']?['temp'] as num?)?.toDouble() ?? 0.0,
      umidade: (json['main']?['humidity'] as num?)?.toDouble() ?? 0.0,
      descricao: (json['weather'] as List<dynamic>?)?[0]?['description'] as String? ?? '',
      icone: (json['weather'] as List<dynamic>?)?[0]?['icon'] as String? ?? '',
    );
  }
}

