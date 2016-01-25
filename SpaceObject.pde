class SpaceObject
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
   
   void update()
   {
   }
   
   void render()
   {
   }
   
}
