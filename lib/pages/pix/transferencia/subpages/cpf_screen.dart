import 'package:flutter/material.dart';
import 'package:banko/pages/pix/transferencia/subpages/paymentprocessing_screen.dart';

class CpfScreen extends StatefulWidget {
  final String? amount;

  CpfScreen({this.amount});
  @override
  _CpfScreenState createState() => _CpfScreenState();
}

class _CpfScreenState extends State<CpfScreen> {
  
  final TextEditingController _controller = TextEditingController();
  bool _showErrorMessage = false;

  void _submitCpf(BuildContext context) {
    final cpf = _controller.text;
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaymentProcessingScreen(amount: widget.amount,
        cpf: cpf,)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 43, 43, 43),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'CPF',
                  style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Digite o CPF qual deseja fazer a transferencia.',
                  style: TextStyle(color: Color.fromARGB(255, 161, 161, 161), fontSize: 16.0,),
                ),
                TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white, fontSize: 30.0),
                  decoration: const InputDecoration(
                    hintText: '000.000.000-00',
                    hintStyle: TextStyle(color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _showErrorMessage = false;
                    });
                    final formattedValue = _formatCpf(value);
                    _controller.value = TextEditingValue(
                      text: formattedValue,
                      selection: TextSelection.fromPosition(
                        TextPosition(offset: formattedValue.length),
                      ),
                    );
                  },
                ),
                if (_showErrorMessage)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Por favor, insira um CPF válido.',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    final cpf = _controller.text;
                    if (cpf.isEmpty || cpf.length != 14) {
                      _showErrorMessage = true;
                    } else {
                      _showErrorMessage = false;
                      _submitCpf(context);
                    }
                  });
                },
                backgroundColor: Colors.cyan,
                child: const Icon(Icons.arrow_forward, color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatCpf(String value) {
    final cleaned = value.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();
    for (int i = 0; i < cleaned.length; i++) {
      if (i == 3 || i == 6) {
        buffer.write('.');
      } else if (i == 9) {
        buffer.write('-');
      }
      buffer.write(cleaned[i]);
    }
    return buffer.toString();
  }
}
