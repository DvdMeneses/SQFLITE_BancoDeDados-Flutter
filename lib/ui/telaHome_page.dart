import 'package:flutter/material.dart';
import 'package:segunda_prova/domain/Usuario.dart';
import 'package:segunda_prova/helpers/usuario_helper.dart';
import 'package:segunda_prova/ui/cadastrar_Page.dart';
import 'package:segunda_prova/ui/editar_Page.dart';
import 'package:segunda_prova/ui/telaDetalhes_Page.dart';

import 'info_Page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Usuários"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfoPage(),
                  ),
                );
              },
              icon: const Icon(Icons.account_tree_rounded),
            ),
          ]),

      body: HomeBody(),
      //BUTTON DE CADASTRO
      floatingActionButton: FloatingActionButton(
        // BOTAO DE CADASTRO
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CadastroPage(),
            ),
          );
        },
        tooltip: 'Adicionar USER',
        child: Icon(Icons.add),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }

  // Método para recarregar os usuários
  void _reloadUsuarios(BuildContext context) {
    final _homeBodyState = HomeBody.of(context);
    _homeBodyState?.loadUsuarios();
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();

  // Método estático para acessar o estado de HomeBody de fora da classe
  static _HomeBodyState? of(BuildContext context) {
    return context.findAncestorStateOfType<_HomeBodyState>();
  }
}

class _HomeBodyState extends State<HomeBody> {
  final usuarioHelper = UsuarioHelper();
  late Future<List<Usuario>> usuarios;

  @override
  void initState() {
    super.initState();
    loadUsuarios();
  }

  Future<void> loadUsuarios() async {
    setState(() {
      usuarios = usuarioHelper.getAllUsuarios();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Usuario>>(
      future: usuarios,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                // LIST VIEW PARA LISTAR
                padding: const EdgeInsets.all(10.0),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  return _buildListItem(snapshot.data![i]);
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

//  CONTROLE DE TOQUES
  Widget _buildListItem(Usuario usuario) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TelaDetalhes(idUsuario: usuario.id),
          ),
        );
      },
      onLongPress: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TelaAltera(idUsuario: usuario.id),
          ),
        );

        if (result != null) {
          Usuario usuarioRecebido = result;
          print(usuarioRecebido.id);
          print(usuarioRecebido.nome);
          print(usuarioRecebido.nacionalidade);
          print(usuarioRecebido.raca);
          print(usuarioRecebido.peso);
          print(usuarioRecebido.sexo);
          await usuarioHelper.updateUsuario(usuarioRecebido);
          loadUsuarios();
        }
      },
      child: ListTile(
        title: Text(usuario.nome),
      ),
    );
  }
}
