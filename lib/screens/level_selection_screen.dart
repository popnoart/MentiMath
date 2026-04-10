import 'package:flutter/material.dart';
import 'package:mentimath/models/operation.dart';
import 'package:mentimath/screens/practice_screen.dart';

class LevelSelectionScreen extends StatelessWidget {
  final OperationType? operationType;

  const LevelSelectionScreen({super.key, this.operationType});

  String _getOperationName() {
    if (operationType == null) {
      return 'Operaciones Mixtas';
    }
    switch (operationType!) {
      case OperationType.suma:
        return 'Sumar';
      case OperationType.resta:
        return 'Restar';
      case OperationType.multiplicacion:
        return 'Multiplicar';
      case OperationType.division:
        return 'Dividir';
    }
  }

  Widget _buildLevelCard(
    BuildContext context,
    String title,
    String description,
    Color color,
    DifficultyLevel level,
  ) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PracticeScreen(
                  operationType: operationType,
                  difficultyLevel: level,
                ),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color.withOpacity(0.1),
                  color.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: color.withOpacity(0.2), width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: color,
                      size: 24,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'COMENZAR',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_getOperationName()} - Selecciona Nivel'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  'Elige el nivel de dificultad:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Cada nivel tiene operaciones adaptadas a la edad',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 30),
                _buildLevelCard(
                  context,
                  'FÁCIL',
                  'Perfecto para empezar:\n• Sumas/Restas: Dos números de 1 cifra (0-9)\n• Multiplicaciones: Tablas básicas (0-5)\n• Divisiones: Cociente de 1 cifra, resto 0',
                  Colors.green,
                  DifficultyLevel.facil,
                ),
                const SizedBox(height: 20),
                _buildLevelCard(
                  context,
                  'MEDIO',
                  'Desafío intermedio:\n• Sumas/Restas: Un número de 2 cifras (10-99) y otro de 1 cifra (0-9)\n• Multiplicaciones: Tablas completas (0-10)',
                  Colors.orange,
                  DifficultyLevel.medio,
                ),
                const SizedBox(height: 20),
                _buildLevelCard(
                  context,
                  'DIFÍCIL',
                  'Para expertos:\n• Sumas/Restas: Dos números de 2 cifras (0-99)\n• Multiplicaciones: Número de 2 cifras × 1 cifra',
                  Colors.red,
                  DifficultyLevel.dificil,
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.blue[200]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '💡 Consejo:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Empieza con el nivel Fácil y ve subiendo según vayas mejorando. ¡La práctica hace al maestro!',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue[700],
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
