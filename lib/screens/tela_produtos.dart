import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_provider/components/notificacao_carrinho.dart';
import 'package:shop_provider/models/carrinho.dart';
import 'package:shop_provider/utils/rotas_app.dart';

import '../components/grid_de_produtos.dart';

enum FiltrandoOpcao {
  favoritos,
  todos,
}

class TelaProdutos extends StatefulWidget {
  const TelaProdutos({Key? key}) : super(key: key);

  @override
  State<TelaProdutos> createState() => _TelaProdutosState();
}

class _TelaProdutosState extends State<TelaProdutos> {
  bool _selecaoFavorito = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produtos"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (contextPop) => [
              const PopupMenuItem(
                value: FiltrandoOpcao.favoritos,
                child: Text("Favoritos"),
              ),
              const PopupMenuItem(
                value: FiltrandoOpcao.todos,
                child: Text("Todos"),
              ),
            ],
            onSelected: (selecao) {
              setState(() {
                if (selecao == FiltrandoOpcao.favoritos) {
                  _selecaoFavorito = true;
                } else {
                  _selecaoFavorito = false;
                }
              });
            },
          ),
          Consumer<Carrinho>(
            builder: (context, carrinho, child) => NotificacaoCarrinho(
              fun: () {
                Navigator.of(context).pushNamed(RotasApp.rotaTelaCarrinho);
              },
              top: 10,
              right: 10,
              valor: carrinho.tamanhoCarrinho.toString(),
              child: const Padding(
                padding: EdgeInsets.only(right: 15),
                child: Icon(Icons.shopping_cart),
              ),
            ),
          ),
        ],
      ),
      body: GridDeProdutos(
        selecaoFavorito: _selecaoFavorito,
      ),
    );
  }
}
