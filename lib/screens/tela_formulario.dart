import 'package:flutter/material.dart';

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

  void atualizandoUrl() {
    setState(() {});
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
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
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Preço",
                ),
                onFieldSubmitted: (valorString) {
                  FocusScope.of(context).requestFocus(_descricaoNode);
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
