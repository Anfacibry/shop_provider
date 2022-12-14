import 'package:shop_provider/models/produtos.dart';

class DadosDeProdutos {
  List<Produtos> dadosProdutos = [
    Produtos(
      id: 'p1',
      titulo: 'Red Shirt',
      descricao: 'A red shirt - it is pretty red!',
      preco: 29.99,
      imagemUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Produtos(
      id: 'p2',
      titulo: 'Trousers',
      descricao: 'A nice pair of trousers.',
      preco: 59.99,
      imagemUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Produtos(
      id: 'p3',
      titulo: 'Yellow Scarf',
      descricao: 'Warm and cozy - exactly what you need for the winter.',
      preco: 19.99,
      imagemUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Produtos(
      id: 'p4',
      titulo: 'A Pan',
      descricao: 'Prepare any meal you want.',
      preco: 49.99,
      imagemUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];
}
