import 'package:flutter/material.dart';

class PixScreen extends StatefulWidget {
  const PixScreen({super.key});

  @override
  _PixScreenState createState() => _PixScreenState();
}

class _PixScreenState extends State<PixScreen> {
  // Mapas para armazenar o estado de cada botão e card
  final Map<String, bool> _isPressedMap = {
    'transferir': false,
    'copiar': false,
    'qrcode': false,
  };

  final Map<String, bool> _isPressedCardMap = {
    'registrar': false,
    'configurar': false,
  };

  void _togglePressed(String key, bool isPressed, bool isCard) {
    setState(() {
      if (isCard) {
        _isPressedCardMap[key] = isPressed;
      } else {
        _isPressedMap[key] = isPressed;
      }
    });

    if (!isPressed) {
      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          if (isCard) {
            _isPressedCardMap[key] = false;
          } else {
            _isPressedMap[key] = false;
          }
        });
      });
    }
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Area Pix',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 10),
                Text(
                  'Envie pagamentos a qualquer hora e dia da semana.',
                  style: TextStyle(
                    color: Color.fromARGB(255, 161, 161, 161),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Botão "Transferir"
              _buildButton(
                icon: Icons.swap_horiz,
                label: 'Transferir',
                buttonKey: 'transferir',
                onPressed: () {
                   Navigator.of(context).pushNamed('/transfer');
                },
              ),
              // Botão "Pix Copiar e Colar"
              _buildButton(
                icon: Icons.content_copy,
                label: 'Pix Copiar e Colar',
                buttonKey: 'copiar',
              ),
              // Botão "Ler QR Code"
              _buildButton(
                icon: Icons.qr_code,
                label: 'Ler QR Code',
                buttonKey: 'qrcode',
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              children: [
                // Primeiro card
                _buildCard(
                  label: 'Registrar Chaves',
                  description: 'Faça uma nova chave pix.',
                  cardKey: 'registrar',
                ),
                const SizedBox(height: 10), // Espaçamento entre os cards
                // Segundo card
                _buildCard(
                  label: 'Configurar Pix',
                  description: 'Configure seu limite diário de transferências.',
                  cardKey: 'configurar',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20), // Pequeno espaço abaixo dos cards
        ],
      ),
    );
  }

  // Função para construir os botões
  Widget _buildButton({
    required IconData icon,
    required String label,
    required String buttonKey,
    VoidCallback? onPressed,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTapDown: (_) => _togglePressed(buttonKey, true, false),
          onTapUp: (_) => _togglePressed(buttonKey, false, false),
          onTapCancel: () => _togglePressed(buttonKey, false, false),
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              color: _isPressedMap[buttonKey]! ? Colors.cyan[700] : Colors.cyan,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(20),
            child: Icon(icon, size: 40, color: Colors.white),
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // Função para construir os cards
  Widget _buildCard({required String label, required String description, required String cardKey}) {
    return GestureDetector(
      onTapDown: (_) => _togglePressed(cardKey, true, true),
      onTapUp: (_) => _togglePressed(cardKey, false, true),
      onTapCancel: () => _togglePressed(cardKey, false, true),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: _isPressedCardMap[cardKey]! ? Colors.cyan[700] : Colors.cyan,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: const TextStyle(color: Colors.white70, fontSize: 13.0),
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
