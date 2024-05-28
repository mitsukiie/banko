import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Banko',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.cyan,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const CircleAvatar(
              radius: 16.0,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                color: Colors.cyan,
                size: 20.0,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 31, 31, 31),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.cyan,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: const Color.fromARGB(255, 31, 31, 31),
                      ),
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Saldo',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'R\$ 1.000,00',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyan,
                              minimumSize: const Size(double.infinity,
                                  46),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Text(
                              'Ver Extrato',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    Container(
                      width: MediaQuery.of(context).size.width * 1.0,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                        color: Color.fromARGB(255, 43, 43, 43),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        crossAxisSpacing: 1.0,
                        mainAxisSpacing: 1.0,
                        children: [
                          _buildServiceIcon(
                              context, 'Pix', Icons.pix, '/pix'),
                          _buildServiceIcon(
                              context, 'Pagar', Icons.shopping_cart, ''),
                          _buildServiceIcon(
                              context, 'Depositar', Icons.arrow_downward_rounded, ''),
                          _buildServiceIcon(
                              context, 'Cartões', Icons.credit_card_rounded, ''),
                            _buildServiceIcon(
                              context, 'Empréstimos', Icons.money, ''),
                          _buildServiceIcon(context, 'Cotação',
                              Icons.assessment_rounded, '/quote'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              height: 220.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildPromotionCard('Investimento com Bônus',
                      'Invista em fundos selecionados e receba um bônus de 5% no valor investido.'),
                  _buildPromotionCard('Desconto em Parceiros',
                      'Aproveite até 20% de desconto em lojas parceiras ao usar seu cartão.'),
                  _buildPromotionCard('Taxa Reduzida',
                      'Solicite um empréstimo pessoal com taxas de juros reduzidas.'),
                  _buildPromotionCard('Concorra a Prêmios',
                      'Participe do nosso sorteio mensal e concorra a viagens, eletrônicos e mais.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromotionCard(String title, String description) {
    return Container(
      width: 270.0,
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 43, 43, 43),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 43, 43, 43),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          Container(
            height: 120.0,
            decoration: const BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 3.0),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceIcon(
      BuildContext context, String title, IconData icon, String route) {
    return InkWell(
      onTap: () {
        if (route.isNotEmpty) {
          Navigator.of(context).pushNamed(route);
        } else {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ServiceDetailsPage(title: title, icon: icon),
          ));
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 45.0,
            color: Colors.cyan,
          ),
          const SizedBox(height: 10.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceDetailsPage extends StatelessWidget {
  final String title;
  final IconData icon;

  ServiceDetailsPage({required this.title, required this.icon});

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 100.0,
              color: Colors.cyan,
            ),
            const SizedBox(height: 10.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
