import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_provider/exceptions/autentic_exceptions.dart';
import 'package:shop_provider/provider/autenticacao.dart';

enum ModoLogin { login, registro }

class AutFormLogin extends StatefulWidget {
  const AutFormLogin({super.key});

  @override
  State<AutFormLogin> createState() => _AutFormLoginState();
}

class _AutFormLoginState extends State<AutFormLogin> {
  ModoLogin statusModoLogin = ModoLogin.login;
  TextEditingController senhaController = TextEditingController();

  bool get login => statusModoLogin == ModoLogin.login;
  bool get registro => statusModoLogin == ModoLogin.registro;

  final keyForm = GlobalKey<FormState>();
  bool carregando = false;

  Map<String, String> dadosLogin = {
    "email": "",
    "senha": "",
  };

  void erroAutenticacao(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Mensagem de erro"),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                carregando = false;
              });
            },
            child: const Text("Fechar"),
          )
        ],
      ),
    );
  }

  Future<void> alterandoCarregando() async {
    final validacaoKey = keyForm.currentState?.validate() ?? false;

    if (!validacaoKey) {
      return;
    }

    setState(() => carregando = true);
    keyForm.currentState?.save();
    Autenticacao autenticacao = Provider.of(context, listen: false);
    try {
      if (login) {
        await autenticacao.login(
          email: dadosLogin["email"]!,
          senha: dadosLogin["senha"]!,
        );
      } else {
        await autenticacao.registro(
          email: dadosLogin["email"]!,
          senha: dadosLogin["senha"]!,
        );
      }
    } on AutenticExceptions catch (erro) {
      erroAutenticacao(erro.toString());
    }
    setState(() => carregando = true);
  }

  void loginOuRegistro() {
    setState(() {
      if (login) {
        statusModoLogin = ModoLogin.registro;
      } else {
        statusModoLogin = ModoLogin.login;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tamanhoTela = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.only(right: 10),
      child: SizedBox(
        height: login ? 350 : 400,
        width: tamanhoTela.width * 0.80,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: keyForm,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Email",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (emailPego) => dadosLogin["email"] = emailPego ?? "",
                  validator: (email) {
                    final emailValidar = email ?? "";
                    if (emailValidar.isEmpty && !emailValidar.contains("@")) {
                      return "Digite um email valido";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Senha",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  controller: senhaController,
                  obscureText: true,
                  onSaved: (senhaPego) => dadosLogin["senha"] = senhaPego ?? "",
                  validator: (senhPegaVadidar) {
                    final senhaValidar = senhPegaVadidar ?? "";
                    if (senhaValidar.isEmpty && senhaValidar.length < 6) {
                      return "Digite uma senha valida";
                    } else {
                      return null;
                    }
                  },
                ),
                if (registro)
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Confirmar senha",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: login
                        ? null
                        : (senhaPega) {
                            if (senhaPega != senhaController.text) {
                              return "Por favor, digite a mesma senha do campo de senha";
                            } else {
                              return null;
                            }
                          },
                    obscureText: true,
                  ),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                carregando
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: alterandoCarregando,
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 40)),
                        child: Text(login ? "Login" : "Registrar"),
                      ),
                const Spacer(
                  flex: 5,
                ),
                TextButton(
                    onPressed: loginOuRegistro,
                    child: Text(
                      login
                          ? "Deseja registrar uma nova conta?"
                          : "Já possui login?",
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
