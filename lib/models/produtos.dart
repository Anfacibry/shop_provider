class Produtos {
  final String id;
  final String titulo;
  final String descricao;
  final String preco;
  final String imagemUrl;
  bool eFavorito;

  Produtos({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.preco,
    required this.imagemUrl,
    this.eFavorito = false,
  });

  void verificacaoFavorito() {
    eFavorito = !eFavorito;
  }
}
