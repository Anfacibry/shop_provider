import 'package:flutter/material.dart';

class NotificacaoCarrinho extends StatelessWidget {
  final Widget child;
  final String valor;
  final Color? corDeFundo;
  final void Function() fun;
  final double top;
  final double right;
  const NotificacaoCarrinho({
    Key? key,
    required this.fun,
    required this.top,
    required this.right,
    required this.child,
    required this.valor,
    this.corDeFundo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fun,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          child,
          Positioned(
            top: top,
            right: right,
            child: CircleAvatar(
              backgroundColor:
                  corDeFundo ?? Theme.of(context).colorScheme.secondary,
              radius: 8,
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    textAlign: TextAlign.center,
                    valor,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
