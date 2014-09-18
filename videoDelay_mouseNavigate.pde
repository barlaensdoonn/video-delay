
import processing.video.*;

Capture cam;
PImage[] buffer;
int w = 640;
int h = 480;
int nFrames = 120;
int iWrite = 0, iRead = 1;

int mouse;
int lastMouse;


void setup() {
  size(w, h);
  cam = new Capture(this, w, h);
  cam.start();
  buffer = new PImage[nFrames];
}

void draw() {
  if (cam.available()) {
    cam.read();
    buffer[iWrite] = cam.get();

    mouse = int(map(mouseX, 0, width, 0, nFrames-1));

    if (mouse != lastMouse) {
      //println(lastMouse + ", " + mouse);
      if (buffer[mouse] != null) {
        image(buffer[mouse], 0, 0);
        iRead = mouse;
        //iWrite = mouse - 1;
      }
    } 
    else {
      if (buffer[iRead] != null) {
        image(buffer[iRead], 0, 0);
      }
    }
    
    iWrite = (iWrite+1)%nFrames;
    iRead = (iRead+1)%nFrames;
    lastMouse = mouse;
    //println(mouseX + ", " + mouse);
    
  }
}

