import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_provider/provider/autenticacao.dart';
import 'package:shop_provider/screens/tela_grid_produtos.dart';
import 'package:shop_provider/screens/tela_login.dart';

class LoginOuHome extends StatelessWidget {
  const LoginOuHome({super.key});

  @override
  Widget build(BuildContext context) {
    Autenticacao autenticacao = Provider.of(context);
    return autenticacao.estarAutenticado
        ? const TelaLogin()
        : const TelaGridProdutos();
  }
}
