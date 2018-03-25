/* A rotating flower follows the movement of mouse
 * Color and size changed when mouse is moved
 * by Xiaohan Zhu
 */

void setup() {
  size(700, 700);
  background(255);
  smooth();
}

void draw() {
  // draw a flower whose size depends on the speed
  float length = abs(mouseX - pmouseX) + abs(mouseY - pmouseY) + 50;
  int n = 12; // the number of petals
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
  
  // erase the flower guadually when mouse is not pressed
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
  }
}

void keyReleased() {
  // if s is pressed save an image
  if (key == 's') {
    save("myImage.png");
  }
}