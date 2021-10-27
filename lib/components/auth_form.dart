import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/exceptions.dart';
import 'package:shop/models/models.dart';
import 'package:shop/utils/utils.dart';

enum AuthMode { SignUp, Login }

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

//higorgustavo@gmail.com
class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  //Existe esse negocio de chave glogal e existe esse negocio de tipo FormState
  //utilizando-se essa chave você pode manusear metodos do tipo
  //.currentState.save()
  //.currentWidget
  //.currentContext
  void _switchAuthMode() {
    setState(() {
      _authMode == AuthMode.Login
          ? _authMode = AuthMode.SignUp
          : _authMode = AuthMode.Login;
    });
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Ocorreu um Erro'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Fechar'),
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    print('A função _submit() foi acionada');
    final isValid = _formKey.currentState?.validate() ?? false;
    //Isso é uma verificação para entender se esse formulario é válido.
    //ou seja: se há um estado vinculado a esse formulário e se esse estado é valido
    //O estado pode não estar presente...por isso se usa o ?
    // Mesmo o estado presente ele pode não ser válido
    if (!isValid) return;

    setState(() => _isLoading = true);
    _formKey.currentState?.save();
    Auth auth = Provider.of<Auth>(context, listen: false);

    try {
      if (_isLogin()) {
        //Se eu estiver com login eu vou enviar uma requisição de login
        await auth.login(
          _authData['email']!,
          _authData['password']!,
        );
      } else {
        //do contrario vou enviar requisição pra registrar
        await auth.signUp(
          _authData['email']!,
          _authData['password']!,
        );
        //Eu posso colocar o ! dizendo que essas informações estarão presentes
        //por eu ter feito a validação do form antes de passar esses dados aqui
      }
    } on AuthException catch (error) {
      print('Um erro do tipo AuthException foi detectado');
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Ocorreu um erro não catalogado');
    } finally {
      print('A execução dos procedimentos de erro finalizou');
    }

    //_authData
    setState(() => _isLoading = false);
  }

  //Aqui ele iniciou o enum como login..ao inves de usar uma variavel qualquer
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
//faz verificações pra saber se está em login ou em signUp
  bool _isLogin() => _authMode == AuthMode.Login;
  bool _isSignup() => _authMode == AuthMode.SignUp;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final deviceSize = MediaQuery.of(context).size;
    //variavel utilizada para fazer com que o container do card fique a 75% da tela
    final deviceRelation = deviceSize.height / deviceSize.width;
    print('Tamanho da tela x: ${deviceSize.width}');
    print('Tamanho da tela y: ${deviceSize.height}');
    print('Relação entre y/x: $deviceRelation');
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 420,
        width: deviceSize.width * 0.75,
        padding: EdgeInsetsDirectional.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (email) => _authData['email'] = email ?? '',
                  validator: (_email) {
                    final email = _email ?? '';
                    if (email.trim().isEmpty || !email.contains('@')) {
                      return 'Informe um e-mail válido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'password'),
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (password) => _authData['password'] = password ?? '',
                  validator: (_password) {
                    final password = _password ?? '';
                    if (password.isEmpty || password.length < 5) {
                      return 'Informe uma senha válida';
                    }
                    return null;
                  },
                ),
                if (_isSignup())
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Confirmar password'),
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    //para que a validação não seja disparada na validação do login eu posso fazer
                    //essa condicional de seguranca:
                    validator: _isLogin()
                        ? null
                        : (_password) {
                            //Para ter acesso ao campo digitado no textfield acima pra fazer
                            //a confirmação eu vou precisar utilizar o textEditingController()
                            final password = _password ??
                                ''; //Estrategia para trabalhar com certeza com valor não null
                            if (password != _passwordController.text) {
                              return 'Senhas digitadas não conferem';
                            } // Se a confi
                          },
                  ),
                SizedBox(
                  height: 50,
                ),
                (_isLoading)
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _submit,
                        child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text(_isLogin() ? 'ENTRAR' : 'REGISTRAR')),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(45),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 8),
                        ),
                      ),
                SizedBox(
                  height: 50,
                ),
                TextButton(
                  onPressed: _switchAuthMode,
                  child: Text(
                      _isLogin() ? 'DESEJA REGISTRAR?' : 'JÁ POSSUI CONTA?'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
