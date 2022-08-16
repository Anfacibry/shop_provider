import 'package:flutter/material.dart';

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
        ],
      ),
      body: GridDeProdutos(
        selecaoFavorito: _selecaoFavorito,
      ),
    );
  }
}
