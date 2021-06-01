//JUEGO BYE BRICKS
import processing.sound.*;

SoundFile click;
SoundFile click2;
SoundFile romper;
SoundFile destruir;
SoundFile vidaMenos;
SoundFile ganar;
SoundFile perder;

Ladrillo[] brick;
Ladrillo[] brick2;
Ladrillo[] brick3;

Bola bola1;
Bola bola2;
Bola bola3;
Barra barra1;

//Variable de estado
int estado ;

//Variables de los estados específicos
int MENU = 1;
int INSTRUCCIONES = 2;
int DIFICULTAD = 3;
int GAMEPLAY = 4;
int PAUSA =5;
int GANASTE = 6;
int PERDISTE = 7;

//Variable de en qué dificultad se encuentra
int nivel;

//Número total de ladrillos
int numLadrillos = 45;
//Número de filas de ladrillos
int numFilas = 9;
//Número de ladrillos por fila
int ladrillosFila = 9;

//Modelador de puntajes
Table puntajes;

//Número de vidas totales
int vidas = 3;
//Puntaje
int puntaje = 0;
//Variable del tiempo en el que lleva ejecutado el juego
int tiempoInicial;
//Variable del tiempo total que jugó la persona
int tiempoJuego;

//Contador para saber cuántos ladrillos se han destruido completamente
int contadorLadrillos = 0;

// Si el ladrillo se destruyó completamente
boolean porFuera;
//Si el ladrillo que se destruyó completamente se contó
boolean seConto;

PImage pantallaMENU;
PImage pantallaINSTRUCCIONES;
PImage pantallaDIFICULTAD;
PImage pantallaGAMEPLAY;
PImage pantallaPAUSA;
PImage pantallaGANASTE;
PImage pantallaPERDISTE;
PImage brickAzul;
PImage brickVerde;
PImage brickAmarillo;
PImage brickNaranja;
PImage brickRojo;
PImage barra;

PFont font;


void setup() {
  size (900, 700);
  background(0);

  font = loadFont("PlayMeGames.vlw");
  textFont(font);

  click = new SoundFile(this, "CLICKBOTON.wav");
  click2 = new SoundFile(this, "CLICKBOTON2.mp3");
  romper = new SoundFile(this, "Romper.mp3");
  destruir = new SoundFile(this, "Destruir.mp3");
  vidaMenos = new SoundFile(this, "VidaMenos.mp3");
  ganar = new SoundFile(this, "Ganar.mp3");
  perder = new SoundFile(this, "Perder.mp3");

  pantallaMENU = loadImage("MENUByeBricks.png");
  pantallaINSTRUCCIONES = loadImage("INSTRUCCIONESByeBricks.png");
  pantallaDIFICULTAD = loadImage("DIFICULTADByeBricks.png");
  pantallaGAMEPLAY = loadImage("GAMEPLAYByeBricks.png");
  pantallaPAUSA = loadImage("PAUSAByeBricks.png");
  pantallaGANASTE = loadImage("GANASTEByeBricks.png");
  pantallaPERDISTE = loadImage("PERDISTEByeBricks.png");
  brickAzul = loadImage("LadrilloAzul.png");
  brickVerde = loadImage("LadrilloVerde.png");
  brickAmarillo = loadImage("LadrilloAmarillo.png");
  brickNaranja = loadImage("LadrilloNaranja.png");
  brickRojo = loadImage("LadrilloRojo.png");
  barra = loadImage("Barra.png");

  puntajes = loadTable("data/puntajes.csv", "header");

  estado = MENU;

  bola1 = new Bola(width/2, 500, -6.8, 6.6, 10);
  bola2 = new Bola(width/2, 500, -8.8, 8.6, 10);
  bola3 = new Bola(width/2, 500, -10.8, 10.6, 10);
  barra1 = new Barra(140, 20);

  brick = new Ladrillo[numLadrillos];
  brick2 = new Ladrillo[numLadrillos];
  brick3 = new Ladrillo[numLadrillos];

  int indice = 0;

  for (int i = 0; i < numFilas; i = i + 1) {
    for (int j = 0; j < ladrillosFila - i; j = j + 1) {
      brick[indice] = new Ladrillo(64 + (86 * j) + (43 * i), 127 + (27 * i), int (random(1, 4)), false);
      brick2[indice] = new Ladrillo(64 + (86 * j) + (43 * i), 127 + (27 * i), int (random(1, 5)), false);
      brick3[indice] = new Ladrillo(64 + (86 * j) + (43 * i), 127 + (27 * i), int (random(1, 6)), false);
      indice = indice + 1;
    }
  }

  tiempoInicial = millis();
}

