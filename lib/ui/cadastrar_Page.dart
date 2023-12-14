import 'package:flutter/material.dart';
import 'package:segunda_prova/helpers/usuario_helper.dart';
import 'package:segunda_prova/ui/telaHome_page.dart';
import 'package:segunda_prova/widgets/custom_form_field.dart';

import '../domain/Usuario.dart';

class CadastroPage extends StatelessWidget {
  const CadastroPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Cadastro de Usuários"),
      ),
      body: FormUsuarioBody(),
    );
  }
}

class FormUsuarioBody extends StatefulWidget {
  const FormUsuarioBody({Key? key});

  @override
  State<FormUsuarioBody> createState() => _FormUsuarioBodyState();
}

class _FormUsuarioBodyState extends State<FormUsuarioBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController nacionalidadeController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController racaController = TextEditingController();
  final TextEditingController sexoController = TextEditingController();

  final usuarioHelper = UsuarioHelper();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Adicionando o SingleChildScrollView aqui
      child: Form(
        // FORMULARIO DE CADASTRO
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTextField("Nome", nomeController),
              _buildTextField("Nacionalidade", nacionalidadeController),
              _buildTextField("Idade", idadeController, TextInputType.number),
              _buildTextField("Peso", pesoController, TextInputType.number),
              _buildTextField("Raça", racaController),
              _buildTextField("Sexo", sexoController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _cadastrarUsuario(),
                child: const Text("Cadastrar"),
              ),
            ],
          ),
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
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          // VALIDACAO DOS CAMPOS Q.6
          if (value == null || value.isEmpty) {
            return 'Campo obrigatório';
          }
          return null;
        },
      ),
    );
  }

  void _cadastrarUsuario() async {
    if (_formKey.currentState?.validate() ?? false) {
      // SE FORMULARIO VALIDADO DEIXA CADASTRAR Q.6
      Usuario user = Usuario(
        nomeController.text.toLowerCase(),
        nacionalidadeController.text.toLowerCase(),
        int.parse(idadeController.text),
        racaController.text.toLowerCase(),
        int.parse(pesoController.text),
        sexoController.text.toLowerCase(),
      );
      await usuarioHelper.saveUsuario(user);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Cadastro realizado com sucesso!'), // MENSAGEM QUANDO CADASTRADO1.6
        ),
      );

      Navigator.pop(context);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const HomePage()), // ATUALIZAÇÃO DA TELA INICIAL Q.6
      );
    }
  }
}
