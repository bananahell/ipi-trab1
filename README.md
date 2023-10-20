# Trabalho de IPI 2023/2

Trabalho de Introdução a Processamento de Imagens da Universidade de Brasília ensinada pelo professor Bruno Luiggi Macchiavello Espinoza.  

Pedro Nogueira - 14/0065032  
UnB - 2023/2  

## Estrutura

Código [./main.m](https://github.com/bananahell/ipi-trab1/blob/main/main.m) é o script com acesso ao resto do código.  

Códigos em Matlab na pasta [./code/](https://github.com/bananahell/ipi-trab1/tree/main/code), imagens de entrada das funções na pasta [./img/](https://github.com/bananahell/ipi-trab1/tree/main/img), documentos de especificação dados pelo professor e relatório final do projeto em pdf e tex na pasta [./docs/](https://github.com/bananahell/ipi-trab1/tree/main/docs).  

## Versões

Matlab versão 9.4.0.813654 (R2018a).  

## Projeto

Como o professor pediu nas [especificações](https://github.com/bananahell/ipi-trab1/blob/main/docs/Projeto_1.pdf), o projeto era na verdade uma listinha de três exercícios:  

### Q1 - Alargamento e smoothing de píxels

Pra [primeira questão](https://github.com/bananahell/ipi-trab1/blob/main/code/yuvEnlarger.m) tem que ler o [./img/foreman.yuv](https://github.com/bananahell/ipi-trab1/blob/main/img/foreman.yuv), arquivo que na verdade tem um vídeo com frames em formato YUV, na frame pedida.  

Assim como uma imagem RGB tem os quadros Red Green e Blue na sua composição, o YUV tem o brilho no Y e as cores na composição do U com o V. O vídeo está em dimensões 352x288, e as componentes YUV estão no modo 4\:2\:0, o que só significa que para ler a Y tive que ler 352\*288 (101376) bytes, e para ler o U e o V tive que ler 176\*144 (50688) bytes duas vezes (uma pra pegar o U e outra pra pegar o V). Para ler um frame específico, só pulei a quantidade de bytes certa pra chegar no frame certo. Exemplo, se eu fosse pegar o terceiro frame, eu teria que pegar o tamanho total de um frame (101376 + 2\*50688 = 202752) e multiplicar por dois porque vou pular dois frames (2 \* 202752 = 405504), tendo agora a posição inicial do terceiro frame, onde posso pegar os tantos bytes dele (202752 bytes).  

Com as componentes do frame, era pra colocar as componentes U e V no tamanho da Y, então eu tinha que dobrar a largura e altura delas. O professor falou pra usar dois métodos: o de só replicar os vizinhos e o de tirar a média dos vizinhos para os quadrados novos. Vou fazer esses dois nesse exemplo aqui (tabela nesse formato de markdown sempre pede que bote um header, então ignora as corzinha das linhas):  

| 2 | 4 | 6 | 8 |
|---|---|---|---|
| 10 | 12 | 14 | 16 |
| 18 | 20 | 22 | 24 |
| 26 | 28 | 30 | 32 |

Para replicar é só pegar cada píxel e colocar de novo na sua direita, embaixo, e na direita embaixo, fazendo um quadradinho 2x2:  

| 2 | 2 | 4 | 4 | 6 | 6 | 8 | 8 |
|---|---|---|---|---|---|---|---|
| 2 | 2 | 4 | 4 | 6 | 6 | 8 | 8 |
| 10 | 10 | 12 | 12 | 14 | 14 | 16 | 16 |
| 10 | 10 | 12 | 12 | 14 | 14 | 16 | 16 |
| 18 | 18 | 20 | 20 | 22 | 22 | 24 | 24 |
| 18 | 18 | 20 | 20 | 22 | 22 | 24 | 24 |
| 26 | 26 | 28 | 28 | 30 | 30 | 32 | 32 |
| 26 | 26 | 28 | 28 | 30 | 30 | 32 | 32 |

O de média de vizinhos tu preenche os píxels novos com os valores da média dos vizinhos. O píxel que criei na direita faço a média do original com o da direita, o píxel que criei embaixo faço a média do original com o de baixo, e o da diagonal direita de baixo faço..... ah, você entendeu (PS: isso tudo se não tá na borda... o que tá na borda não tem vizinho pra tirar média, então só replico mesmo):  

| 2 | 3 | 4 | 5 | 6 | 7 | 8 | 8 |
|---|---|---|---|---|---|---|---|
| 6 | 7 | 8 | 9 | 10 | 11 | 12 | 8 |
| 10 | 11 | 12 | 13 | 14 | 15 | 16 | 16 |
| 14 | 15 | 16 | 17 | 18 | 19 | 20 | 16 |
| 18 | 19 | 20 | 21 | 22 | 23 | 24 | 24 |
| 22 | 23 | 24 | 25 | 26 | 27 | 28 | 24 |
| 26 | 26 | 28 | 28 | 30 | 30 | 32 | 32 |
| 26 | 26 | 28 | 28 | 30 | 30 | 32 | 32 |

Y, U, e V ficaram do mesmo tamanho depois desses alargamentos, agora dá pra usar `ycbcr2rgb()` com esses três pra visualizar a imagem em RGB. Depois o professor pede pra alargar de novo, mas dessa vez precisa alargar os três componentes incluindo o Y, que aí os três vão ficar 704x576. A grande ideia dessa parte é mostrar um modo de borrar a imagem pra deixá-la "melhor". Só replicando, a imagem fica toda quadriculada, enquanto fazendo a média (que borra a imagem), fica mais coeso. Dá pra ver melhor esse efeito no textinho "SIEMENS" no canto esquerdo de cima.  

### Q2 - Filtros laplaciano e gaussiano no domínio do espaço

Aplicar um filtro no domínio do espaço é fazer a convolução desse filtro na imagem. Um convolução é você pegar teu filtro (geralmente um kernelzinho 3x3), inverter ele (ninguém lembra disso, mas geralmente foda-se porque o filtro geralmente é simétrico), e passá-lo pela imagem toda. Passar o filtro significa posicionar o píxel centro do filtro em cada um dos píxels da imagem, e naquela posição da imagem filtrada colocar o píxel da média aritmética da multiplicação de cada píxel junto. Exemplo da convolução passando pelo primeiro píxel na imagem (só que nesse exemplo ele considerou o primeiro píxel não na borda para que o kernel encaixasse completamente.... só presta atenção no quadrado azul pintado em volta da posição do píxel):  

![Convolução no primeiro píxel](https://github.com/bananahell/ipi-trab1/blob/main/readme-imgs/2dConvolution.png)  

Isso é convolução 2D, e é isso que a função `imfilter()` do MATLAB que usei no projeto faz (ha). Agora é só escolher os kernels.  

Filtragem laplaciana te retorna os contornos da imagem, então se tu subtrai a filtrada da original, se tem a imagem com os contornos mais aguçados, sendo assim então um filtro passa-altas porque contornos são as altas frequências de uma image, e filtragem gaussiana borra a imagem porque tira os contornos, dando mais a ideia geral da imagem, snedo assim então um filtro passa-baixas. Os kernels laplacianos de centro -4 e -8 são respectivamente assim:  

| 0 | 1 | 0 |
|---|---|---|
| 1 | -4 | 1 |
| 0 | 1 | 0 |

| 1 | 1 | 1 |
|---|---|---|
| 1 | -8 | 1 |
| 1 | 1 | 1 |

E eu não vou explicar o porquê ʘ‿ʘ. Os filtros gaussianos de σ 0.5 e 1 pedidos no projeto se conseguem usando o `fspecial()` do MATLAB com `'gaussian'`. Com isso só precisa rodar o que foi pedido:

- Aplicar um laplaciano de centro -8  
- Aplicar um gaussiano de σ 0.5 e um laplaciano de centro -4  
- Aplicar um gaussiano de σ 1 e um laplaciano de centro -4

O grande tchan dessa questão é ver que só aplicar o laplaciano passa-altas deixa a imagem tipo cartoonizada porque tá muito cheio de contorno, enquanto passar um gaussiano passa-baixas antes de passar o passa-altas dá uma amaciada no efeito.  

### Q3 - Filtro rejeita-notch no domínio da frequência

Essa parte aqui é top. Antes de tudo, tenho que falar de transformação pro domínio da frequência. Fourier chegou um belo dia e pensou em como todo e qualquer sinal pode ser representado por uma junção de vários senos e cossenos, e agora pronto, a gente se fode aqui com essas ideias nada a ver do que é um sinal. Não vou me adentrar muito na parte teórica aqui do Fourier (vai lá prestar atenção na aula do [Queiroz](http://pesquisar.unb.br/professor/ricardo-lopes-de-queiroz))... Só vou falar que tem como aplicar a transformada de Fourier numa imagem usando `fft2()` no MATLAB. Isso significa que conseguimos criar uma imagem que tem vários pontinhos que reprensentam as diferentes frequências da original. Usando a `fftshift()`, as menores frequências, que são a ideia geral da imagem, ficam no centro, e as maiores, que representam as bordas e pontas da imagem, ficam mais afastadas do centro. Se tu zera os pontinhos das bordas da imagem do domínio da frequência, efetivamente matando as altas frequências, tu basicamente vai ter aplicado um filtro passa-baixas na original, borrando ela. Isso é top, porque em vez de fazer uma convolução que nem na Q2 ali em cima, tu pode simplesmente criar uma máscara de quais frequências tu quer matar (colocando zeros nas posições delas) e multiplicando a máscara com a imagem da tranformada.  

Agora tenho que falar do problema. Se tu usa uma câmera digital para tirar foto de uma imagem digital (tipo uma tela de computador), isso não tira uma imagem toda zoada? Esse é o [efeito de Moiré, que tem de monte na imagem que foi usada nessa parte do projeto](https://github.com/bananahell/ipi-trab1/blob/main/img/moire.tif). Esse efeito deixa uns resíduos na [imagem no domínio da frequência](https://github.com/bananahell/ipi-trab1/blob/main/docs/imgs/Q3-2%20Reject%20Notch%20original%20Fourier.png), que são umas estrelinhas em uns pontos da transformada. Tudo que tenho que fazer é zerar a imagem transformada nas posições das estrelinhas!  

O professor deu as posições das estrelinhas que quero zerar nas [especificações do projeto](https://github.com/bananahell/ipi-trab1/blob/main/docs/Projeto_1.pdf), mas com um porém. A imagem no domínio da frequência tem componentes reais e complexas (sim, número imaginário.... pode parar de falar que você nunca vai usar na vida.... espera então as matérias de elétrica kkkk), e essas componentes então não são representadas somente em um só ponto na imagem transformada, mas sim em dois: os dois pontos inversos na imagem. Então se tu quer tirar a frequência que tá no ponto 39 píxels pra direita e 30 píxels pra baixo do ponto central da imagem (vamo chamar esse ponto central de C), tu tem que zerar a frequência no ponto C + (39,30) e também no ponto C + (-39,-30). O projeto pediu para apagar 4 pontos, mas por isso vamos ter que apagar na verdade 8 pontos.  

Então é isso, só zerar esses pontos? Sim, mas o professor ainda pediu mais uma besteirinha final. Em vez de só zerar os pontos que ele pediu em algum raio qualquer, ele pediu pra aplicar um filtro Butterworth nos pontos dessa máscara que vamos usar na transformada. Se só zerássemos tudo em um raio estaríamos usando um filtro ideal, onde se tem só zeros e uns, mas o Butterworth é mais gradiente. No centro é zero, mas conforme se afasta do centro, vai indo pra 1 de pouquinho m pouquinho. Um exemplo 1D de um filtro ideal seria  

> 1 1 1 1 0 0 0 0 0 1 1 1 1

enquanto um gradiente seria algo mais de boa, tipo  

> 1 1 1 1 0.8 0.3 0 0.3 0.8 1 1 1 1

O cálculo do filtro Butterworth em específico tá bem bonitinho lá no [meu relatório lindo](https://github.com/bananahell/ipi-trab1/blob/main/docs/Relat%C3%B3rio_do_Trabalho_1_de_IPI.pdf).  

Agora junta todas essas ideias que tu sai com essa máscara aqui:  

![Máscara reject-notch](https://github.com/bananahell/ipi-trab1/blob/main/docs/imgs/Q3-3%20Reject%20Notch%20mask.png)

e então tu só multiplica com esse carinha aqui:  

![Imagem no domínio da frequência](https://github.com/bananahell/ipi-trab1/blob/main/docs/imgs/Q3-2%20Reject%20Notch%20original%20Fourier.png)

Cara, essa parte é top demais, porque o carrinho que usamos de teste sai OUTRA COISA! É como se ele "adivinhasse" o que tá embaixo dos quadradinhos, mas nem é isso. E ah, uma coisa que o professor pediu para não fazer foi padding da imagem, que seria adicionar algumas linhas de píxels nas bordas da imagem. Ele pediu pra não fazer isso pra ver que o efeito de Moiré ainda fica na imagem nas bordas dela, o que é meio bosta, mas que dá pra resolver exatamente com esse padding.  
