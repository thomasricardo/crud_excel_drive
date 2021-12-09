import 'package:excel_google/googlesheet.dart';
import 'package:excel_google/sheetscolumn.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nomeController = new TextEditingController();
    TextEditingController nacaoController = new TextEditingController();
    TextEditingController textoController = new TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Planilha')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: nomeController,
                decoration:
                    InputDecoration(hintText: 'Nome', icon: Icon(Icons.person)),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: nacaoController,
                decoration:
                    InputDecoration(hintText: 'País', icon: Icon(Icons.flag)),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: textoController,
                decoration: InputDecoration(
                    hintText: 'Frase', icon: Icon(Icons.message)),
              ),
              SizedBox(height: 15),
              TextButton(
                child: Text('Salvar', style: TextStyle(fontSize: 20)),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blue,
                  onSurface: Colors.grey,
                ),
                onPressed: () async {
                  final feedback = {
                    SheetsColumn.nome: nomeController.text.trim(),
                    SheetsColumn.nacao: nacaoController.text.trim(),
                    SheetsColumn.texto: textoController.text.trim(),
                  };

                  await FlutterSheet.insert([feedback]);

                  nomeController.clear();
                  nacaoController.clear();
                  textoController.clear();

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Salvo com Sucesso"),
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
