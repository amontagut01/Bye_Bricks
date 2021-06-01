class Ladrillo {
  float posX;
  float posY;

  int numGolpes = 5;

  boolean seConto;

  Ladrillo(float posXInicial, float posYInicial, int numGolpesInicial, boolean seContos) {
    posX = posXInicial;
    posY = posYInicial;
    numGolpes = numGolpesInicial;
    seConto = seContos;
  }

  void pintar() {
    if (numGolpes == 5) {
      pintarLadrilloRojo ();
    } else if (numGolpes == 4) {
      pintarLadrilloNaranja ();
    } else if (numGolpes == 3) {
      pintarLadrilloAmarillo();
    } else if (numGolpes == 2) {
      pintarLadrilloVerde();
    } else if (numGolpes == 1) {
      pintarLadrilloAzul ();
    }
  }

  void pintarLadrilloAzul() {
    rectMode(CORNER);
    brickAzul.resize(86, 27);
    image(brickAzul, posX, posY);
  }

  void pintarLadrilloVerde() {
    brickVerde.resize(86, 27);
    image(brickVerde, posX, posY);
  }

  void pintarLadrilloAmarillo() {
    brickAmarillo.resize(86, 27);
    image(brickAmarillo, posX, posY);
  }

  void pintarLadrilloNaranja() {
    brickNaranja.resize(86, 27);
    image(brickNaranja, posX, posY);
  }

  void pintarLadrilloRojo() {
    brickRojo.resize(86, 27);
    image(brickRojo, posX, posY);
  }
}