void draw() {
  //Pantalla del Menú principal
  if (estado == MENU) {
    background(0);
    //Cuadrados del botón de jugar
    rectMode(CENTER);
    stroke(255);
    strokeWeight(3);
    fill(255);
    rect(444, 384, 289, 42);
    fill(0);
    rect(450, 378, 289, 42);
    //Cuadrados del botón de instrucciones
    fill(255);
    rect(444, 493, 289, 42);
    fill(0);
    rect(450, 487, 289, 42);
    //Cuadrados del botón de Salir
    fill(255);
    rect(444, 602, 289, 42);
    fill(0);
    rect(450, 596, 289, 42);

    pantallaMENU.resize(900, 700);
    image(pantallaMENU, 0, 0);
  }

  //Pantalla de Instrucciones
  else if (estado == INSTRUCCIONES) {
    cursor();
    rectMode(CORNER);
    fill(0);
    noStroke();
    rect(205, 112, 500, 475);
    //Cuadrados del botón de Menu Principal
    rectMode(CENTER);
    stroke(255);
    strokeWeight(3);
    fill(255);
    rect(446, 556, 190, 27);
    fill(0);
    rect(450, 551, 190, 27);

    pantallaINSTRUCCIONES.resize(900, 700);
    image(pantallaINSTRUCCIONES, 0, 0);
  }

  //Pantalla de las dificultades
  else if (estado == DIFICULTAD) {
    cursor();
    rectMode(CORNER);
    fill(0);
    noStroke();
    rect(205, 112, 500, 475);
    //Cuadrados del botón de intermedio
    rectMode(CENTER);
    stroke(255);
    strokeWeight(3);
    fill(255);
    rect(444, 292, 289, 42);
    fill(0);
    rect(450, 286, 289, 42);
    //Cuadrados del botón de avanzado
    fill(255);
    rect(444, 389, 289, 42);
    fill(0);
    rect(450, 383, 289, 42);
    //Cuadrados del botón de pro
    fill(255);
    rect(444, 486, 289, 42);
    fill(0);
    rect(450, 480, 289, 42);

    pantallaDIFICULTAD.resize(900, 700);
    image(pantallaDIFICULTAD, 0, 0);
  }

  //Pantalla del Juego en curso
  else if (estado == GAMEPLAY) {  
    background(0);
    noCursor();
    pantallaGAMEPLAY.resize(900, 700);
    image(pantallaGAMEPLAY, 0, 0);

    barra1.moverBarra();

    if (nivel == 1) {
      bola1.moverBola();
      bola1.pinteceBola();
      for (int i = 0; i < brick.length; i = i + 1) {
        boolean reboto;
        reboto = bola1.reboteLadrillo(brick[i].posX, brick[i].posY);

        if (reboto == true) {
          brick[i].numGolpes = brick[i].numGolpes - 1;
          puntaje = puntaje + 10;
          romper.play();
        }

        brick[i].pintar();

        if (brick[i].numGolpes == 0) {
          brick[i].posX = 1000;
          if (brick[i].seConto == false) {
            contadorLadrillos = contadorLadrillos + 1;
            brick[i].seConto = true;
            destruir.play();
          }
        }

        if (contadorLadrillos >= brick.length) {
          estado = GANASTE;
          contadorLadrillos = 0;
          ganar.play();

          //Cuánto tiempo jugó antes de perder
          tiempoJuego = (millis() - tiempoInicial)/1000;
        }
      }
    } else if (nivel == 2) {
      bola2.moverBola();
      bola2.pinteceBola();
      for (int i = 0; i < brick.length; i = i + 1) {
        boolean reboto;
        reboto = bola2.reboteLadrillo(brick2[i].posX, brick2[i].posY);

        if (reboto == true) {
          brick2[i].numGolpes = brick2[i].numGolpes - 1;
          puntaje = puntaje + 10;
          romper.play();
        }

        brick2[i].pintar();

        if (brick2[i].numGolpes == 0) {
          brick2[i].posX = 1000;

          if (brick2[i].seConto == false) {
            contadorLadrillos = contadorLadrillos + 1;
            brick2[i].seConto = true;
            destruir.play();
          }
        }

        if (contadorLadrillos >= brick.length) {
          estado = GANASTE;
          contadorLadrillos = 0;
          ganar.play();

          //Cuánto tiempo jugó antes de perder
          tiempoJuego = (millis() - tiempoInicial)/1000;
        }
      }
    } else if (nivel == 3) {
      bola3.moverBola();
      bola3.pinteceBola();
      for (int i = 0; i < brick.length; i = i + 1) {
        boolean reboto;
        reboto = bola3.reboteLadrillo(brick3[i].posX, brick3[i].posY);

        if (reboto == true) {
          brick3[i].numGolpes = brick3[i].numGolpes - 1;
          puntaje = puntaje + 10;
          romper.play();
        }
        brick3[i].pintar();

        if (brick3[i].numGolpes == 0) {
          brick3[i].posX = 1000;

          if (brick3[i].seConto == false) {
            contadorLadrillos = contadorLadrillos + 1;
            brick3[i].seConto = true;
            destruir.play();
          }
        }

        if (contadorLadrillos >= brick.length) {
          estado = GANASTE;
          contadorLadrillos = 0;
          ganar.play();

          //Cuánto tiempo jugó antes de perder
          tiempoJuego = (millis() - tiempoInicial)/1000;
        }
      }
    }

    boolean respuestaBola1 = bola1.sePaso();
    boolean respuestaBola2 = bola2.sePaso();
    boolean respuestaBola3 = bola3.sePaso();

    if (respuestaBola1 == true || respuestaBola2 == true || respuestaBola3 == true) {
      vidas = vidas - 1;
      vidaMenos.play();
    }

    if (vidas == 0) {
      estado = PERDISTE;
      perder.play();

      //Cuánto tiempo jugó antes de perder
      tiempoJuego = (millis() - tiempoInicial)/1000;

      int mes = month();
      int dia = day();
      int hora = hour();
      int minuto = minute();

      String fechaJuego = mes + "-" + dia + " " + hora + ":" + minuto;

      TableRow nuevaFila = puntajes.addRow();
      nuevaFila.setString("Fecha", fechaJuego);
      nuevaFila.setInt("Puntaje", puntaje);
      nuevaFila.setInt("Tiempo (s)", tiempoJuego);

      saveTable(puntajes, "data/puntajes.csv");
    }

    fill(255);
    textSize(23);
    text(vidas, 450, 27);
    text(puntaje, 750, 27);
    text((str((millis() - tiempoInicial)/1000)) + " s", 170, 27);
  }


  //Pantalla de Pausa
  else if (estado == PAUSA) { 
    cursor();
    rectMode(CORNER);
    fill(0);
    noStroke();
    rect(205, 112, 500, 475);
    //Cuadrados del botón de resumir
    rectMode(CENTER);
    stroke(255);
    strokeWeight(3);
    fill(255);
    rect(444, 292, 289, 42);
    fill(0);
    rect(450, 286, 289, 42);
    //Cuadrados del botón de menú principal
    fill(255);
    rect(444, 389, 289, 42);
    fill(0);
    rect(450, 383, 289, 42);
    //Cuadrados del botón de salir
    fill(255);
    rect(444, 486, 289, 42);
    fill(0);
    rect(450, 480, 289, 42);

    pantallaPAUSA.resize(900, 700);
    image(pantallaPAUSA, 0, 0);
  } 

  //Pantalla de que el jugador ganó el juego
  else if (estado == GANASTE) {
    cursor();
    rectMode(CORNER);
    fill(0);
    noStroke();
    rect(205, 112, 500, 475);
    //Cuadrados del botón de jugar de nuevo
    rectMode(CENTER);
    stroke(255);
    strokeWeight(3);
    fill(255);
    rect(444, 292, 289, 42);
    fill(0);
    rect(450, 286, 289, 42);
    //Cuadrados del botón de menú principal
    fill(255);
    rect(444, 389, 289, 42);
    fill(0);
    rect(450, 383, 289, 42);
    //Cuadrados del botón de salir
    fill(255);
    rect(444, 486, 289, 42);
    fill(0);
    rect(450, 480, 289, 42);

    pantallaGANASTE.resize(900, 700);
    image(pantallaGANASTE, 0, 0);

    //Texto de puntaje final
    fill(255);
    textSize(20);
    text(puntaje, 380, 236);
    text(tiempoJuego + " s", 565, 236);
  }

  //Pantalla de que el jugador perdió el juego
  else if (estado == PERDISTE) { 
    cursor();
    rectMode(CORNER);
    fill(0);
    noStroke();
    rect(205, 112, 500, 475);
    //Cuadrados del botón de jugar de nuevo
    rectMode(CENTER);
    stroke(255);
    strokeWeight(3);
    fill(255);
    rect(444, 292, 289, 42);
    fill(0);
    rect(450, 286, 289, 42);
    //Cuadrados del botón de menú principal
    fill(255);
    rect(444, 389, 289, 42);
    fill(0);
    rect(450, 383, 289, 42);
    //Cuadrados del botón de salir
    fill(255);
    rect(444, 486, 289, 42);
    fill(0);
    rect(450, 480, 289, 42);

    pantallaPERDISTE.resize(900, 700);
    image(pantallaPERDISTE, 0, 0);

    //Texto de puntaje final
    fill(255);
    textSize(20);
    text(puntaje, 380, 236);
    text(tiempoJuego + " s", 565, 236);
  }
}

