import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_provider/exceptions/http_exceptions.dart';
import 'package:shop_provider/models/produtos.dart';
import 'package:shop_provider/provider/lista_produtos.dart';
import 'package:shop_provider/utils/rotas_app.dart';

class ItensListaProdutos extends StatelessWidget {
  final Produtos produtos;
  const ItensListaProdutos({
    Key? key,
    required this.produtos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScaffoldMessengerState mensagem = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(produtos.titulo),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(produtos.imagemUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  RotasApp.rotaFormulario,
                  arguments: produtos,
                );
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: ((context) => AlertDialog(
                        title: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(produtos.imagemUrl),
                            ),
                            const Padding(padding: EdgeInsets.only(right: 10)),
                            Text(produtos.titulo),
                          ],
                        ),
                        content: const Text(
                          "Você tem certeza que deseja excluir este produto?",
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Não"),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                              try {
                                await Provider.of<ListaProdutos>(
                                  context,
                                  listen: false,
                                ).removendoProduto(produtos);
                              } on HttpExceptions catch (erro) {
                                mensagem.showSnackBar(
                                  SnackBar(
                                    duration: const Duration(seconds: 2),
                                    content: Text(
                                      erro.toString(),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: const Text("Sim"),
                          ),
                        ],
                      )),
                );
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
