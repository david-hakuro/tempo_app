class Localizacao {
  final String id;
  final String cidade;
  final String estado;
  final DateTime dataCriacao;

  Localizacao({
    required this.id,
    required this.cidade,
    required this.estado,
    required this.dataCriacao,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cidade': cidade,
      'estado': estado,
      'dataCriacao': dataCriacao.toIso8601String(),
    };
  }

  factory Localizacao.fromJson(Map<String, dynamic> json) {
    return Localizacao(
      id: json['id'] as String,
      cidade: json['cidade'] as String,
      estado: json['estado'] as String,
      dataCriacao: DateTime.parse(json['dataCriacao'] as String),
    );
  }

  Localizacao copyWith({
    String? id,
    String? cidade,
    String? estado,
    DateTime? dataCriacao,
  }) {
    return Localizacao(
      id: id ?? this.id,
      cidade: cidade ?? this.cidade,
      estado: estado ?? this.estado,
      dataCriacao: dataCriacao ?? this.dataCriacao,
    );
  }
}

