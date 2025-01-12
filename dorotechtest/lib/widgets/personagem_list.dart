import 'dart:convert';

import 'package:dorotechtest/models/personagem.dart';
import 'package:dorotechtest/pages/detalhes_personagem_page.dart';
import 'package:dorotechtest/view%20models/personagem_list_model.dart';
import 'package:dorotechtest/view%20models/personagem_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonagemList extends StatelessWidget {
  final List<PersonagemViewModel> personagem;
  const PersonagemList({super.key, required this.personagem});

  @override
  Widget build(BuildContext context) {
    // List<PersonagemModel> tabela = <PersonagemModel>[];

    // mostrarDetalhes(PersonagemModel personagem) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (_) => PersonagemDetalhesPage(personagem: personagem),
    //     ),
    //   );
    // }

    detalhesPage() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PersonagemDetalhesPage(),
        ),
      );
    }

    return ListView.separated(
      itemCount: this.personagem.length,
      itemBuilder: (context, index) {
        final persona = this.personagem[index];
        loadingWidget();

        return ListTile(
          contentPadding: EdgeInsets.all(10),
          leading: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(persona.personagem.image!)),
                borderRadius: BorderRadius.circular(6)),
            width: 50,
            height: 100,
          ),
          title: Text('Nome: ${persona.personagem.name!}'),
          subtitle: Text('status:  ${persona.personagem.status!}'),
          onLongPress: () {
            onTap:
            () => detalhesPage();
          },
        );
      },
      separatorBuilder: (_, ___) => Divider(),
    );
  }
}

late final ScrollController _scrollController;
final loading = ValueNotifier(true);

infitiScrolling() {
  if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent &&
      !loading.value) {
    loadPersonagem();
  }
}

loadPersonagem() async {
  loading.value = true;
  List<PersonagemViewModel> personagem;
  loading.value = false;
}

loadingWidget() {
  return ValueListenableBuilder(
      valueListenable: loading,
      builder: (context, bool isLoading, _) {
        return (isLoading)
            ? Positioned(
                left: (MediaQuery.of(context).size.width / 2) - 20,
                bottom: 24,
                child: const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            : Container();
      });
}
