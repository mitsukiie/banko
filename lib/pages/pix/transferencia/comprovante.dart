import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ComprovanteScreen extends StatelessWidget {
  final String amount;
  final String cpf;

  ComprovanteScreen({
    required this.amount,
    required this.cpf,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pushNamed('/home');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {
              _shareContent(context);
            },
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 43, 43, 43),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          color: const Color.fromARGB(255, 31, 31, 31),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Comprovante de pagamento',
                    style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                ),
                const Text(
                  "00/00/0000 00:00",
                  style: TextStyle(color: Color.fromARGB(255, 161, 161, 161), fontSize: 18.0,),
                  ),
                const SizedBox(height: 20),
                _buildDetailRow('ID da Transação:', "1726627278"),
                _buildDetailRow('Valor:', amount),
                _buildDetailRow('Tipo de transferência:', "Pix"),
                const SizedBox(height: 30),
                const Row(
                  children: [
                    Icon(Icons.arrow_downward, color: Colors.white),
                    SizedBox(width: 5),
                    Text('Destino', style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold))
                    ],
                  ),
                 _buildDetailRow('Nome:', "Timóteo Chimbalaue"),
                 _buildDetailRow('CPF:', cpf),
                const SizedBox(height: 30),
                const Row(
                  children: [
                    Icon(Icons.arrow_upward, color: Colors.white),
                    SizedBox(width: 5),
                    Text('Origem', style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold))
                    ],
                  ),
                 _buildDetailRow('Nome:', "Jefferson Caminhões"),
                 _buildDetailRow('CPF:', "000.000.000-00"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white70, fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  void _shareContent(BuildContext context) {
    Share.share('apenas teste!');
  }

}
