abstract class SpaceObject
{
   PVector pos;
   PVector forward;
   float theta = 0.0f;
   float w;
   float halfW;
   float speed = 4.0f;
   float border = width * 0.05;
   int elapsed = 6;
   int health;
   int dead;
   int score;
   boolean dir;
   color c; 
   
   SpaceObject()
   {
     this(width * 0.5f, height  * 0.5f, 50);
   }
   
   SpaceObject(float x, float y, float w)
   {
     pos = new PVector(x, y);
     forward = new PVector(0, -1);
     this.w = w;
     this.halfW = w * 0.5f;
     this.theta = 0.0f;
   }
   
   abstract void update();
   abstract void render();
   
   void explode(float posX, float posY)
   {
      float lastX = posX; float lastY =posY;
      float thetaInc = TWO_PI / 4;
      
      //creates outter red explosion
      for(int i = 0 ; i < 5;i++)
      {
          float t = i * thetaInc;
          float x = sin(t) * 20;
          float y = -cos(t) * 20;
          
          fill(255,0,0);
          noStroke();
          ellipse(lastX,lastY, 50,50);
          lastX = x;
          lastY = y;
      }
      
      //creates orange explosion
      for(int i = 0 ; i < 5;i++)
      {
          float t = i * thetaInc;
          float x = sin(t) * 25;
          float y = -cos(t) * 25;
          
          fill(255,128,0);
          noStroke();
          ellipse(lastX,lastY, 40,40);
          lastX = x;
          lastY = y;
      }
      
      for(int i = 0 ; i < 5;i++)
      {
          float t = i * thetaInc;
          float x = sin(t) * 15;
          float y = -cos(t) * 15;
          
          fill(255,255,0);
          noStroke();
          ellipse(lastX,lastY, 25,25);
          lastX = x;
          lastY = y;
      }
   }
   
}