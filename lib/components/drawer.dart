import 'package:flutter/material.dart';
import 'package:shop_provider/utils/rotas_app.dart';

class IconeDrawer extends StatelessWidget {
  const IconeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text("Bem vindo usuário"),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text("Loja"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(RotasApp.rotaPrincipal);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text("Pedidos"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(RotasApp.rotaTelaMeusPedidos);
            },
          ),
          const Divider(
            height: 3,
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Gerencia de produtos"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(RotasApp.rotaProdutos);
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
