import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_provider/models/produtos.dart';
import 'package:shop_provider/provider/lista_produtos.dart';

class TelaFormulario extends StatefulWidget {
  const TelaFormulario({Key? key}) : super(key: key);

  @override
  State<TelaFormulario> createState() => _TelaFormularioState();
}

class _TelaFormularioState extends State<TelaFormulario> {
  final FocusNode _focusNode = FocusNode();
  final FocusNode _descricaoNode = FocusNode();
  final FocusNode _urlNode = FocusNode();

  final TextEditingController _urlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _dadosForm = {};

  void atualizandoUrl() {
    setState(() {});
  }

  bool validImagem(String url) {
    bool eValidaUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool contemFormatImage = url.toLowerCase().endsWith(".png") ||
        url.toLowerCase().endsWith(".jpg") ||
        url.toLowerCase().endsWith(".jpeg");
    return eValidaUrl && contemFormatImage;
  }

  void _formSubmetido() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      final Produtos novoProduto = Produtos(
          id: Random().nextDouble().toString(),
          titulo: _dadosForm["nome"],
          descricao: _dadosForm["descricao"],
          preco: _dadosForm["preco"],
          imagemUrl: _dadosForm["url"]);
      Provider.of<ListaProdutos>(
        context,
        listen: false,
      ).adicionandoProduto(novoProduto);
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    _urlNode.addListener(atualizandoUrl);
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _descricaoNode.dispose();
    _urlNode.removeListener(atualizandoUrl);
    _urlNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulario de cadastro"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _formSubmetido,
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Nome",
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (valorString) {
                  FocusScope.of(context).requestFocus(_focusNode);
                },
                onSaved: (nomePego) {
                  _dadosForm["nome"] = nomePego ?? "";
                },
                validator: (String? nomePego) {
                  final nome = nomePego ?? "";
                  if (nome.trim().isEmpty) {
                    return "Digite um nome";
                  }
                  if (nome.length < 3) {
                    return "Digite um nome com mais de 3 caracteres";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Preço",
                ),
                onFieldSubmitted: (valorString) {
                  FocusScope.of(context).requestFocus(_descricaoNode);
                },
                onSaved: (precoPego) {
                  _dadosForm["preco"] = double.parse(precoPego!);
                },
                validator: (precoPego) {
                  final preco = precoPego ?? "";
                  final precoConvert = double.tryParse(preco) ?? -1;
                  if (precoConvert <= 0) {
                    return "Digite um valor válido";
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _focusNode,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Descrição",
                ),
                onFieldSubmitted: (valorString) {
                  FocusScope.of(context).requestFocus(_urlNode);
                },
                onSaved: (descricaoPego) {
                  _dadosForm["descricao"] = descricaoPego ?? "";
                },
                validator: (String? descricaoPego) {
                  final descricao = descricaoPego ?? "";
                  if (descricao.trim().isEmpty) {
                    return "Digite um descricao";
                  }
                  if (descricao.length < 10) {
                    return "Digite um descricao com mais de 10 caracteres";
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                focusNode: _descricaoNode,
                maxLines: 3,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Url",
                      ),
                      onSaved: (urlPego) {
                        _dadosForm["url"] = urlPego ?? "";
                      },
                      validator: (urlPega) {
                        final url = urlPega ?? "";
                        if (!validImagem(url)) {
                          return "Retorna uma URL válida";
                        }
                        return null;
                      },
                      controller: _urlController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.url,
                      focusNode: _urlNode,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 5,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: _urlController.text.isEmpty
                          ? const Text("Vazio")
                          : SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.network(
                                _urlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
