import 'package:flutter/material.dart';
import 'package:shop_provider/utils/rotas_app.dart';

class NotificacaoCarrinho extends StatelessWidget {
  final Widget child;
  final String valor;
  final Color? corDeFundo;
  const NotificacaoCarrinho({
    Key? key,
    required this.child,
    required this.valor,
    this.corDeFundo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RotasApp.rotaTelaCarrinho);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          child,
          Positioned(
            top: 10,
            right: 10,
            child: CircleAvatar(
              backgroundColor:
                  corDeFundo ?? Theme.of(context).colorScheme.secondary,
              radius: 8,
              child: Text(
                textAlign: TextAlign.center,
                valor,
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
