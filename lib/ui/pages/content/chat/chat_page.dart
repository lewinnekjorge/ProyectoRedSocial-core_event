import 'package:core_event/data/model/message.dart';
import 'package:core_event/domain/controller/authentication_controller.dart';
import 'package:core_event/domain/controller/chat_controller.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

final databaseReference = FirebaseDatabase.instance.reference();

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController _controller;
  late ScrollController _scrollController;
  ChatController chatController = Get.find();
  AuthenticationController authenticationController = Get.find();

  String? msg;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _scrollController = ScrollController();
    chatController.start();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    chatController.stop();
    super.dispose();
  }

  Widget _item(Message element, int posicion, String uid, String? msg) {
    logInfo(
        'Current user? -> ${uid == element.user} msg -> ${msg = element.text}');
    var _radious = const Radius.circular(12);
    var _corner = const Radius.circular(4);
    var remote = uid != element.user;
    return Card(
      margin: const EdgeInsets.all(4.0),
      elevation: 10,
      color: uid == element.user ? Colors.orange[400] : Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: remote ? _corner : _radious,
            bottomRight: remote ? _radious : _corner),
      ),
      child: ListTile(
        onTap: () => chatController.updateMsg(element),
        onLongPress: () => chatController.deleteMsg(element, posicion),
        title: Text(
          msg!,
          textAlign: uid == element.user ? TextAlign.right : TextAlign.left,
        ),
      ),
    );
  }

  Widget _list() {
    String uid = authenticationController.getUid();
    //print('Current user $uid');
    return GetX<ChatController>(builder: (controller) {
      WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollToEnd());
      return ListView.builder(
        cacheExtent: 100,
        controller: _scrollController,
        reverse: false,
        shrinkWrap: true,
        itemCount: chatController.messages.length,
        itemBuilder: (context, index) {
          var element = chatController.messages[index];
          return _item(element, index, uid, msg);
        },
      );
    });
  }

  Future<void> _sendMsg(String text) async {
    //FocusScope.of(context).requestFocus(FocusNode());
    logInfo("Calling _sendMsg with $text");
    await chatController.sendMsg(text);
  }

  Widget _textInput() {
    Color primaryColor = Theme.of(context).colorScheme.primary;
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            margin: const EdgeInsets.only(left: 5.0, top: 5.0),
            child: TextField(
              key: const Key('MsgTextField'),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 0.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: primaryColor,
                    width: 0.0,
                  ),
                ),
                contentPadding: const EdgeInsets.all(8.0),
                labelText: 'Escribe tu mensaje',
                hintText: 'Escribe tu Mensaje.....',
              ),
              onSubmitted: (value) {
                _sendButtonTap();
              },
              controller: _controller,
            ),
          ),
        ),
        IconButton(
            key: const Key('sendButton'),
            icon: const Icon(Icons.send),
            onPressed: () {
              _sendButtonTap();
            })
      ],
    );
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  _sendButtonTap() async {
    if (_controller.text.isEmpty) {
      return;
    }
    _sendMsg(_controller.text);
    _clearMessage();
  }

  _clearMessage() {
    _controller.text = '';
  }

  _scrollToEnd() async {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollToEnd());
    return Column(
      children: [Expanded(flex: 4, child: _list()), _textInput()],
    );
  }
}
