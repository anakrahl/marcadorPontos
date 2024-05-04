import 'package:flutter/material.dart'; //importar pacote que fornece a estrutura base

void main() {
  //método principal da aplicação
  runApp(const Pontuacao());
}

class Pontuacao extends StatelessWidget {
  //definição de classe
  const Pontuacao({super.key});

  @override //subescrever
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Marcador de pontuação',
      home: Pagina(
          title: 'Marcador de pontuação'), //definir titulos da página principal
    );
  }
}

class Pagina extends StatefulWidget {
  const Pagina(
      {super.key,
      required this.title}); //construtor da aplicação, com o TITLE (titulo) obrigatorio

  final String title;

  @override //criar estado da página:
  State<Pagina> createState() =>
      ContarPontos(); //retornar o estado, que irá contar os pontos da partida
}

class ContarPontos extends State<Pagina> {
  int jogador1 = 0; //inicializar os pontos de ambos os jogadores em 0
  int jogador2 = 0;

  void pontuar(jogador, acao) {
    //verificando qual jogador fará qual ação (apertar botão de + ou -)
    setState(() {
      if (jogador == 1) {
        if (acao == '+') {
          //se a ação do botão for +, deverá incrementar o valor do contador (jogador 1)
          jogador1++;
        } else {
          jogador1--; //ou então, diminuir o valor
        }
      } else {
        // parte do jogador 2
        if (acao == '+') {
          //se a ação do botão for +, deverá incrementar o valor do contador2
          jogador2++;
        } else {
          //ou então
          jogador2--; //diminuir o valor
        }
      }

      if (jogador1 < 0) jogador1 = 0; //evitar que a pontuação seja menor que 0
      if (jogador2 < 0) jogador2 = 0;

      if (jogador1 > 12) {
        resetar(); //reiniciar o contador depois que o jogador atingir 12 pontos
      }
      if (jogador2 > 12) resetar(); //evitar que o contador ultrapasse 12 pontos
    });
  }

  void resetar() {
    //função para recomeçar o jogo
    setState(() {
      jogador1 = 0; //os contadores devem reiniciar, em 0
      jogador2 = 0; //os contadores devem reiniciar, em 0
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //fornece a estrutura base / widget raiz da aplicação
        body: Column(
      children: [
        Row(
          //linhas
          children: [
            Expanded(
                //espaçamento dos componentes
                child: Column(
              children: [
                Text(
                  jogador1
                      .toString(), //pontuação do jogador 1 (convertido em string)
                  style:
                      const TextStyle(fontSize: 72), //alterar tamanho de fonte
                )
              ],
            )),
            Expanded(
                child: Column(
              //coluna para apresentar componentes na tela
              children: [
                Text(
                  jogador2
                      .toString(), //pontuação jogador 2 (convertido em string)
                  style:
                      const TextStyle(fontSize: 72), //alterar tamanho da fonte
                )
              ], //fechamentos
            ))
          ],
        ),
        Padding(
          //espaçamento interno
          padding: const EdgeInsets.all(24.0),
          child: Row(
            //linha para apresentar componentes na tela
            children: [
              Expanded(
                //espaçamento dos componentes na tela
                child: Column(
                  children: [
                    Row(
                      children: [
                        //filhos: o que estão dentro do componente
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                //botão que, quando pressionado, deve diminuir 1 do jogador 1
                                pontuar(1, '-');
                              },
                              child: const Text(
                                  "-")), //mostrar o símbolo da ação no botão
                        ),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                //deve aumentar 1 do jogador 1
                                pontuar(1, '+');
                              },
                              child: const Text(
                                  "+")), //mostrar o símbolo da ação no botão
                        ),
                      ],
                    ),
                  ], //fechamentos
                ),
              ),
              Expanded(
                //espaçamento das ações dos jogadores
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                //diminuir 1 ponto do jogador 2
                                pontuar(2, '-');
                              },
                              child: const Text(
                                  "-")), //mostrar o símbolo da ação no botão
                        ),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                //aumentar 1 ponto do jogador 2
                                pontuar(2, '+');
                              },
                              child: const Text(
                                  "+")), //mostrar o símbolo da ação no botão
                        ),
                      ],
                    )
                  ],
                ),
              ), //fechamentos
            ],
          ),
        ),
        Padding(
          //espaçamento interno
          padding: const EdgeInsets.all(24.0), //valor do espaçamento
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: resetar,
                    child: const Text(
                        "Resetar")), // botão que, quando pressionado, deve reiniciar o jogo (e os contadores)
              )
            ],
          ), //fechamentos
        )
      ],
    ));
  } //fim do programa
}
