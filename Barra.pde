class Barra {
  float altoBarra;
  float anchoBarra;


  Barra(float anchoBarraInicial, float altoBarraInicial) {
    anchoBarra = anchoBarraInicial;
    altoBarra = altoBarraInicial;
  }

  void moverBarra() {
    rectMode(CENTER);
    //fill(255, 0, 0);
    //rect(mouseX, height - 40, anchoBarra, altoBarra);
    imageMode(CENTER);
    barra.resize(140, 20);
    image(barra, mouseX, height - 40);
    imageMode(CORNER);
  }
}
