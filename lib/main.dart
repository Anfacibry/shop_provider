import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_provider/provider/carrinho.dart';
import 'package:shop_provider/provider/lista_ordenada.dart';
import 'package:shop_provider/provider/lista_produtos.dart';
import 'package:shop_provider/screens/tela_carrinho.dart';
import 'package:shop_provider/screens/tela_detalhes_produtos.dart';
import 'package:shop_provider/screens/tela_formulario.dart';
import 'package:shop_provider/screens/tela_ordens.dart';
import 'package:shop_provider/screens/tela_grid_produtos.dart';
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
          ChangeNotifierProvider(
            create: (cntxProvCarrinho) => ListaOrdenada(),
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
        ),
      ),
      initialRoute: RotasApp.rotaPrincipal,
      routes: {
        RotasApp.rotaPrincipal: (context) => const TelaGridProdutos(),
        RotasApp.rotaDetalhesProdutos: (context) => const DetalhesProdutos(),
        RotasApp.rotaTelaCarrinho: (context) => const TelaCarrinho(),
        RotasApp.rotaTelaListaOrdem: (context) => const TelaOrdens(),
        RotasApp.rotaProdutos: (context) => const TelaProdutos(),
        RotasApp.rotaFormulario: (context) => const TelaFormulario(),
      },
    );
  }
}
