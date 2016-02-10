class AllyShip extends SpaceObject
{
  //fields to hold ship data
  char up;
  char left;
  char right;
  char down;
  char shoot;
  char weapChange;
  
  boolean shield = false;
  boolean rocket = false;
  int shieldHealth;
  int rocketShells;
  int laser;
  AudioPlayer shoots;
  AudioPlayer bottlerocket;
  AudioPlayer explosion;
  
  
  AllyShip()
  {
     super(width * 0.25f, height * 0.5f, 50);
     println("Default Ship Constructer");
  }
  
  AllyShip(char up, char left, char right, char down, char shoot, char weapChange, float startX, float startY)
  {
     super(startX, startY, 50); 
     this.up = up;
     this.left = left;
     this.right = right;
     this.down = down;
     this.shoot = shoot;
     this.weapChange = weapChange;
     health = 100;
     score = 0;
     rocketShells = 0;
     laser = 100;
     shoots = minim.loadFile("shoot.wav");
     explosion = minim.loadFile("explosion.wav");
     bottlerocket = minim.loadFile("bottlerocket.wav");
  }
  
  
   void update()
  {
    
      if (keys[up])
      {
        pos.y -= speed;
      }
      if (keys[down])
      {
        pos.y += speed;
      }
      if (keys[left])
      {
        pos.x -= speed;
      }
      if (keys[right])
      {
        pos.x += speed;
      }
      
      if(keys[shoot] && elapsed > 12 && rocket == false)
      {
        shoots.rewind();
        shoots.play();
        for(int i=0; i < 2; i++)
        {
          Bullet bullet = new Bullet();
          bullet.pos.x = pos.x;
          bullet.pos.y = pos.y  + (i * 40);
          spaceObjects.add(bullet);
          elapsed = 0 ;
        }
      }
      
      if(keys[shoot] && elapsed > 20 && rocket == true && rocketShells > 0)
      {
        bottlerocket.rewind();
        bottlerocket.play();
        Rocket rocket = new Rocket();
        rocket.pos.x = pos.x;
        rocket.pos.y = pos.y;
        spaceObjects.add(rocket);
        elapsed = 0 ;
        rocketShells --;
        
      }
      
      
      //switches to rocket if N is pressed
      if(keys[weapChange])
      {
        AudioPlayer track;
        track = minim.loadFile("Switch.wav");
        track.rewind();
        track.play(); 
        rocket = !rocket;
      }
      
      //checks to ensure ship stays within the screenplay
      if(pos.x < 0)
      {
         pos.x = border; 
      }
      
      if(pos.x > width-border * .75)
      {
        pos.x = width - border;
      }
      
      if(pos.y < 0)
      {
        pos.y = border;
      }
      
      if (pos.y > height -5)
      {
        pos.y = height - border *.75;
      }
      
      elapsed ++;
      
      fill(255);
      textSize(10);
      text("Health: " + health,40 , 20);
      text("Score: " + score,40 , 40);
      text("Rockets: " + rocketShells,40 , 60);
      
      //displays shield health if active
      if(shield == true)
      {
        text("Shield: " + shieldHealth,40 , 80);
      }
      
      if(health <= 0)
      {
        finalScore = score;
        gameOver = true;
        if(frameCount % 60 == 0)
        {
          explosion.rewind();
          explosion.play();
          spaceObjects.remove(this);
        }
      }
      
      //removes shield if health under 0
      if(shieldHealth <= 0)
      {
        shield = false;
        shieldHealth = 0;
      }
     
  }
  
  
  
  void render()
  {
     pushMatrix(); // reset the translation and rotation
     translate(pos.x, pos.y);
     strokeWeight(1);
     stroke(255);
     if(health > 0)
      {
        fill(255,255,0);
        noStroke();
      }
      else
      {
        fill(0);
      }
     //main body
     arc(15, -5, 60, 40,  HALF_PI,PI+HALF_PI);
     //for guns
     rect(15, 0- halfW, 15, 2);
     rect(15,13, 15, 2);
     //white
     fill(255);
     arc(15, -5, 60, 15,  HALF_PI,PI+HALF_PI);
     //blue stripe
     fill(0,0,255);
     arc(15, -5, 60, 5,  HALF_PI,PI+HALF_PI);
     
     //if shield collected
     if(shield == true)
     {
        noFill();
        strokeWeight(3);
        stroke(0,255,255);
        ellipse(halfW/2,-5, w+10,w+10); 
     }
     
     if(health <= 0)
      {
        explode(-halfW,-halfW);
      }
     
     popMatrix();
  }
  
}
