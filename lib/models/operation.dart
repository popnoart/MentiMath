enum OperationType {
  suma,
  resta,
  multiplicacion,
  division,
}

enum DifficultyLevel {
  facil,     // Nivel 1: dos números de 1 cifra (0-9)
  medio,     // Nivel 2: un número de 2 cifras y otro de 1 cifra
  dificil,   // Nivel 3: dos números de 2 cifras (0-99)
}

class MathOperation {
  final OperationType type;
  final DifficultyLevel difficulty;
  final int num1;
  final int num2;
  final int answer;
  bool isAnswered;

  MathOperation({
    required this.type,
    required this.difficulty,
    required this.num1,
    required this.num2,
  })  : answer = _calculateAnswer(type, num1, num2),
        isAnswered = false;

  static int _calculateAnswer(OperationType type, int num1, int num2) {
    switch (type) {
      case OperationType.suma:
        return num1 + num2;
      case OperationType.resta:
        return num1 - num2;
      case OperationType.multiplicacion:
        return num1 * num2;
      case OperationType.division:
        return num1 ~/ num2; // División entera (cociente)
    }
  }

  String get symbol {
    switch (type) {
      case OperationType.suma:
        return '+';
      case OperationType.resta:
        return '-';
      case OperationType.multiplicacion:
        return '×';
      case OperationType.division:
        return '÷';
    }
  }

  String get description {
    switch (type) {
      case OperationType.suma:
        return 'Suma';
      case OperationType.resta:
        return 'Resta';
      case OperationType.multiplicacion:
        return 'Multiplicación';
      case OperationType.division:
        return 'División';
    }
  }

  String get difficultyName {
    switch (difficulty) {
      case DifficultyLevel.facil:
        return 'Fácil';
      case DifficultyLevel.medio:
        return 'Medio';
      case DifficultyLevel.dificil:
        return 'Difícil';
    }
  }

  String get difficultyDescription {
    switch (difficulty) {
      case DifficultyLevel.facil:
        return 'Dos números de 1 cifra';
      case DifficultyLevel.medio:
        return 'Un número de 2 cifras y otro de 1';
      case DifficultyLevel.dificil:
        return 'Dos números de 2 cifras';
    }
  }

  // Para divisiones: verificar si la división es exacta
  bool get isDivisionExact {
    if (type != OperationType.division) return true;
    return num1 % num2 == 0;
  }

  // Para divisiones: obtener el resto
  int get remainder {
    if (type != OperationType.division) return 0;
    return num1 % num2;
  }

  // Texto completo para divisiones
  String get divisionText {
    if (type != OperationType.division) return toString();
    if (remainder == 0) {
      return '$num1 ÷ $num2 = $answer';
    } else {
      return '$num1 ÷ $num2 = $answer (resto $remainder)';
    }
  }

  bool get isCorrect => true; // Siempre correcta porque generamos la respuesta

  @override
  String toString() {
    if (type == OperationType.division) {
      return divisionText;
    }
    return '$num1 $symbol $num2 = $answer ($difficultyName)';
  }
}
