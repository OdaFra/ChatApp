import 'package:flutter/material.dart';
import 'package:front_chat_app/models/usuarios.dart';
import 'package:front_chat_app/services/auth_services.dart';
import 'package:front_chat_app/services/chat_service.dart';
import 'package:front_chat_app/services/socket_services.dart';
import 'package:front_chat_app/services/usuarios_services.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final usuariosService = UsuariosService();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<Usuario> usuariosdbMongo = [];

  // final usuarios = [
  //   Usuario(uid: '1', nombre: 'Maria', email: 'test1@test.com', online: true),
  //   Usuario(
  //       uid: '2', nombre: 'Fernando', email: 'test2@test.com', online: true),
  //   Usuario(uid: '3', nombre: 'Oscar', email: 'test3@test.com', online: true),
  //   Usuario(uid: '4', nombre: 'Ana', email: 'test3@test.com', online: true)
  // ];

  @override
  void initState() {
    _cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final autService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final usuario = autService.usuario;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          usuario.nombre,
          style: const TextStyle(color: Colors.black54),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.black54),
            onPressed: () {
              socketService.disconnect();
              Navigator.pushReplacementNamed(context, 'login');
              AuthService.deleteToken();
            }),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            // ignore: unrelated_type_equality_checks
            child: socketService.serverStatus == ServerStatus.OnLine
                ? Icon(Icons.check_circle, color: Colors.blue[400])
                : Icon(Icons.offline_bolt, color: Colors.blue[400]),
          )
        ],
      ),
      body: SmartRefresher(
          controller: _refreshController,
          onRefresh: _cargarUsuarios,
          header: WaterDropHeader(
              complete: Icon(Icons.check, color: Colors.blue[400]),
              waterDropColor: Colors.blue[400] ?? Colors.blue),
          enablePullDown: true,
          child: _listViewUsuarios()),
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, i) => _UsuariosListTile(usuariosdbMongo[i]),
      separatorBuilder: (_, i) => const Divider(),
      itemCount: usuariosdbMongo.length,
    );
  }

  // ignore: non_constant_identifier_names
  ListTile _UsuariosListTile(Usuario usuario) => ListTile(
        title: Text(usuario.nombre),
        subtitle: Text(usuario.email),
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(usuario.nombre.substring(0, 2)),
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
              color: usuario.online ? Colors.green[300] : Colors.red,
              borderRadius: BorderRadius.circular(100)),
        ),
        onTap: () {
          // print(usuario.nombre);
          final chatService = Provider.of<ChatService>(context, listen: false);
          chatService.usuarioPara = usuario;
          Navigator.pushNamed(context, 'chat');
        },
      );

  _cargarUsuarios() async {
    usuariosdbMongo = await usuariosService.getUsuarios();
    setState(() {});
    //await Future.delayed(const Duration(milliseconds: 1000));

    _refreshController.refreshCompleted();
  }
}
