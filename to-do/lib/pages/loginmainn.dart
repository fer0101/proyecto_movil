import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spiner/cubit/logincubit.dart';
import 'package:spiner/cubit/loginstatus.dart';
import 'package:spiner/pages/guardarlista.dart';
//import 'package:spiner/pages/tasks_pages.dart';

class LoginPagee extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPagee> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<logincubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const guardarlista()),
          );
        }
      },
      child: BlocBuilder<logincubit, LoginState>(
        builder: (context, state) {
          if (state.status == LoginStatus.init) {
            return _buildLoginForm(context);
          } else if (state.status == LoginStatus.loading) {
            return const CircularProgressIndicator();
          } else if (state.status == LoginStatus.failure) {
            return const Text('error al iniciar sesion');
          }
          return const Text('otro error al iniciar secion');
        },
      ),
    );
  }

  Widget _icon() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://i.pinimg.com/736x/e1/b5/03/e1b5039385d9f2ba2bbf8a80c7e35fe0.jpg"),
              fit: BoxFit.cover),
          border: Border.all(color: Colors.white, width: 2),
          shape: BoxShape.circle),
      child: const Icon(
        Icons.person,
        color: Colors.transparent,
        size: 130,
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('inicio secion'),
        ),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _icon(),
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'usuario',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'contraseña',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.push
                        //(
                        // context,
                        //   MaterialPageRoute(builder: (context) => const guardarlista()),
                        // );
                        BlocProvider.of<logincubit>(context).login(
                            _usernameController.text, _passwordController.text);
                      },
                      child: const Text('inicia sesion'),
                    ),
                  ],
                ))));
  }
}
