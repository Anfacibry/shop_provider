import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_provider/components/drawer.dart';
import 'package:shop_provider/components/notificacao_carrinho.dart';
import 'package:shop_provider/provider/carrinho.dart';
import 'package:shop_provider/provider/lista_produtos.dart';
import 'package:shop_provider/utils/rotas_app.dart';

import '../components/grid_de_produtos.dart';

enum FiltrandoOpcao {
  favoritos,
  todos,
}

class TelaGridProdutos extends StatefulWidget {
  const TelaGridProdutos({Key? key}) : super(key: key);

  @override
  State<TelaGridProdutos> createState() => _TelaGridProdutosState();
}

class _TelaGridProdutosState extends State<TelaGridProdutos> {
  bool _selecaoFavorito = false;
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    Provider.of<ListaProdutos>(
      context,
      listen: false,
    ).pegandoDados().then((carregando) {
      setState(() {
        _carregando = false;
      });
    });
  }

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
      body: _carregando
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridDeProdutos(
              selecaoFavorito: _selecaoFavorito,
            ),
      drawer: const IconeDrawer(),
    );
  }
}
