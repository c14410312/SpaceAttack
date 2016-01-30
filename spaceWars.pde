import ddf.minim.*;

Minim minim;

void setup()
{
   minim = new Minim(this);
   size(800,500);
   smooth(); 
   AllyShip AShip = new AllyShip('W', 'A', 'D','S', ' ','N', width * 0.25, height* 0.5);
   spaceObjects.add(AShip);
   
   //in Game track
    AudioPlayer track;
    track = minim.loadFile("soundtrack.mp3");
    track.rewind();
    track.play(); 
}


ArrayList<SpaceObject> spaceObjects = new ArrayList<SpaceObject>();

boolean[] keys = new boolean[512];
int timer = 0;
int screen = 0;
PImage img;
int level = 1;


void keyPressed()
{
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;
}

void draw()
{
   background(0);
   
   
 for(int i = spaceObjects.size() - 1; i >= 0; i --)
 {
   SpaceObject so = spaceObjects.get(i);
   so.update();
   so.render();
 } 

 if(keys['1'])
  { 
    screen = 1;
  }
  
 
 if(screen == 0)
 {
        
   img = loadImage("menu_background_1.jpg");
   img.resize(width,height);
   image(img, 0, 0);
 }
 
 if (screen == 1)
 {

         //increments timer every second
         if(frameCount % 60 == 0)
         {
            timer ++;
         }//end if 
         
         //creates asteroids and enemy ships every 3/4 second
         
         if(level == 1 && frameCount % 40 == 0 && timer <= 60)
         {
                 println(level);
                 SpaceObject enemy = null;
                 
                 int i = (int) random(0,2);
                 switch(i)
                 {
                   case 0:
                     enemy = new EnemyShip(width, random(0,height));
                     break;
                   case 1:
                     enemy = new Asteroid();
                     break;
                 }
                 spaceObjects.add(enemy);
         }
         
         // Create a powerup every 20 seconds
          if (frameCount % 600 == 0)
          {
            SpaceObject powerup = null;
            
            int i = (int) random(0,3);
            switch(i)
            {
               case 0:
                 powerup = new HealthPowerup();
                 break;
               case 1:       
                 powerup = new Shield();
                 break;
               case 2:
                 powerup = new RocketPowerUp();
                 break;
            }
            spaceObjects.add(powerup);
          }
          
          if(timer == 60)
          {
            //waits an extra second in order for timer to be greater than 60 or else multiple ships created
            textSize(50);
            fill(0,200,0);
            text("General Deployed", width/4, height/2);
            if(frameCount % 60 == 0)
            {
              AudioPlayer general;
              general = minim.loadFile("General.wav");
              general.rewind();
              general.play();
              
              General gShip = new General(width, height);
              spaceObjects.add(gShip);
              
              
            }
          }//

         
         //collision function calls
         checkEnemyBulletHits(); 
         checkAsteroidHits();
         checkAllyBulletHits();
         CheckPowerupCollisions();
 }//end screen 1
 
}

//Deducts health from ally ship on collision with enemy bullets
void checkEnemyBulletHits()
{
 for(int i = spaceObjects.size() - 1 ; i >= 0   ;i --)
 {
    SpaceObject so = spaceObjects.get(i);
    if (so instanceof AllyShip)
    {
      for(int j = spaceObjects.size() - 1 ; j >= 0   ;j --)
      {
        SpaceObject other = spaceObjects.get(j);
        if (other instanceof EnemyBullet) // Check the type of a object
        {
          // Bounding circle collisions
          if (so.pos.dist(other.pos) < so.halfW/2 + other.halfW/2)
          {
            // Do some casting
            ((AffectAlly) other).applyTo((AllyShip)so);
            spaceObjects.remove(other);
          }
        }
      }
    }
 } 
}

//Deducts health from ally ship on collision with enemy bullets
void checkAsteroidHits()
{
 for(int i = spaceObjects.size() - 1 ; i >= 0   ;i --)
 {
    SpaceObject so = spaceObjects.get(i);
    if (so instanceof AllyShip)
    {
      for(int j = spaceObjects.size() - 1 ; j >= 0   ;j --)
      {
        SpaceObject other = spaceObjects.get(j);
        if (other instanceof Asteroid) // Check the type of a object
        {
          // Bounding circle collisions
          if (so.pos.dist(other.pos) < so.halfW + other.halfW)
          {
            // Do some casting
            ((AffectAlly) other).applyTo((AllyShip)so);
            spaceObjects.remove(other);
          }
        }
      }
    }
 } 
}

//Deducts health from enemy ships on collision with ally bullets
void checkAllyBulletHits()
{
 for(int i = spaceObjects.size() - 1 ; i >= 0   ;i --)
 {
    SpaceObject so = spaceObjects.get(i);
    if (so instanceof EnemyShip || so instanceof General)
    {
      for(int j = spaceObjects.size() - 1 ; j >= 0   ;j --)
      {
        SpaceObject other = spaceObjects.get(j);
        if (other instanceof Bullet || other instanceof Rocket) // Check the type of a object
        {
          // Bounding circle collisions
          if (so.pos.dist(other.pos) < so.halfW + other.halfW)
          {
            // Do some casting
            if(so instanceof EnemyShip)
            {
              ((AffectEnemy) other).applyTo((EnemyShip)so);
            }
            
            
            if(so instanceof General)
            {
              ((AffectEnemy) other).applyTo((General)so);
            }
            spaceObjects.remove(other);
          }
        }
      }
    }
    if(so instanceof Bullet || so instanceof EnemyBullet)
    {
      for(int j = spaceObjects.size() - 1 ; j >= 0   ;j --)
      {
        SpaceObject other = spaceObjects.get(j);
        if (other instanceof Asteroid) // Check the type of a object
        {
          // Bounding circle collisions
          if (so.pos.dist(other.pos) <= so.halfW/2 + other.halfW/2)
          {
            //removes bullets if they hit asteroid
            if(so instanceof Bullet || so instanceof EnemyBullet)
            {
              spaceObjects.remove(so);
            }
          }
        }
      }
    }
 } 
}

void CheckPowerupCollisions()
{
 for(int i = spaceObjects.size() - 1 ; i >= 0   ;i --)
 {
    SpaceObject so = spaceObjects.get(i);
    if (so instanceof AllyShip)
    {
      for(int j = spaceObjects.size() - 1 ; j >= 0   ;j --)
      {
        SpaceObject other = spaceObjects.get(j);
        if (other instanceof HealthPowerup || other instanceof Shield || other instanceof RocketPowerUp) // Check the type of a object
        {
          // Bounding circle collisions
          if (so.pos.dist(other.pos) < so.halfW + other.halfW)
          {
            AudioPlayer powerup;
            powerup = minim.loadFile("powerup.wav");
            powerup.rewind();
            powerup.play(); 
            // Do some casting
            ((AffectAlly) other).applyTo((AllyShip)so);
            spaceObjects.remove(other);
          }
        }
      }
    }
 } 
}

