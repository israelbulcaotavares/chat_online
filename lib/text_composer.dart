import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefulWidget {

   const TextComposer(this.sendMessage, {Key? key}) : super(key: key);

  final Function({String text, File imgFile}) sendMessage;

  @override
  _TextComposerState createState() => _TextComposerState();

}

class _TextComposerState extends State<TextComposer> {

  final TextEditingController _controler = TextEditingController();

  bool _isComposing = false;

  void _reset(){
    _controler.clear();
    setState(() {
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          IconButton(

              icon: Icon(Icons.photo_camera),
            onPressed: () async {
              final XFile? imgFile = await ImagePicker().pickImage(source: ImageSource.camera);
              // supondo que 'imgFile' não é nulo aqui.
              final File file = File(imgFile!.path);
               widget.sendMessage(imgFile: file);

            },
          ),
          Expanded(
              child: TextField(
                controller: _controler,
                decoration: InputDecoration.collapsed(hintText: "Enviar uma mensagem"),
                onChanged: (text){
                  setState(() {
                    _isComposing = text.isNotEmpty;
                  });
                },
                onSubmitted: (text){
                  widget.sendMessage(text: text);
                  _reset();
                },
              ),
          ),
          IconButton(
              icon: Icon(Icons.send),
            onPressed: _isComposing ? (){
              widget.sendMessage(text: _controler.text);
              _reset();
            }: null,
          ),

        ],
      ),
    );
  }
}
