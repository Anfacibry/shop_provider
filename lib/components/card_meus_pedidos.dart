import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_provider/models/ordem.dart';

class CardMeusPedidos extends StatefulWidget {
  final Ordem ordem;
  const CardMeusPedidos({Key? key, required this.ordem}) : super(key: key);

  @override
  State<CardMeusPedidos> createState() => _CardMeusPedidosState();
}

class _CardMeusPedidosState extends State<CardMeusPedidos> {
  bool _expandedSelecionado = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(widget.ordem.total.toStringAsFixed(2)),
            subtitle: Text(
              DateFormat("dd/MM/yyyy hh:mm").format(widget.ordem.data),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expandedSelecionado = !_expandedSelecionado;
                });
              },
              icon: const Icon(Icons.expand_more),
            ),
          ),
          if (_expandedSelecionado)
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 15,
              ),
              height: (widget.ordem.produtos.length * 25.0) + 10,
              child: ListView(
                children: widget.ordem.produtos
                    .map(
                      (itemCarrinho) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            itemCarrinho.produtoTitulo,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${itemCarrinho.quantidade} X ${itemCarrinho.preco}",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
