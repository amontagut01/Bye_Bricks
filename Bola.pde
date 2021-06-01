class Bola {
  float posXBola;
  float posYBola;
  float velocidadXBola;
  float velocidadYBola;
  float posXBolai;
  float posYBolai;
  int radioBola;
  //Límites del ladrillo
  boolean limites;
  //Direccion en X y Y cuando la bola pegue en los laterales del ladrillo
  float direccionXLat = -1;
  float direccionYLat = 1;
  //Direccion en X y Y cuando la bola pegue en los lados de arriba o abajo del ladrillo
  float direccionXA = -1;
  float direccionYA = 1;//Para separar las velocidades cuando la bola viene de los laterales o de arriba y abajo, para que no interfiera en los if del rebote


  Bola(float posXInicialBola, float posYInicialBola, float velociadXInicialBola, float velociadYInicialBola, int radioInicialBola) {
    posXBola = posXInicialBola;
    posYBola = posYInicialBola;
    velocidadXBola = velociadXInicialBola;
    velocidadYBola = velociadYInicialBola;
    radioBola = radioInicialBola;
  }

  void pinteceBola() {
    noStroke();
    fill(255);
    ellipseMode(RADIUS);
    ellipse(posXBola, posYBola, radioBola, radioBola);
  }

  void direccionXBola() {
    velocidadXBola *= -1;
    if (velocidadXBola < 0) {
      direccionXLat *= -1;
      direccionXA *= -1;
    } else {
      direccionXLat = 1;
      direccionXA = 1;
    }
  }

  void direccionYBola() {
    velocidadYBola *= -1;
    if (velocidadYBola < 0) {
      direccionYLat *= -1;
      direccionYA *= -1;
    } else {
      direccionYLat = 1;
      direccionYA = 1;
    }
  }

  void moverBola() {
    posXBolai = posXBola;
    posYBolai = posYBola;
    posXBola = posXBola + velocidadXBola;
    posYBola = posYBola + velocidadYBola;

    //Límites de las paredes laterales para que rebote la bola
    if (posXBola > width - radioBola - 24|| posXBola < radioBola + 24) {
      direccionXBola();
    }

    //Techo
    if (posYBola < radioBola + 40) {
      direccionYBola();
    }

    //Límites de la barra
    if ((posXBola - radioBola < mouseX + 70) && (posXBola + radioBola > mouseX - 70) && (posYBola > 640)) {
      direccionYBola();
    }
  }


  boolean reboteLadrillo(float posXLadrillo, float posYLadrillo) {
    boolean reboto = false;

    if ((posXBola + radioBola >= posXLadrillo) && 
      (posYBola + radioBola >= posYLadrillo) && 
      (posYBola - radioBola <= posYLadrillo + 27) && 
      (posXBola - radioBola <= posXLadrillo + 86)) {
      limites = true;
    }

    //Lado de derecha
    if (direccionXLat < 0 && direccionYLat > 0 && limites == true) {
      direccionXBola();
      reboto = true;
      limites = false;
    }

    //Lado de abajo
    if ((direccionXA < 0 && direccionYA < 0 && limites == true) || (direccionXA > 0 && direccionYA < 0 && limites == true)) {
      direccionYBola();
      reboto = true;
      limites = false;
    }

    //Lado de izquierda
    if ((direccionXLat > 0 && direccionYLat < 0 && limites == true) || (direccionXLat > 0 && direccionYLat > 0 && limites == true)) {
      direccionXBola();
      reboto = true;
      limites = false;
    }

    //Lado arriba
    if ((direccionXA < 0 && direccionYA > 0 && limites == true) || (direccionXA > 0 && direccionYA > 0 && limites == true)) {
      direccionYBola();
      reboto = true;
      limites = false;
    }
    return reboto;
  }


  boolean sePaso() {
    boolean sePaso = false;
    if (posYBola > 730) {
      sePaso = true;
      posXBola = 450;
      posYBola = 450;
    }
    return sePaso;
  }
}
