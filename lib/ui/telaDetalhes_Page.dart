import 'package:flutter/material.dart';
import 'package:segunda_prova/helpers/usuario_helper.dart';
import 'package:segunda_prova/ui/telaHome_page.dart';

import '../domain/Usuario.dart';

class TelaDetalhes extends StatelessWidget {
  final int idUsuario;

  const TelaDetalhes({
    super.key,
    required this.idUsuario, //REQUER UM ID Q.7
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Detalhes Usuario"),
      ),
      body: FormUpdateUsuarioBody(idUsuario: idUsuario),
    );
  }
}

class FormUpdateUsuarioBody extends StatefulWidget {
  final int idUsuario;

  const FormUpdateUsuarioBody({
    super.key,
    required this.idUsuario,
  });

  @override
  State<FormUpdateUsuarioBody> createState() => _FormUpdateUsuarioBody();
}

class _FormUpdateUsuarioBody extends State<FormUpdateUsuarioBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController nacionalidadeController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController racaController = TextEditingController();
  final TextEditingController sexoController = TextEditingController();

  final usuarioHelper = UsuarioHelper();

  @override
  void initState() {
    super.initState();
    _loadUsuarioData();
  }

  void _loadUsuarioData() async {
    // BUSCANDO O USARIO POR ID E PREECHENDO OS CAMPOS
    Usuario? usuario = await usuarioHelper.getUsuario(widget.idUsuario);
    if (usuario != null) {
      setState(() {
        nomeController.text = usuario.nome;
        nacionalidadeController.text = usuario.nacionalidade;
        idadeController.text = usuario.idade.toString();
        pesoController.text = usuario.peso.toString();
        racaController.text = usuario.raca;
        sexoController.text = usuario.sexo;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // MOSTRA O CAMPO PREENCHIDO
              _buildFormField("Nome", nomeController),
              _buildFormField("Nacionalidade", nacionalidadeController),
              _buildFormField("Idade", idadeController),
              _buildFormField("Peso", pesoController),
              _buildFormField("Raça", racaController),
              _buildFormField("Sexo", sexoController),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField(String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        readOnly: true, // NAO DEIXA ESCREVER
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16.0,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }
}
