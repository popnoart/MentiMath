import 'dart:math';
import '../models/operation.dart';

class OperationGenerator {
  final Random _random = Random();

  // Generar operación con nivel específico
  MathOperation generateOperationWithLevel(
    OperationType type,
    DifficultyLevel difficulty,
  ) {
    switch (type) {
      case OperationType.suma:
        return _generateSumaWithLevel(difficulty);
      case OperationType.resta:
        return _generateRestaWithLevel(difficulty);
      case OperationType.multiplicacion:
        return _generateMultiplicacionWithLevel(difficulty);
      case OperationType.division:
        return _generateDivisionWithLevel(difficulty);
    }
  }

  // Generar múltiples operaciones con nivel específico
  List<MathOperation> generateOperationsWithLevel(
    OperationType type,
    DifficultyLevel difficulty,
    int count,
  ) {
    List<MathOperation> operations = [];

    for (int i = 0; i < count; i++) {
      operations.add(generateOperationWithLevel(type, difficulty));
    }

    return operations;
  }

  // Generar operación mixta con nivel específico
  MathOperation generateMixedOperationWithLevel(DifficultyLevel difficulty) {
    final types = OperationType.values;
    final randomType = types[_random.nextInt(types.length)];
    return generateOperationWithLevel(randomType, difficulty);
  }

  // Generar múltiples operaciones mixtas con nivel específico
  List<MathOperation> generateMixedOperationsWithLevel(
    DifficultyLevel difficulty,
    int count,
  ) {
    List<MathOperation> operations = [];

    for (int i = 0; i < count; i++) {
      operations.add(generateMixedOperationWithLevel(difficulty));
    }

    return operations;
  }

  // ========== GENERADORES POR NIVEL ==========

  MathOperation _generateSumaWithLevel(DifficultyLevel difficulty) {
    int num1, num2;

    switch (difficulty) {
      case DifficultyLevel.facil:
        // Nivel 1: dos números de 1 cifra (0-9)
        num1 = _random.nextInt(10);
        num2 = _random.nextInt(10);
        break;

      case DifficultyLevel.medio:
        // Nivel 2: un número de 2 cifras y otro de 1 cifra
        num1 = _random.nextInt(90) + 10; // 10-99 (2 cifras)
        num2 = _random.nextInt(10); // 0-9 (1 cifra)
        break;

      case DifficultyLevel.dificil:
        // Nivel 3: dos números de 2 cifras (0-99)
        num1 = _random.nextInt(100);
        num2 = _random.nextInt(100);
        break;
    }

    return MathOperation(
      type: OperationType.suma,
      difficulty: difficulty,
      num1: num1,
      num2: num2,
    );
  }

  MathOperation _generateRestaWithLevel(DifficultyLevel difficulty) {
    int num1, num2;

    switch (difficulty) {
      case DifficultyLevel.facil:
        // Nivel 1: dos números de 1 cifra (0-9), sin negativos
        num1 = _random.nextInt(10);
        num2 = _random.nextInt(num1 + 1); // Asegura num2 <= num1
        break;

      case DifficultyLevel.medio:
        // Nivel 2: un número de 2 cifras y otro de 1 cifra, sin negativos
        num1 = _random.nextInt(90) + 10; // 10-99 (2 cifras)
        num2 = _random.nextInt(10); // 0-9 (1 cifra)
        // Asegurar que num1 >= num2 (sin negativos)
        if (num1 < num2) {
          final temp = num1;
          num1 = num2;
          num2 = temp;
        }
        break;

      case DifficultyLevel.dificil:
        // Nivel 3: dos números de 2 cifras (0-99), sin negativos
        num1 = _random.nextInt(100);
        num2 = _random.nextInt(num1 + 1); // Asegura num2 <= num1
        break;
    }

    return MathOperation(
      type: OperationType.resta,
      difficulty: difficulty,
      num1: num1,
      num2: num2,
    );
  }

  MathOperation _generateMultiplicacionWithLevel(DifficultyLevel difficulty) {
    int num1, num2;

    switch (difficulty) {
      case DifficultyLevel.facil:
        // Nivel 1: tablas básicas (0-5)
        num1 = _random.nextInt(6); // 0-5
        num2 = _random.nextInt(6); // 0-5
        break;

      case DifficultyLevel.medio:
        // Nivel 2: tablas completas (0-10)
        num1 = _random.nextInt(11); // 0-10
        num2 = _random.nextInt(11); // 0-10
        break;

      case DifficultyLevel.dificil:
        // Nivel 3: multiplicación con números de 2 cifras × 1 cifra
        num1 = _random.nextInt(90) + 10; // 10-99 (2 cifras)
        num2 = _random.nextInt(10); // 0-9 (1 cifra)
        break;
    }

    return MathOperation(
      type: OperationType.multiplicacion,
      difficulty: difficulty,
      num1: num1,
      num2: num2,
    );
  }

  MathOperation _generateDivisionWithLevel(DifficultyLevel difficulty) {
    // Divisiones básicas: cociente de 1 cifra, resto 0
    int cociente = _random.nextInt(9) + 1; // 1-9
    int divisor = _random.nextInt(9) + 1; // 1-9
    int dividendo = cociente * divisor;
    
    return MathOperation(
      type: OperationType.division,
      difficulty: DifficultyLevel.facil,
      num1: dividendo,
      num2: divisor,
    );
  }

  // ========== MÉTODOS DE COMPATIBILIDAD ==========

  List<MathOperation> generateOperations(OperationType type, int count) {
    // Por defecto, usa nivel medio
    return generateOperationsWithLevel(type, DifficultyLevel.medio, count);
  }

  List<MathOperation> generateMixedOperations(int count) {
    // Por defecto, usa nivel medio
    return generateMixedOperationsWithLevel(DifficultyLevel.medio, count);
  }
}
