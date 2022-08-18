import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_provider/models/carrinho.dart';
import 'package:shop_provider/models/lista_produtos.dart';
import 'package:shop_provider/screens/tela_detalhes_produtos.dart';
import 'package:shop_provider/screens/tela_produtos.dart';
import 'package:shop_provider/utils/rotas_app.dart';

void main() => runApp(
      ///Carregamento de multiplos provides
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (cntxProvListProdu) => ListaProdutos(),
          ),
          ChangeNotifierProvider(
            create: (cntxProvCarrinho) => Carrinho(),
          ),
        ],
        child: const ShopProvider(),
      ),
    );

class ShopProvider extends StatelessWidget {
  const ShopProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Shop Provider",
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.purple,
        accentColor: Colors.pink[100],
      )),
      initialRoute: RotasApp.rotaPrincipal,
      routes: {
        RotasApp.rotaPrincipal: (context) => const TelaProdutos(),
        RotasApp.rotaDetalhesProdutos: (context) => const DetalhesProdutos(),
      },
    );
  }
}
