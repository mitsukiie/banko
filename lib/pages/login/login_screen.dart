import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;
  TextEditingController _passwordController = TextEditingController();
  bool _showErrorMessage = false; 

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Entrar',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.cyan,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: const Color.fromARGB(255, 43, 43, 43),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top + 20),
                const Center(
                  child: Text(
                    'Digite sua senha',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                if (_showErrorMessage) // Exibe a mensagem apenas se _showErrorMessage for verdadeiro
                  const Text(
                    'Por favor, insira a sua senha.',
                    style: TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: TextField(
                    controller: _passwordController,
                    onChanged: (value) {
                      setState(() {
                        _showErrorMessage =
                            false; // Oculta a mensagem de erro quando o usuário digita algo
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 31, 31,
                          31), // Define a cor de fundo do campo de texto
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none, // Remova o contorno
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _showErrorMessage
                              ? Colors.red
                              : Colors.cyan, // Define a cor do contorno
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white,
                          size: 20.0,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                    ),
                    obscureText: _isObscure,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Implemente aqui a ação para quando "Esqueceu a senha" for clicado
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Esqueceu a senha?',
                      style: TextStyle(
                        color: Colors.cyan,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_passwordController.text.isEmpty) {
                      _showErrorMessage =
                          true; // Exibe a mensagem de erro se o campo estiver vazio
                    } else {
                      _showErrorMessage =
                          false; // Oculta a mensagem de erro se o campo estiver preenchido
                      Navigator.of(context).pushNamed('/home');
                    }
                  });
                },
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'ok',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.cyan),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
