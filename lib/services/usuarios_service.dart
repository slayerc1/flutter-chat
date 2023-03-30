import 'package:http/http.dart' as http;

import 'package:chat/global/environment.dart';
import 'package:chat/services/services.dart';
import 'package:chat/models/models.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {

    try {
      
      final url = Uri.http(Environment.baseUrl, '${Environment.apiUrl}/usuarios');
      final resp = await http.get(url, 
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken() ?? ''
        }
      );

      final usuariosResponse = UsuariosResponse.fromRawJson(resp.body);
      return usuariosResponse.usuarios;

    } catch (e) {
      return [];
    }
  }
}