void keyReleased() {
  //Presionar la tecla p para pausar
  if (key == 'p') {
    estado = PAUSA;
  }
}

void mouseReleased() {
  //Botón de Jugar en MENU
  if (mouseX > 306 && mouseX < 595 && mouseY > 357 && mouseY < 399 && estado == MENU) {
    estado = DIFICULTAD;
    click.play();
  }

  //Botón de Instrucciones y controles en MENU
  else if (mouseX > 306 && mouseX < 595 && mouseY > 466 && mouseY < 508 && estado == MENU) {
    estado = INSTRUCCIONES;
    click.play();
  }

  //Botón de Salir en MENU
  else if (mouseX > 306 && mouseX < 595 && mouseY > 575 && mouseY < 617 && estado == MENU) {
    exit();
    click.play();
  }

  //Botón de Menú principal en INSTRUCCIONES
  else if (mouseX > 355 && mouseX < 545 && mouseY > 538 && mouseY < 565 && estado == INSTRUCCIONES) {
    estado = MENU;
    click2.play();
  }

  //Botón de Intermedio en DIFICUlTAD
  else if (mouseX > 306 && mouseX < 595 && mouseY > 265 && mouseY < 307 && estado == DIFICULTAD) {
    estado = GAMEPLAY;
    //Para reiniciar el nivel
    vidas = 3;
    nivel = 1;
    puntaje = 0;
    tiempoJuego = 0;
    bola1.posXBola = 450;
    bola1.posYBola = 450;
    contadorLadrillos = 0;
    int indice = 0;
    for (int i = 0; i < numFilas; i = i + 1) {
      for (int j = 0; j < ladrillosFila - i; j = j + 1) {
        brick[indice].posX = (64 + (86 * j) + (43 * i));
        brick[indice].posY = (127 + (27 * i));
        brick[indice].numGolpes = int (random(1, 4));
        brick2[indice].posX = (64 + (86 * j) + (43 * i));
        brick2[indice].posY = (127 + (27 * i));
        brick2[indice].numGolpes = int (random(1, 5));
        brick3[indice].posX = (64 + (86 * j) + (43 * i));
        brick3[indice].posY = (127 + (27 * i));
        brick3[indice].numGolpes = int (random(1, 6));
        indice = indice +1;
      }
    }
    tiempoInicial = millis();
    click.play();
  }

  //Botón de Avanzado en DIFICUlTAD
  else if (mouseX > 306 && mouseX < 595 && mouseY > 362 && mouseY < 404 && estado == DIFICULTAD) {
    estado = GAMEPLAY;
    //Para reiniciar el nivel
    vidas = 3;
    nivel = 2;
    puntaje = 0;
    tiempoJuego = 0;
    bola2.posXBola = 450;
    bola2.posYBola = 450;
    contadorLadrillos = 0;
    int indice = 0;
    for (int i = 0; i < numFilas; i = i + 1) {
      for (int j = 0; j < ladrillosFila - i; j = j + 1) {
        brick[indice].posX = (64 + (86 * j) + (43 * i));
        brick[indice].posY = (127 + (27 * i));
        brick[indice].numGolpes = int (random(1, 4));
        brick2[indice].posX = (64 + (86 * j) + (43 * i));
        brick2[indice].posY = (127 + (27 * i));
        brick2[indice].numGolpes = int (random(1, 5));
        brick3[indice].posX = (64 + (86 * j) + (43 * i));
        brick3[indice].posY = (127 + (27 * i));
        brick3[indice].numGolpes = int (random(1, 6));
        indice = indice +1;
      }
    }
    tiempoInicial = millis();
    click.play();
  }

  //Botón de Pro en DIFICUlTAD
  else if (mouseX > 306 && mouseX < 595 && mouseY > 445 && mouseY < 501 && estado == DIFICULTAD) {
    estado = GAMEPLAY;
    //Para reiniciar el nivel
    vidas = 3;
    nivel = 3;
    puntaje = 0;
    tiempoJuego = 0;
    bola3.posXBola = 450;
    bola3.posYBola = 450;
    contadorLadrillos = 0;
    int indice = 0;
    for (int i = 0; i < numFilas; i = i + 1) {
      for (int j = 0; j < ladrillosFila - i; j = j + 1) {
        brick[indice].posX = (64 + (86 * j) + (43 * i));
        brick[indice].posY = (127 + (27 * i));
        brick[indice].numGolpes = int (random(1, 4));
        brick2[indice].posX = (64 + (86 * j) + (43 * i));
        brick2[indice].posY = (127 + (27 * i));
        brick2[indice].numGolpes = int (random(1, 5));
        brick3[indice].posX = (64 + (86 * j) + (43 * i));
        brick3[indice].posY = (127 + (27 * i));
        brick3[indice].numGolpes = int (random(1, 6));
        indice = indice +1;
      }
    }
    tiempoInicial = millis();
    click.play();
  }

  //Botón de Resumir en PAUSA
  else if (mouseX > 306 && mouseX < 595 && mouseY > 265 && mouseY < 307 && estado == PAUSA) {
    estado = GAMEPLAY;
    click2.play();
  }

  //Botón de Menú principal en PAUSA
  else if (mouseX > 306 && mouseX < 595 && mouseY > 362 && mouseY < 404 && estado == PAUSA) {
    estado = MENU;
    click2.play();
  }

  //Botón de Jugar de nuevo en GANASTE
  else if (mouseX > 306 && mouseX < 595 && mouseY > 265 && mouseY < 307 && estado == GANASTE) {
    estado = GAMEPLAY;
    //Para reiniciar el nivel
    vidas = 3;
    puntaje = 0;
    tiempoJuego = 0;
    bola1.posXBola = 450;
    bola1.posYBola = 450;
    bola2.posXBola = 450;
    bola2.posYBola = 450;
    bola3.posXBola = 450;
    bola3.posYBola = 450;
    contadorLadrillos = 0;
    int indice = 0;
    for (int i = 0; i < numFilas; i = i + 1) {
      for (int j = 0; j < ladrillosFila - i; j = j + 1) {
        brick[indice].posX = (64 + (86 * j) + (43 * i));
        brick[indice].posY = (127 + (27 * i));
        brick[indice].numGolpes = int (random(1, 4));
        brick2[indice].posX = (64 + (86 * j) + (43 * i));
        brick2[indice].posY = (127 + (27 * i));
        brick2[indice].numGolpes = int (random(1, 5));
        brick3[indice].posX = (64 + (86 * j) + (43 * i));
        brick3[indice].posY = (127 + (27 * i));
        brick3[indice].numGolpes = int (random(1, 6));
        indice = indice +1;
      }
    }
    click.play();
  }

  //Botón de Menú principal en GANASTE
  else if (mouseX > 306 && mouseX < 595 && mouseY > 362 && mouseY < 404 && estado == GANASTE) {
    estado = MENU;
    click2.play();
  }

  //Botón de Salir en GANASTE
  else if (mouseX > 306 && mouseX < 595 && mouseY > 459 && mouseY < 501 && estado == GANASTE) {
    exit();
    click2.play();
  }

  //Botón de Jugar de nuevo en PERDISTE
  else if (mouseX > 306 && mouseX < 595 && mouseY > 265 && mouseY < 307 && estado == PERDISTE) {
    estado = GAMEPLAY;
    //Para reiniciar el nivel
    vidas = 3;
    puntaje = 0;
    tiempoJuego = 0;
    bola1.posXBola = 450;
    bola1.posYBola = 450;
    contadorLadrillos = 0;
    int indice = 0;
    for (int i = 0; i < numFilas; i = i + 1) {
      for (int j = 0; j < ladrillosFila - i; j = j + 1) {
        brick[indice].posX = (64 + (86 * j) + (43 * i));
        brick[indice].posY = (127 + (27 * i));
        brick[indice].numGolpes = int (random(1, 4));
        brick2[indice].posX = (64 + (86 * j) + (43 * i));
        brick2[indice].posY = (127 + (27 * i));
        brick2[indice].numGolpes = int (random(1, 5));
        brick3[indice].posX = (64 + (86 * j) + (43 * i));
        brick3[indice].posY = (127 + (27 * i));
        brick3[indice].numGolpes = int (random(1, 6));
        indice = indice +1;
      }
    }
    click.play();
  }

  //Botón de Menú principal en PERDISTE
  else if (mouseX > 306 && mouseX < 595 && mouseY > 362 && mouseY < 404 && estado == PERDISTE) {
    estado = MENU;
    click2.play();
  }

  //Botón de Salir en PERDISTE
  else if (mouseX > 306 && mouseX < 595 && mouseY > 459 && mouseY < 501 && estado == PERDISTE) {
    exit();
    click2.play();
  }
}
