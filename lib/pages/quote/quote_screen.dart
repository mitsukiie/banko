import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuoteScreen extends StatefulWidget {
  @override
  _CotacaoScreenState createState() => _CotacaoScreenState();
}

class _CotacaoScreenState extends State<QuoteScreen> {
  Map<String, dynamic>? _cotacoes;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchCotacoes();
  }

  Future<void> fetchCotacoes() async {
    setState(() {
      _isLoading = true;
    });

    final String apiKey = "91252b59b0864697a0e159d758fa3bcf";
    final String baseCurrency = "BRL";
    final List<String> moedas = ['USD', 'EUR', 'GBP', 'JPY'];

    final String oxrUrl =
        "https://open.er-api.com/v6/latest/$baseCurrency?apikey=$apiKey";

    final response = await http.get(Uri.parse(oxrUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _cotacoes = Map.fromEntries(moedas.map(
            (moeda) => MapEntry<String, dynamic>(moeda, data['rates'][moeda])));
        _isLoading = false;
      });
    } else {
      print('Erro ao carregar as cotações: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar as cotações. Tente novamente.')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: fetchCotacoes,
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 43, 43, 43),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _cotacoes == null
              ? Center(
                  child: Text(
                    'Nenhuma cotação disponível',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Cotações BRL',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.all(16.0),
                        children: _cotacoes!.entries.map((entry) {
                          String valorFormatado =
                              '${entry.value.toStringAsFixed(3)}';

                          // Simulação de mudança de preço (para fins de exemplo)
                          bool aumento = entry.value > 1.0;

                          return Card(
                            elevation: 4,
                            margin: EdgeInsets.symmetric(vertical: 7.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Colors.transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    const Color.fromARGB(255, 12, 121, 121),
                                    Colors.cyan
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                leading: Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white, // Cor de fundo do ícone
                                  ),
                                  child: Icon(
                                    getCurrencyIcon(entry.key),
                                    color: Colors.cyan, // Cor do ícone
                                    size: 32.0,
                                  ),
                                ),
                                title: Text(
                                  '${entry.key}: ${valorFormatado.substring(0, 4)}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0,
                                  ),
                                ),
                                trailing: Icon(
                                  aumento ? Icons.arrow_upward : Icons.arrow_downward,
                                  color: aumento ? Colors.green : Colors.red,
                                  size: 32.0,
                                ),
                                onTap: () {
                                  // Adicione ação ao tocar no card, se necessário
                                },
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
    );
  }

  IconData getCurrencyIcon(String currencyCode) {
    switch (currencyCode) {
      case 'USD':
        return Icons.attach_money;
      case 'EUR':
        return Icons.euro;
      case 'GBP':
        return Icons.currency_pound;
      case 'JPY':
        return Icons.currency_yen;
      default:
        return Icons.monetization_on;
    }
  }
}
