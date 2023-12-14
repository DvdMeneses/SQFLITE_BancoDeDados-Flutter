import 'package:flutter/material.dart';
import 'package:segunda_prova/helpers/usuario_helper.dart';
import 'package:segunda_prova/ui/telaHome_page.dart';

import '../domain/Usuario.dart';

class TelaAltera extends StatelessWidget {
  final int idUsuario;

  const TelaAltera({
    super.key,
    required this.idUsuario,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Editar Usuario"),
      ),
      body: SingleChildScrollView(
          // RECEBE UM ID DE USUARIO
          child: FormUpdateUsuarioBody(idUsuario: idUsuario)),
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
  int id = 0;
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
    // BUSCA O USUARIO POR ID NO BANCO
    Usuario? usuario = await usuarioHelper.getUsuario(widget.idUsuario);
    if (usuario != null) {
      // SE NAO FOR NULO PREENCHE UM USER
      setState(() {
        id = usuario.id;
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
    return Form(
      key: _formKey,
      child: Padding(
        // MOSTRA OS CAMPOS PREENCHIDOS E DEIXA EDITAR
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField("${nomeController.text}", nomeController),
            _buildTextField(
                "${nacionalidadeController.text}", nacionalidadeController),
            _buildTextField("${idadeController.text}", idadeController,
                TextInputType.number),
            _buildTextField(
                "${pesoController.text}", pesoController, TextInputType.number),
            _buildTextField("${racaController.text}", racaController),
            _buildTextField("${sexoController.text}", sexoController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _editarUsuario(),
              child: const Text("EDITAR"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller,
      [TextInputType? keyboardType]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        readOnly: false, // Torna o campo somente leitura
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            // VERIFICAÇÃO SE O CAMPO É NULO
            return 'Campo obrigatório';
          }
          return null;
        },
      ),
    );
  }

  _editarUsuario() async {
    print("-------------------------------------------");
    if (_formKey.currentState?.validate() ?? false) {
      // PREENCHE UM USER E ENVIA PRA TELA DE LISTAGEM E LA ATUALIZA A LISTA COM O USER
      Usuario user = Usuario(
        nomeController.text.toLowerCase(),
        nacionalidadeController.text.toLowerCase(),
        int.parse(idadeController.text),
        racaController.text.toLowerCase(),
        int.parse(pesoController.text),
        sexoController.text.toLowerCase(),
      );
      user.id = id;
      print(user.id);
      print(user.nome);
      print(user.nacionalidade);
      print(user.idade);
      print("---------------------------------------");
      await usuarioHelper.updateUsuario(user);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('UPDATE realizado com sucesso!'),
        ),
      );

      Navigator.pop(context, user);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }
}
