import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat/widgets/widgets.dart';


class ChatPage extends StatefulWidget {

  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {

  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  final List<ChatMessage> _messages = [];

  bool _estaEscribiendo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
              child: const Text('Ra', style: TextStyle(fontSize: 12)),
            ),
            const SizedBox(height: 3),
            const Text('Raul', style: TextStyle(color: Colors.black54, fontSize: 12))
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (context, index) => _messages[index],
              reverse: true,
            ),
          ),

          const Divider(height: 1),

          Container(
            color: Colors.white,
            child: _inputChat(),
          )
        ],
      )
   );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (value) {
                  setState(() {
                    if (value.trim().isNotEmpty) {
                      _estaEscribiendo = true;
                    } else {
                      _estaEscribiendo = false;
                    }
                  });
                },
                decoration: const InputDecoration.collapsed(
                  hintText: 'Enviar mensaje'
                ),
                focusNode: _focusNode,
              ),
            ),

            // Boton de enviar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Platform.isIOS
                ? CupertinoButton(
                    onPressed: _estaEscribiendo
                        ? () => _handleSubmit(_textController.text.trim())
                        : null,
                    child: const Text('Enviar')
                  )
                : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: IconTheme(
                    data: IconThemeData(color: Colors.blue[400]),
                    child: IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: const Icon(Icons.send),
                      onPressed: _estaEscribiendo
                        ? () => _handleSubmit(_textController.text.trim())
                        : null
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

  _handleSubmit(String texto) {

    if (texto.isEmpty) return;

    final newMessage = ChatMessage(
      uid: '3', 
      texto: texto, 
      animationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 200))
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
      _textController.clear();
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    // TODO: Off del socket

    for(ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    
    super.dispose();
  }
}