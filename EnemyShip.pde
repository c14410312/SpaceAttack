class EnemyShip extends SpaceObject
{
   AudioPlayer invaderkilled;
  
   EnemyShip()
  {
     super(width,random(0+10,height-10), 50);
     println("Default Enemy Ship constructer");
  }
  
  EnemyShip(float startX, float startY)
  {
     super(startX, startY, 50); 
     health = 100;
     invaderkilled = minim.loadFile("blast.mp3");
  }
  
  void update()
  {
    forward.mult(speed);
    pos.x -= speed*0.5;
    
    
    if(elapsed > 40 && health > 0)
      {
        EnemyBullet bullet = new EnemyBullet();
        bullet.pos.x = pos.x;
        bullet.pos.y = pos.y;
        spaceObjects.add(bullet);
        elapsed = 0 ;
      }
    //removes enemy ship if health below 1
    if(health <= 0)
    {
      //allow explosion to execute before removing
      if(frameCount % 60 == 0)
      {
        spaceObjects.remove(this);
        invaderkilled.rewind();
        invaderkilled.play();
        
         //adds points onto the allyships score board
        for(int i =0; i < spaceObjects.size();i++)
          {
            SpaceObject so = spaceObjects.get(i);
            if (so instanceof AllyShip)
            {
              so.score += 20;
              println("Dead");
            }
          }
      }
      
     
    }
      
    //removes EnemyShip from array list when out of bounds
    if (pos.x < 0 ||pos.x > width)
    {
      spaceObjects.remove(this);
    }
     elapsed++; 
  }
  
     
  void render()
  {
      pushMatrix();
      translate(pos.x, pos.y);
      if(health > 0)
      {
        fill(0,255,0);
      }
      else
      {
        fill(0);
      }
      noStroke();
      textSize(10);
      text(+ health, 5 ,10);
      //green
      arc(5, -10, 60, 40,  HALF_PI,PI+HALF_PI);
      rect(-36,-8,10,-5);
      //white
      fill(255);
      arc(5, -10, 60, 20,  HALF_PI,PI+HALF_PI);
      //purple
      fill(255,0,255);
      arc(5, -10, 60, 5,  HALF_PI,PI+HALF_PI);
      
      if(health <= 0)
      {
        explode(-halfW,-halfW);
      }
      popMatrix();
  }
}
