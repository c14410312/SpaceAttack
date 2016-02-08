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
    
    img1 = loadImage("gameBackground.jpg");
    img1.resize(width,height);
    
    loadHighScores();
}


ArrayList<SpaceObject> spaceObjects = new ArrayList<SpaceObject>();
ArrayList<HighScores> scores = new ArrayList<HighScores>();

boolean[] keys = new boolean[512];
int timer = 0;
int screen = 0;
PImage img;
PImage img1;
int level = 1;
boolean gameOver = false;
int finalScore;


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
  background(img1);
  
   if(timer < 3)
   {
     textSize(50);
     fill(255);
     textAlign(CENTER, CENTER);
     text("Level" + level, width/2, height/2);
   }
   
 for(int i = spaceObjects.size() - 1; i >= 0; i --)
 {
   SpaceObject so = spaceObjects.get(i);
   so.update();
   so.render();
 } 
if(keyPressed)
{
 if(key == '1')
  { 
    screen = 1;
    
  }
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
         
         if(level == 1 && frameCount % 40 == 0 && timer <= 60 && gameOver == false)
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
         
         if(level == 2 && frameCount % 40 == 0 && timer <= 60  && gameOver == false)
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
         
         //level 3
         if(level == 3 && frameCount % 40 == 0 && timer <= 60  && gameOver == false)
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
          if (frameCount % 600 == 0  && gameOver == false)
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
          
          if(timer == 60  && gameOver == false)
          {
            //waits an extra second in order for timer to be greater than 60 or else multiple ships created
            textSize(50);
            fill(0,200,0);
            text("General Deployed", width/2, height/2);
            if(frameCount % 60 == 0)
            {
              AudioPlayer general;
              general = minim.loadFile("General.wav");
              general.rewind();
              general.play();
              
              General gShip = new General(width, height);
              spaceObjects.add(gShip);
              
              
            }
          }
          
          //GameOver
          if(gameOver == true)
          {
              fill(255);
              textSize(50);
              text("Game Over", width/2, height/4);
              text("Play Again: Press Y/N?", width/2, height/2);
              text("Score: "+ finalScore, width/2, height/1.5);
              
              //saves score to file
              String s = str(finalScore);
              String[] scores = split(s, ' ');
              saveStrings("highScores.txt", scores);
             
              //restarts a new Game, resets timer to zero and also returns to level 1 
              if(keys['Y'])
              {
                AllyShip AShip = new AllyShip('W', 'A', 'D','S', ' ','N', width * 0.25, height* 0.5);
                spaceObjects.add(AShip);
                timer = 0;
                level = 1;
                gameOver = false;
              }
              if(keys['N'])
              {
                 screen = 0; 
              }
              
          }

         
         //collision function calls
         checkEnemyBulletHits(); 
         checkAsteroidHits();
         checkAllyBulletHits();
         CheckPowerupCollisions();
         CheckBulletAsteroidCollisions();
         checkAllyBulletHitsGeneral();
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
        if (other instanceof EnemyBullet || other instanceof GeneralRocket) // Check the type of a object
        {
          // Bounding circle collisions
          if (so.pos.dist(other.pos) < so.halfW/2 + other.halfW/2)
          {
            // Do some casting
            ((AffectAlly) other).applyTo((AllyShip)so);
            spaceObjects.remove(other);
            
            AudioPlayer impact;
              impact = minim.loadFile("impact.wav");
              impact.rewind();
              impact.play();
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

//needs to be fixed causing a bug!!!!!!
//Deducts health from enemy ships on collision with ally bullets
void checkAllyBulletHits()
{
 for(int i = spaceObjects.size() - 1 ; i >= 0   ;i --)
 {
    SpaceObject so = spaceObjects.get(i);
    if (so instanceof EnemyShip)
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
            spaceObjects.remove(other);
          }
        }
      }
    }
 } 
}

void checkAllyBulletHitsGeneral()
{
 for(int i = spaceObjects.size() - 1 ; i >= 0   ;i --)
 {
    SpaceObject so = spaceObjects.get(i);
    if (so instanceof General)
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
            if(so instanceof General)
            {
              ((AffectEnemy) other).applyTo((General)so);
            }
            spaceObjects.remove(other);
          }
        }
      }
    }
 } 
}


void CheckBulletAsteroidCollisions()
{
 for(int i = spaceObjects.size() - 1 ; i >= 0   ;i --)
 {
    SpaceObject so = spaceObjects.get(i);
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

//load high scores
void loadHighScores()
{
    String[] lines = loadStrings("highScores.txt");
    for (int i = 0 ; i < lines.length ; i ++)
    {
       HighScores score = new HighScores(lines[i]);
      scores.add(score);
      println(score.player + " " + score.score);
    }
        
}

