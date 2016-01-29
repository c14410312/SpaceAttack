void setup()
{
   size(800,500);
   smooth(); 
   AllyShip AShip = new AllyShip('W', 'A', 'D','S', ' ','N', width * 0.25, height* 0.5);
   spaceObjects.add(AShip);
   
}


ArrayList<SpaceObject> spaceObjects = new ArrayList<SpaceObject>();

boolean[] keys = new boolean[512];
boolean generalPresent = false;

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
 
 //creates asteroids and enemy ships every 3/4 second
 if(frameCount % 40 == 0)
 {
   
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
    
    int i = (int) random(0,2);
    switch(i)
    {
       case 0:
         powerup = new HealthPowerup();
         break;
       case 1:       
         powerup = new Shield();
         break;
    }
    spaceObjects.add(powerup);
  }
 /* 
  if(frameCount % 1000 == 0)
  {
    General gShip = new General(width, height);
    spaceObjects.add(gShip); 
  }*/
 
 //collision function calls
 checkEnemyBulletHits(); 
 checkAsteroidHits();
 checkAllyBulletHits();
 CheckPowerupCollisions();
 
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
          if (so.pos.dist(other.pos) < so.halfW/2 + other.halfW/2)
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
        if (other instanceof HealthPowerup || other instanceof Shield) // Check the type of a object
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