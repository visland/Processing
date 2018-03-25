/* This sketch illustrats 3D pointillist effect with vibrating colored spheres.
 * There will be a fisheye lens on the position of the mouse.
 * If mouse is pressed, spheres on the fisheye lens will keep rising, untill the mouse is not pressed.
 * by Xiaohan Zhu
 */

PImage img;
int col, row;
int l = 10;
float a = 1;

void setup() {
  size(500, 750, P3D);
  img = loadImage ("mountain.jpg");
  
  // set numnbers of columns and rows
  col = img.width / l;
  row = img.height / l;
}

void draw() {
  background(0);
  for (int i = 0; i < col; i++) {
    for (int j = 0; j < row; j++) { 
      
      // the coordinate of each sphere
      int x = i * l + l / 2;
      int y = j * l + l / 2;
      pushMatrix();
      float dis = pow (abs(mouseX - x), 2) + pow(abs(mouseY - y), 2);
      float z = random(85, 90) - sqrt(dis);
      
      // create fisheye lens around the mouse
      if (dis > 6000) {
        translate(x, y, random(0, 5));
      } else if (mousePressed) {
        // rise the spheres when mouse is pressed
        a += 0.003;
        translate(x, y, z * a);
      } else {
        a = 1;
        translate(x, y, z);
      }
      
      // draw spheres on the canvus
      fill(img.get(x, y));
      noStroke();
      lights();
      sphere(l / 2);
      popMatrix();
    }
  }
}