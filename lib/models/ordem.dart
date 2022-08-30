import 'package:shop_provider/models/itens_carrinho.dart';

class Ordem {
  final String id;
  final double total;
  final List<ItemCarrinho> produtos;
  final DateTime data;

  Ordem({
    required this.id,
    required this.total,
    required this.produtos,
    required this.data,
  });
}
