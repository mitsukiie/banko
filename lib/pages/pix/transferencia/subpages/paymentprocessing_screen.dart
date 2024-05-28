import 'package:flutter/material.dart';

class PaymentProcessingScreen extends StatefulWidget {
  final String? amount;
  final String? cpf;
  PaymentProcessingScreen({this.amount, this.cpf});
  @override
  _PaymentProcessingScreenState createState() => _PaymentProcessingScreenState();
}

class _PaymentProcessingScreenState extends State<PaymentProcessingScreen> {
  Future<void> _processPayment() async {
    // Simulação de processamento de pagamento
    await Future.delayed(const Duration(seconds: 3));
  }

  @override
  void initState() {
    super.initState();
    _startPaymentProcessing();
  }

  void _startPaymentProcessing() async {
    await Future.delayed(const Duration(seconds: 4));
    setState(() {
       _isProcessingPayment = false;
      _isGeneratingReceipt = true; 
    });

    await Future.delayed(const Duration(seconds: 4)); // Aguarda 2 segundos antes de mostrar "Pagamento concluído com sucesso!"

    setState(() {
      _isGeneratingReceipt = false; 
      _isPaymentCompleted = true;
    });
  }

  bool _isProcessingPayment = true;
  bool _isGeneratingReceipt = false;
  bool _isPaymentCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          'Transferência',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: const Color.fromARGB(255, 43, 43, 43),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isProcessingPayment)
              const Column(
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan), 
                    strokeWidth: 4,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Processando pagamento...',
                   style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ],
              ),
              if (_isGeneratingReceipt)
              const Column(
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan), 
                    strokeWidth: 4,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Gerando comprovante...',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                ],
              ),
            if (_isPaymentCompleted)
  Column(
    children: [
      Icon(Icons.check_circle, color: Colors.green, size: 70),
      SizedBox(height: 20),
      Text(
        'Pagamento concluído com sucesso!',
        style: TextStyle(color: Colors.white, fontSize: 20.0),
      ),
      SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/comprovante',
            arguments: {
            'amount': widget.amount,
            'cpf': widget.cpf,
            },
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.cyan,
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Ver Comprovante',
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
      ),
    ],
  ),

          ],
        ),
      ),
    );
  }
}