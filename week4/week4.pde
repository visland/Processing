/**
 * A simple but funny voice controlled game. What players need to do is control the
 * ball to jump accross gaps by their sound.
 * by Xiaohan Zhu n10177647
 */
import ddf.minim.*;

Minim minim;
AudioInput input;

// The ground consists of bricks and holes.
boolean[] hasBrick;
int firstGroundIdx = 0;
// Horizontal parameters
int BRICK_WIDTH = 20;
int diameter = BRICK_WIDTH;
// Vertical parameters
float curHeight;
float VERTICAL_SPEED = 0.002;
// Records the times of calling the draw() function.
int ticks = 0;
// The ground will move every `TICKS_PER_MOVE` times of calling draw() function.
// Its moving speed can be accelerated by decreased this parameter.
int TICKS_PER_MOVE = 15;

void setup() {
  size(1200, 600, P3D);
  curHeight = height / 2;
  hasBrick = new boolean[width / BRICK_WIDTH];
  
  // Get sound input.
  minim = new Minim(this);
  input = minim.getLineIn();
  
  // Fill the ground with bricks and holes.
  for (int i = 0; i < hasBrick.length; i++) {
    if (random(1) > 0.5) {
      hasBrick[i] = true;
    } else {
      hasBrick[i] = false;
    }
  }
  
  // Ensures the player stand on bricks when game starts.
  for (int c = 0; c < 7; c++) {
    hasBrick[hasBrick.length / 2 - c] = true;
  }
  // The difficulty of the game can be adjusted by tuneing the the number of the
  // minimal continuous bricks.
  for (int i = 0; i < hasBrick.length; ++i) {
    // If ground[i] is a brick, then assign
    // ground[i + 1, ..., i + minGroundLength] as bricks.
    if (hasBrick[i]) {
      int minGroundLength = 5;
      for (int j = 0; j < minGroundLength && i < hasBrick.length; 
        ++j) {
        hasBrick[i++] = true;
      }
    }
  }
}

//Decides if the player lose.
boolean lose() {
  int playerCurrentGroundIdx =
    (hasBrick.length - (hasBrick.length / 2 + firstGroundIdx) % hasBrick.length)
    % hasBrick.length;
  return !hasBrick[playerCurrentGroundIdx] &&
    curHeight == height / 2;
}

// Draws a player in the middle of the screen.
void drawPlayer() {
  stroke(255);
  fill(255);
  ellipse(width / 2 + diameter / 2, curHeight, diameter, diameter);
}

void draw() {
  background(#A6D4E8);
  
  // Makes the ball jump whenever there has sound input.
  for (int i = 0; i < input.bufferSize() - 1; i++) {
    float m = input.mix.get(i);
    if (abs(m) > 0.01) {
      curHeight -= VERTICAL_SPEED;
    } else if (abs(m) <= 0.01 && curHeight != 300) {
      curHeight += VERTICAL_SPEED;
    }
    drawPlayer();
  }
  
  // Draws a moving ground with bricks and holes.
  for (int j = 0; j < hasBrick.length; j++) {
    if (hasBrick[j]) {
      noStroke();
      fill(#8AAF3A);
      rect(
        (hasBrick.length - (j + firstGroundIdx) % hasBrick.length) * BRICK_WIDTH, 
        height / 2 + diameter / 2, BRICK_WIDTH, 
        height / 2 - diameter / 2
        );
    }
  }
  
  // Stop game when the ball falls into a hole.
  if (lose()) {
    textSize(100);
    fill(0);
    text("You Lose! :(", 300, 250);
    noLoop();
  }
  
  // Adjust the moving speed of the ground.
  firstGroundIdx = ticks++ / TICKS_PER_MOVE;
}