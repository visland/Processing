import ddf.minim.*;

Minim minim;
AudioInput input;
float w = 26, h;
float ground[];
int startIdx = 0, dia = 20, ticks = 0, minLength = 9;
float speed = 0.002;

void setup() {
  size(1200, 600, P3D);
  h = height / 2;
  ground = new float[(int)(width / w)];
  minim = new Minim(this);
  input = minim.getLineIn();
  for (int i = 0; i < ground.length; i++) {
    if (random(1) > 0.5) {
      ground[i] = 0;
    } else {
      ground[i] = 255;
    }
  }
  for (int c = 0; c < 5; c++) {
    ground[ground.length / 2 + c] = 0;
  }
  for (int j = 0; j < ground.length; ++j) {
    if (ground[j] == 0) {
      for (int k = 0; k < minLength && j < ground.length; ++k) {
        ground[j++] = 0;
      }
    }
  }
}

void draw() {
  background(255);
  stroke(0);
  fill(0);
  for (int i = 0; i < input.bufferSize() - 1; i++) {
    float m = input.mix.get(i);
    if (abs(m) > 0.001) {
      h -= speed;
      ellipse(width / 2 + dia / 2, h, dia, dia);
    } else if (abs(m) <= 0.001 && h != 300) {
      h += speed;
      ellipse(width / 2 + dia / 2, h, dia, dia);
    } else if (abs(m) <= 0.001) {
      ellipse(width / 2 + dia / 2, h, dia, dia);
    }
  }
  for (int j = 0; j < ground.length; j++) {
    noStroke();
    fill(ground[(startIdx + j ) % ground.length]);
    rect(j * w, height / 2 + dia / 2, w, height / 2 + dia / 2);
  }
  if (ground[(startIdx + ground.length / 2 ) % ground.length] == 255 && h == height / 2) {
    textSize(100);
    fill(0);
    text("You Lose!", 300, 250);
    noLoop();
  }
  startIdx = ticks++ / 15;
}