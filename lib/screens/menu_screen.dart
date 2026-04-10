import 'package:flutter/material.dart';
import 'package:mentimath/models/operation.dart';
import 'package:mentimath/screens/level_selection_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  Widget _buildMenuButton(
    BuildContext context,
    String text,
    OperationType? operationType,
    Color color,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LevelSelectionScreen(
                operationType: operationType,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          '🧮 MentiMath',
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Practica cálculo mental',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue[600],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  _buildMenuButton(
                    context,
                    '➕ Sumar',
                    OperationType.suma,
                    Colors.green,
                  ),
                  const SizedBox(height: 20),
                  _buildMenuButton(
                    context,
                    '➖ Restar',
                    OperationType.resta,
                    Colors.orange,
                  ),
                  const SizedBox(height: 20),
                  _buildMenuButton(
                    context,
                    '✖️ Multiplicar',
                    OperationType.multiplicacion,
                    Colors.purple,
                  ),
                  const SizedBox(height: 20),
                  _buildMenuButton(
                    context,
                    '➗ Dividir',
                    OperationType.division,
                    Colors.deepPurple,
                  ),
                  const SizedBox(height: 20),
                  _buildMenuButton(
                    context,
                    '🎯 Mixto',
                    null,
                    Colors.blue,
                  ),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '💡 ¿Cómo funciona?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '1. Elige una operación\n'
                          '2. Selecciona el nivel de dificultad\n'
                          '3. ¡Practica con swipe o botones!',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue[700],
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
