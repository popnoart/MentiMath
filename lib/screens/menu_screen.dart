import 'package:flutter/material.dart';
import 'package:mentimath/screens/level_selection_screen.dart';
import 'package:mentimath/models/operation.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MentiMath - Cálculo Mental'),
        centerTitle: true,
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
                  '¡Practica Cálculo Mental!',
                  style: TextStyle(
                    fontSize: 32,
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
              _buildMenuButton(
                context,
                '➕ Sumas',
                OperationType.suma,
                Colors.green,
              ),
              const SizedBox(height: 20),
              _buildMenuButton(
                context,
                '➖ Restas',
                OperationType.resta,
                Colors.orange,
              ),
              const SizedBox(height: 20),
              _buildMenuButton(
                context,
                '✖️ Multiplicaciones',
                OperationType.multiplicacion,
                Colors.purple,
              ),
              const SizedBox(height: 20),
              _buildMenuButton(
                context,
                '➗ Divisiones',
                OperationType.division,
                Colors.deepPurple,
              ),
              const SizedBox(height: 20),
              _buildMenuButton(
                context,
                '🎯 Mixto',
                null,
                Colors.red,
              ),
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Ahora con 3 niveles de dificultad:\n'
                  '• 🥇 Fácil: Números pequeños\n'
                  '• 🥈 Medio: Un número grande\n'
                  '• 🥉 Difícil: Dos números grandes\n'
                  '\nControles:\n'
                  '• Swipe → Siguiente operación\n'
                  '• Swipe ← Operación anterior\n'
                  '• Swipe ↓ Ver respuesta',
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

  Widget _buildMenuButton(
    BuildContext context,
    String text,
    OperationType? type,
    Color color,
  ) {
    return SizedBox(
      width: 300,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LevelSelectionScreen(operationType: type),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 8,
          shadowColor: Colors.black.withOpacity(0.3),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
