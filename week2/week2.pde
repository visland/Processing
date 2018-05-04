/**
 * Type whatever you want on a flashing background
 * press '1', '2', '3' to control the number of frames to be displayed every second
 * '1' is the slowest and '3' is the fastest
 * press '5' to show random circles covering the canvus
 * press '0' to reset
 * by Xiaohan Zhu n10177647
 */
String words = "";
PGraphics pg;
boolean drawCircles = false;
float BAR_NUM = 20;

void setup() {
  size(800, 800);
  background(255);

  // Sepecifies the text font
  textFont(createFont("AmericanTypewriter-Bold", 50));

  // Specifies the number of frames to be displayed every second.
  frameRate(15);

  // Creates a layer for circles
  pg = createGraphics(800, 800);
  pg.beginDraw();
  pg.background(255, 255, 255, 0);
  pg.endDraw();
}

void draw() {
  // Draws the flashing background
  for (float i = 0; i < width / BAR_NUM * 2; i++) {
    noStroke();

    // Fills in the color of bars
    if (random(3) <= 1) {
      fill(147, 96, 30);
    } else if (random(3) >= 2) {
      fill(247, 185, 102);
    } else {
      fill(211, 58, 15);
    }   

    // Draws bars on the canvus
    quad(i * BAR_NUM, 0, (i + 1) * BAR_NUM, 0, 0, 
      (i + 1) * BAR_NUM, 0, i * BAR_NUM);
  }

  // Shows what user has typed
  fill(255);  
  textSize(100);
  text(words, 50, 50, 750, 750);

  // Shows random circles on the layer
  if (drawCircles) {
    pg.beginDraw();
    pg.noStroke();
    pg.fill(247, 185, 102);
    float diameter = random(100, 200);
    pg.ellipse(random(800), random(800), diameter, diameter);
    pg.endDraw();
    image(pg, 0, 0);
  }
}

void keyReleased() {
  // Controls the number of frames to be displayed every second
  if (key == '1') {
    frameRate(5);
  } else if (key == '2') {
    frameRate(15);
  } else if (key == '3') {
    frameRate(20);
  } else if (key == '5') {
    drawCircles = !drawCircles;
  }

  // Shows what user has typed
  if ((key >= 'A' && key <= 'z') || key == ' ') {
    words += key;
  }

  // Resets the canvus if '0' is pressed
  if (key == '0') {
    rect(0, 0, 800, 800);
    pg.beginDraw();
    pg.background(255, 255, 255, 0);
    pg.endDraw();
    words = " ";
  }

  // If '/' is pressed save an image
  if (key == '/') {
    save("myImage.png");
  }
}