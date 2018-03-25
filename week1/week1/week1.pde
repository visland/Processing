/* A rotating flower changes its color and size by the movement of the mouse.
 * Size is decided by speed and color is decided by the coordinate of mouse.
 * The mouse is tracked.
 * When mouse is pressed, the flower on that position will be reserved and 
 * is always shown on the top layer. 
 * by Xiaohan Zhu
 */

PGraphics pg;

void setup() {
  // create a layer for flowers
  pg = createGraphics(700, 700);
  pg.beginDraw();
  pg.background(255, 255, 255, 0);
  pg.endDraw();

  //create a layer for tracks 
  size(700, 700);
  background(255);
  smooth();
}

void draw() {
  // draw a flower whose size depends on the speed
  float length = abs(mouseX - pmouseX) + abs(mouseY - pmouseY) + 50;

  // identify the number of petals
  int n = 12; 
  for (int i = 0; i < n; i++) {
    pushMatrix();
    translate(mouseX, mouseY);

    // fill in color
    float x1 = map(mouseX, 0, width, 0, 255);
    float x2 = map(mouseY, 0, height, 0, 255);
    noStroke();
    fill(x1, x2, random(255), 100 / (n + 5) * i);

    // make the flower rotate
    rotate(frameCount / 5);

    // draw petals
    beginShape();
    vertex(0, 0);
    bezierVertex(-12, 0, -12, -length, 0, -length);
    bezierVertex(12, -length, 12, 0, 0, 0);
    rotate(TWO_PI / n * i);
    endShape();
    popMatrix();
  }

  // add some white to the flower to make it more aethetic attractive
  if (!mousePressed) {
    for (int i = 0; i < n; i++) {
      pushMatrix();
      translate(mouseX, mouseY);
      rotate(frameCount / 5);
      fill(255, 255, 255, 60);

      // draw petals
      beginShape();
      vertex(0, 0);
      bezierVertex(-12, 0, -12, -length, 0, -length);
      bezierVertex(12, -length, 12, 0, 0, 0);
      rotate(TWO_PI / n * i);
      endShape();
      popMatrix();
    }
  } else {

    // keep the flower on the canvus when mouse is pressed
    pg.beginDraw();
    for (int i = 0; i < n; i++) {
      //draw that flower on the specific layer
      pg.pushMatrix();
      pg.translate(mouseX, mouseY);

      // fill in color
      float x1 = map(mouseX, 0, width, 0, 255);
      float x2 = map(mouseY, 0, height, 0, 255);
      pg.noStroke();
      pg.fill(x1, x2, random(255), 100 / (n + 5) * i);

      // make the flower rotate
      pg.rotate(frameCount / 5);

      // draw petals
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
  // show the layer
  image(pg, 0, 0);
}

void keyReleased() {
  // if s is pressed save an image
  if (key == 's') {
    save("myImage.png");
  }
}