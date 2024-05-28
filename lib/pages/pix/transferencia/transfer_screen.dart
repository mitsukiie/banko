import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:banko/pages/pix/transferencia/subpages/cpf_screen.dart';

class TransferScreen extends StatefulWidget {
  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _showErrorMessage = false;
  void _transferMoney(BuildContext context) {
    final amount = _controller.text;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CpfScreen(amount: amount)),
    );
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Qual é o valor da transferência?',
              style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Saldo disponível em conta R\$ 1.000,00',
              style: TextStyle(color: Color.fromARGB(255, 161, 161, 161), fontSize: 16.0,),
            ),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white, fontSize: 30.0),
              decoration: const InputDecoration(
                hintText: 'R\$ 0,00',
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
                  _showErrorMessage = false; // Oculta a mensagem de erro quando o usuário digita algo
                });
                final numberFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
                if (value.isNotEmpty) {
                  final double parsedValue = double.parse(value.replaceAll(RegExp('[^0-9]'), '')) / 100;
                  final formattedValue = numberFormat.format(parsedValue);
                  _controller.value = TextEditingValue(
                    text: formattedValue,
                    selection: TextSelection.fromPosition(
                      TextPosition(offset: formattedValue.length),
                    ),
                  );
                }
              },
            ),
            if (_showErrorMessage)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Por favor, insira o valor da transferência.',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            final amount = _controller.text;
            if (amount.isEmpty) {
              _showErrorMessage = true;
            } else {
              _showErrorMessage = false;
              _transferMoney(context);
            }
          });
        },
        backgroundColor: Colors.cyan,
        child: Icon(Icons.arrow_forward, color: Colors.white, size: 30.0,),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50), // Deixa o botão ainda mais redondo
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
} 
