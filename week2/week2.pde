/* Type whatever you want on a flashing background
 * press '1', '2', '3' to control the number of frames to be displayed every second
 * '1' is the slowest and '3' is the fastest
 * press '5' to show random circles covering the canvus
 * press '0' to reset
 * by Xiaohan Zhu
 */

String words = "";
PGraphics pg;
boolean drawCircles = false;

void setup() {
  size(800, 800);
  background(255);

  // Sepecify the text font
  textFont(createFont("AmericanTypewriter-Bold", 50));

  // Specify the number of frames to be displayed every second.
  frameRate(15);

  // create a layer for circles
  pg = createGraphics(800, 800);
  pg.beginDraw();
  pg.background(255, 255, 255, 0);
  pg.endDraw();
}

void draw() {
  // draw the flashing background
  float w = 20; // number of bars
  for (float i = 0; i < width/w * 2; i++) {
    noStroke();

    // fill in the color of bars
    if (random(3) <= 1) {
      fill(147, 96, 30);
    } else if (random(3) >= 2) {
      fill(247, 185, 102);
    } else {
      fill(211, 58, 15);
    }   

    // draw bars on the canvus
    quad(i * w, 0, (i + 1) * w, 0, 0, (i + 1) * w, 0, i * w);
  }

  // show what user has typed
  fill(255);  
  textSize(100);
  text(words, 50, 50, 750, 750);

  // show random circles on the layer
  if (drawCircles) {
    pg.beginDraw();
    pg.noStroke();
    pg.fill(247, 185, 102);
    float l = random(100, 200);
    pg.ellipse(random(800), random(800), l, l);
    pg.endDraw();
    image(pg, 0, 0);
  }
}

void keyReleased() {
  // control the number of frames to be displayed every second
  if (key == '1') {
    frameRate(5);
  } else if (key == '2') {
    frameRate(15);
  } else if (key == '3') {
    frameRate(20);
  } else if (key == '5') {
    drawCircles = !drawCircles;
  }

  // show what user has typed
  if ((key>='A' && key<='z') || key==' ') {
    words+=key;
    println(key);
  }

  // reset the canvus if '0' is pressed
  if (key == '0') {
    rect(0, 0, 800, 800);
    pg.beginDraw();
    pg.background(255, 255, 255, 0);
    pg.endDraw();
    words = " ";
  }

  // if / is pressed save an image
  if (key == '/') {
    save("myImage.png");
  }
}