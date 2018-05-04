/**
 * This sketch illustrats 3D pointillist effect with vibrating colored spheres.
 * There will be a fisheye lens on the position of the mouse.
 * If mouse is pressed, spheres on the fisheye lens will keep rising, untill the mouse is not pressed.
 * by Xiaohan Zhu 10177647
 */
PImage img;
int col, row;
int DIAMETER = 10; // Diameter of spheres.
float sphereHeight = 1;

void setup() {
  size(500, 750, P3D);
  img = loadImage ("mountain.jpg");
  
  // Sets numnbers of columns and rows
  col = img.width / DIAMETER;
  row = img.height / DIAMETER;
}

void draw() {
  background(0);
  for (int i = 0; i < col; i++) {
    for (int j = 0; j < row; j++) { 
      
      // The coordinate of each sphere
      int x = i * DIAMETER + DIAMETER / 2;
      int y = j * DIAMETER + DIAMETER / 2;
      pushMatrix();
      float dist = pow (abs(mouseX - x), 2) + pow(abs(mouseY - y), 2);
      float z = random(85, 90) - sqrt(dist);
      
      // Creates fisheye lens around the mouse
      if (dist > 6000) {
        translate(x, y, random(0, 5));
      } else if (mousePressed) {
        // Rises the spheres when mouse keeps being pressed.
        sphereHeight += 0.003;
        translate(x, y, z * sphereHeight);
      } else {
        sphereHeight = 1;
        translate(x, y, z);
      }
      
      // Draws spheres on the canvus
      fill(img.get(x, y));
      noStroke();
      lights();
      sphere(DIAMETER / 2);
      popMatrix();
    }
  }
}