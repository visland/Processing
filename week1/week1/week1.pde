/**
 * A rotating flower changes its color and size by the movement of the mouse.
 * Size is decided by speed and color is decided by the coordinate of mouse.
 * The mouse is tracked.
 * When mouse is pressed, the flower on that position will be reserved and 
 * is always shown on the top layer. 
 * by Xiaohan Zhu n10177647
 */
PGraphics pg;

void setup() {
  // Creates a layer for flowers.
  pg = createGraphics(700, 700);
  pg.beginDraw();
  pg.background(255, 255, 255, 0);
  pg.endDraw();

  // Creates a layer for tracks.
  size(700, 700);
  background(255);
  smooth();
}

// Draws petals.
void drawPetals(float length, int i, int n) {
  beginShape();
  vertex(0, 0);
  bezierVertex(-12, 0, -12, -length, 0, -length);
  bezierVertex(12, -length, 12, 0, 0, 0);
  rotate(TWO_PI / n * i);
  endShape();
  popMatrix();
}


void draw() {
  // Draws a flower whose size depends on the speed.
  float length = abs(mouseX - pmouseX) + abs(mouseY - pmouseY) + 50;

  // Identifies the number of petals.
  int n = 12; 
  for (int i = 0; i < n; i++) {
    pushMatrix();
    translate(mouseX, mouseY);

    // Fills in color
    float x1 = map(mouseX, 0, width, 0, 255);
    float x2 = map(mouseY, 0, height, 0, 255);
    noStroke();
    fill(x1, x2, random(255), 100 / (n + 5) * i);

    // Makes the flower rotate
    rotate(frameCount / 5);
    drawPetals(length, i, n);
  }

  // Adds some white to the flower to make it more aethetical attractive
  if (!mousePressed) {
    for (int i = 0; i < n; i++) {
      pushMatrix();
      translate(mouseX, mouseY);
      rotate(frameCount / 5);
      fill(255, 255, 255, 60);
      drawPetals(length, i, n);
    }
  } else {
    // Keeps the flower on the canvus when mouse is pressed
    pg.beginDraw();
    for (int i = 0; i < n; i++) {
      //Draws that flower on the specific layer
      pg.pushMatrix();
      pg.translate(mouseX, mouseY);

      // Fills in color
      float x1 = map(mouseX, 0, width, 0, 255);
      float x2 = map(mouseY, 0, height, 0, 255);
      pg.noStroke();
      pg.fill(x1, x2, random(255), 100 / (n + 5) * i);

      // Makes the flower rotate
      pg.rotate(frameCount / 5);

      // Draws petals
      pg.beginShape();
      pg.vertex(0, 0);
      pg.bezierVertex(-12, 0, -12, -length, 0, -length);
      pg.bezierVertex(12, -length, 12, 0, 0, 0);
      pg.rotate(TWO_PI / n * i);
      pg.endShape();
      pg.popMatrix();
    }
    pg.endDraw();
  }

  // Shows the layer
  image(pg, 0, 0);
}

void keyReleased() {
  // If s is pressed save an image
  if (key == 's') {
    save("myImage.png");
  }
}