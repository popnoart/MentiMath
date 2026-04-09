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
        return 'Sumas';
      case OperationType.resta:
        return 'Restas';
      case OperationType.multiplicacion:
        return 'Multiplicaciones';
      case OperationType.division:
        return 'Divisiones';
    }
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
            colors: [Color(0xFF4CAF50), Color(0xFF2196F3)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Selecciona el nivel de dificultad',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              _buildLevelButton(
                context,
                '🥇 Nivel Fácil',
                'Dos números de 1 cifra\n(0-9)',
                DifficultyLevel.facil,
                Colors.green,
              ),
              const SizedBox(height: 20),
              _buildLevelButton(
                context,
                '🥈 Nivel Medio',
                'Un número de 2 cifras\n y otro de 1',
                DifficultyLevel.medio,
                Colors.orange,
              ),
              const SizedBox(height: 20),
              _buildLevelButton(
                context,
                '🥉 Nivel Difícil',
                'Dos números de 2 cifras\n(0-99)',
                DifficultyLevel.dificil,
                Colors.red,
              ),
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Para multiplicaciones:\n'
                  '• Fácil: Tablas 0-5\n'
                  '• Medio: Tablas 0-10\n'
                  '• Difícil: Número de 2 cifras × 1 cifra',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelButton(
    BuildContext context,
    String title,
    String description,
    DifficultyLevel level,
    Color color,
  ) {
    return SizedBox(
      width: 300,
      child: ElevatedButton(
        onPressed: () {
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
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 8,
          shadowColor: Colors.black.withOpacity(0.3),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
