import 'package:flutter/material.dart';

void main() => runApp(
      BancoApp(),
    );

class BancoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Dashboard(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferência'),
        shadowColor: Colors.brown,
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          Editor(
              controlador: _controladorCampoNumeroConta,
              rotulo: 'Número da Conta',
              dica: '0000'),
          Editor(
              controlador: _controladorCampoValor,
              rotulo: 'Valor',
              dica: '0.00',
              icone: Icons.monetization_on_sharp),
          ElevatedButton(
            child: Text('Confirmar'),
            onPressed: () {
              _criaTransferencia(
                context,
                _controladorCampoNumeroConta,
                _controladorCampoValor,
              );
            },
          )
        ],
      ),
    );
  }
}

void _criaTransferencia(
    context, _controladorCampoNumeroConta, _controladorCampoValor) {
  debugPrint('clicou no confirmar');
  final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
  final double? valor = double.tryParse(_controladorCampoValor.text);
  if (numeroConta != null && valor != null) {
    final transferenciaCriada = Transferencia(valor, numeroConta);
    debugPrint('Criando transferência');
    debugPrint('$transferenciaCriada');
    Navigator.pop(context, transferenciaCriada);
  }
}

class Editor extends StatelessWidget {
  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;

  Editor({
    super.key,
    this.controlador,
    this.rotulo,
    this.dica,
    this.icone,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(
          fontSize: 24.0,
        ),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class ListaTransferencia extends StatefulWidget {
  final List<Transferencia> _transferencias = [];
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListaTransferenciaState();
  }
}


class ListaTransferenciaState extends State<ListaTransferencia> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferências'),
        shadowColor: Colors.brown,
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Transferencia?> future = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return FormularioTransferencia();
              },
            ),
          );

          future.then(
            (transferenciaRecebida) {
              if (transferenciaRecebida != null) {
                debugPrint('chegou no then do future');
                debugPrint('$transferenciaRecebida');
                setState(
                  () {
                    widget._transferencias.add(transferenciaRecebida);
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: ListTile(
        leading: Icon(
          Icons.monetization_on_sharp,
          color: Colors.green,
        ),
        title: Text(
          _transferencia.valor.toString(),
        ),
        subtitle: Text(
          _transferencia.numeroConta.toString(),
        ),
      ),
    );
  }
}

class CardTransferencia extends StatelessWidget {
  const CardTransferencia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          // Navegar para a página de contatos quando o cartão for clicado
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ListaTransferencia()),
          );
        },
      child: Card(
        elevation: 1,
        color: Colors.yellowAccent,
        child: SizedBox(
          width: 300,
          height: 100,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.swap_horiz, // Ícone de transferência, você pode ajustar conforme necessário
                  color: Colors.black,
                  size: 30,
                ),
                SizedBox(width: 10), // Espaço entre o ícone e o texto
                Text(
                  'Transferência',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
    );
  }
}
/* **************************************************************************** */
class FormularioContato extends StatelessWidget {
  final TextEditingController _controladorCampoNome = TextEditingController();
  final TextEditingController _controladorCampoEndereco = TextEditingController();
  final TextEditingController _controladorCampoTelefone = TextEditingController();
  final TextEditingController _controladorCampoEmail = TextEditingController();
  final TextEditingController _controladorCampoCpf = TextEditingController();

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Contato'),
        shadowColor: Colors.brown,
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EditorContato(
              controlador: _controladorCampoNome,
              rotulo: 'Nome',
              dica: 'Nome completo',
            ),
            EditorContato(
              controlador: _controladorCampoEndereco,
              rotulo: 'Endereço',
              dica: 'Endereço completo',
            ),
            EditorContato(
              controlador: _controladorCampoTelefone,
              rotulo: 'Telefone',
              dica: 'Telefone',
            ),
            EditorContato(
              controlador: _controladorCampoEmail,
              rotulo: 'Email',
              dica: 'exemplo@email.com',
              icone: Icons.email,
            ),
            EditorContato(
              controlador: _controladorCampoCpf,
              rotulo: 'CPF',
              dica: '000.000.000-00',
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _cadastrarContato(
                  context,
                  _controladorCampoNome.text,
                  _controladorCampoEndereco.text,
                  _controladorCampoTelefone.text,
                  _controladorCampoEmail.text,
                  _controladorCampoCpf.text,
                );
              },
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }

void _cadastrarContato(
  BuildContext context,
  String nome,
  String endereco,
  String telefone,
  String email,
  String cpf,
) 
{
  debugPrint('Clicou no cadastrar');
  final String nome = _controladorCampoNome.text;
  final String endereco = _controladorCampoEndereco.text;
  final String telefone = _controladorCampoTelefone.text;
  final String email = _controladorCampoEmail.text;
  final String cpf = _controladorCampoCpf.text;
  if (nome != null && endereco != null && telefone != null && email != null && cpf != null) {
    final contatoCriado = Contato(nome, endereco, telefone, email, cpf);
    debugPrint('Criando contato');
    debugPrint('$contatoCriado');
    Navigator.pop(context, contatoCriado);
  }
}
}

class EditorContato extends StatelessWidget {
  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;

  EditorContato({
    super.key,
    this.controlador,
    this.rotulo,
    this.dica,
    this.icone,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(
          fontSize: 24.0,
        ),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        
      ),
    );
  }
}


class ListaContato extends StatefulWidget {
  final List<Contato> _contatos = [];
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListaContatoState();
  }
}

class ListaContatoState extends State<ListaContato> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos'),
        shadowColor: Colors.brown,
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView.builder(
        itemCount: widget._contatos.length,
        itemBuilder: (context, indice) {
          final contato = widget._contatos[indice];
          return ItemContato(contato);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Contato?> future = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return FormularioContato();
              },
            ),
          );

          future.then(
            (contatoRecebido) {
              if (contatoRecebido != null) {
                debugPrint('Chegou no then do future');
                debugPrint('$contatoRecebido');
                setState(
                  () {
                    widget._contatos.add(contatoRecebido);
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}


class ItemContato extends StatelessWidget {
  final Contato _contato;

  ItemContato(this._contato);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          Icons.person,
          color: Colors.blue,
        ),
        title: Text(
          _contato.nome,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Telefone: ${_contato.telefone}'),
            Text('Endereço: ${_contato.endereco}'),
            Text('E-mail: ${_contato.email}'),
            Text('CPF: ${_contato.cpf}'),
          ],
        ),
      ),
    );
  }
}



/* **************************************************************************** */
class CardContato extends StatelessWidget {
  const CardContato({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          // Navegar para a página de contatos quando o cartão for clicado
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ListaContato()),
          );
        },
        child: Card(
          elevation: 1,
          color: Colors.deepOrangeAccent,
          child: SizedBox(
            width: 300,
            height: 100,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Contato',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        shadowColor: Colors.brown,
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          CardContato(),
          CardTransferencia(),
        ],
      ),
    );
  }
}


class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(
    this.valor,
    this.numeroConta,
  );

  @override
  String toString() {
    return 'Transferencia(valor: $valor, numeroConta: $numeroConta)';
  }
}

class Contato {
  final String nome;
  final String endereco;
  final String telefone;
  final String email;
  final String cpf;

  Contato(
    this.nome,
    this.endereco,
    this.telefone,
    this.email,
    this.cpf,
  );

  @override
  String toString() {
    return 'Contato(nome: $nome, endereco: $endereco, telefone: $telefone, email: $email, cpf: $cpf)';
  }
}
