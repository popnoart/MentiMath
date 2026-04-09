import 'package:flutter/material.dart';
import 'package:mentimath/models/operation.dart';
import 'package:mentimath/services/operation_generator.dart';

class PracticeScreen extends StatefulWidget {
  final OperationType? operationType;
  final DifficultyLevel difficultyLevel;

  const PracticeScreen({
    super.key,
    this.operationType,
    this.difficultyLevel = DifficultyLevel.medio,
  });

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  final List<MathOperation> _operations = [];
  int _currentIndex = -1;
  final OperationGenerator _generator = OperationGenerator();

  @override
  void initState() {
    super.initState();
    _generateNewOperation();
  }

  void _generateNewOperation() {
    MathOperation newOperation;
    
    if (widget.operationType == null) {
      newOperation = _generator.generateMixedOperationWithLevel(widget.difficultyLevel);
    } else {
      newOperation = _generator.generateOperationWithLevel(
        widget.operationType!,
        widget.difficultyLevel,
      );
    }
    
    setState(() {
      _operations.add(newOperation);
      _currentIndex = _operations.length - 1;
    });
  }

  void _nextOperation() {
    if (_currentIndex == _operations.length - 1) {
      _generateNewOperation();
    } else {
      setState(() {
        _currentIndex++;
      });
    }
  }

  void _previousOperation() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  void _showAnswer() {
    if (_currentIndex >= 0) {
      setState(() {
        _operations[_currentIndex].isAnswered = true;
      });
    }
  }

  String _getOperationTitle() {
    if (widget.operationType == null) {
      return 'Mixtas - ${_getDifficultyName(widget.difficultyLevel)}';
    }
    if (_currentIndex >= 0) {
      return '${_operations[_currentIndex].description} - ${_operations[_currentIndex].difficultyName}';
    }
    return '${_getOperationTypeName(widget.operationType!)} - ${_getDifficultyName(widget.difficultyLevel)}';
  }

  String _getOperationTypeName(OperationType type) {
    switch (type) {
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

  String _getDifficultyName(DifficultyLevel level) {
    switch (level) {
      case DifficultyLevel.facil:
        return 'Fácil';
      case DifficultyLevel.medio:
        return 'Medio';
      case DifficultyLevel.dificil:
        return 'Difícil';
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasOperations = _currentIndex >= 0 && _operations.isNotEmpty;
    final currentOperation = hasOperations ? _operations[_currentIndex] : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(_getOperationTitle()),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            _previousOperation();
          } else if (details.primaryVelocity! < 0) {
            _nextOperation();
          }
        },
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! < 0) {
            _showAnswer();
          }
        },
        child: hasOperations
            ? _buildOperationCard(currentOperation!)
            : _buildLoadingScreen(),
      ),
      bottomNavigationBar: _buildBottomNavigation(hasOperations),
    );
  }

  Widget _buildLoadingScreen() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text(
            'Cargando operación...',
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildOperationCard(MathOperation operation) {
    return Container(
      color: Colors.grey[100],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Operación ${_currentIndex + 1} - ${operation.difficultyName}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              operation.difficultyDescription,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 30),
            _buildOperationDisplay(operation),
            const SizedBox(height: 60),
            _buildInstructions(),
          ],
        ),
      ),
    );
  }

  Widget _buildOperationDisplay(MathOperation operation) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            operation.num1.toString(),
            style: const TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            operation.symbol,
            style: const TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            operation.num2.toString(),
            style: const TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 4,
            width: 200,
            color: Colors.black,
          ),
          const SizedBox(height: 20),
          if (!operation.isAnswered)
            const Text(
              '?',
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            )
          else
            Column(
              children: [
                Text(
                  operation.answer.toString(),
                  style: const TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${operation.num1} ${operation.symbol} ${operation.num2} = ${operation.answer}',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildInstructions() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          const Text(
            'Controles:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildInstructionItem(Icons.arrow_back, 'Anterior\n(swipe ←)'),
              _buildInstructionItem(Icons.arrow_downward, 'Ver respuesta\n(swipe ↓)'),
              _buildInstructionItem(Icons.arrow_forward, 'Siguiente\n(swipe →)'),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'También puedes usar los botones de abajo',
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionItem(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, size: 40, color: Colors.blue),
        const SizedBox(height: 5),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.blue,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildBottomNavigation(bool hasOperations) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.blue[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            onPressed: hasOperations ? _previousOperation : null,
            icon: const Icon(Icons.arrow_back),
            label: const Text('Anterior'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
          ),
          ElevatedButton.icon(
            onPressed: hasOperations ? _showAnswer : null,
            icon: const Icon(Icons.visibility),
            label: const Text('Ver Respuesta'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _nextOperation,
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Siguiente'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
          ),
        ],
      ),
    );
  }
}
