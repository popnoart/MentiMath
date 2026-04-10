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
      return '${_getOperationTypeName(widget.operationType!)} - ${_operations[_currentIndex].difficultyName}';
    }
    return '${_getOperationTypeName(widget.operationType!)} - ${_getDifficultyName(widget.difficultyLevel)}';
  }

  String _getOperationTypeName(OperationType type) {
    switch (type) {
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
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildLoadingScreen() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 10),
          Text(
            'Cargando...',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildOperationCard(MathOperation operation) {
    return Container(
      color: Colors.grey[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Operación centrada
          Expanded(
            child: Center(
              child: _buildOperationDisplay(operation),
            ),
          ),
          
          // Espacio mínimo antes de los botones
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildOperationDisplay(MathOperation operation) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            operation.num1.toString(),
            style: const TextStyle(
              fontSize: 70,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            operation.symbol,
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            operation.num2.toString(),
            style: const TextStyle(
              fontSize: 70,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            height: 3,
            width: 180,
            color: Colors.black,
          ),
          const SizedBox(height: 15),
          if (!operation.isAnswered)
            const Text(
              '?',
              style: TextStyle(
                fontSize: 70,
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
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${operation.num1} ${operation.symbol} ${operation.num2} = ${operation.answer}',
                    style: const TextStyle(
                      fontSize: 20,
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

  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
      color: Colors.blue[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: _previousOperation,
            icon: const Icon(Icons.arrow_back, size: 28),
            color: Colors.blue,
            padding: const EdgeInsets.all(10),
            tooltip: 'Anterior (swipe ←)',
          ),
          IconButton(
            onPressed: _showAnswer,
            icon: const Icon(Icons.visibility, size: 28),
            color: Colors.green,
            padding: const EdgeInsets.all(10),
            tooltip: 'Ver respuesta (swipe ↓)',
          ),
          IconButton(
            onPressed: _nextOperation,
            icon: const Icon(Icons.arrow_forward, size: 28),
            color: Colors.blue,
            padding: const EdgeInsets.all(10),
            tooltip: 'Siguiente (swipe →)',
          ),
        ],
      ),
    );
  }
}
