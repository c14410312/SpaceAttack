class General extends SpaceObject
{
   AudioPlayer invaderkilled;
  
   General()
   {
      super(width,random(0,height), 50);
   } 
   
   General(float startX, float startY)
  {
     super(startX, startY, 50); 
     health = 2000;
     int elapsed;
     int elapsed2;
     invaderkilled = minim.loadFile("blast.mp3");
  }
  
  void update()
  {
   
    if(pos.y > height)
    {
      dir = !dir;
    }
    
    if(pos.y < 0)
    {
      dir = !dir;
    }
    
    if(dir)
    {
      pos.y += speed * 0.5;
    }
    
    if(!dir)
    {
      pos.y -= speed *0.5;
    }
    
    if(elapsed > 40)
    {
      for(int i = 0; i < 6; i ++)
      {
          EnemyBullet ebullet = new EnemyBullet();
          ebullet.pos.x = pos.x;
          ebullet.pos.y = (pos.y-60)  + (i * 25);
          spaceObjects.add(ebullet);
       }
       elapsed = 0;
    }
    
    if(elapsed2 > 180 && level == 2 || elapsed2 > 180 && level == 3)
    {
      for(int i = 0; i < 6; i ++)
      {
        
          GeneralRocket GRocket = new GeneralRocket();
          GRocket.pos.x = pos.x;
          GRocket.pos.y = (pos.y-60)  + (i * 25);
          spaceObjects.add(GRocket);
       }
       elapsed2 = 0;
    }

    
    //removes general and adds points when general killed
    if(health <= 0)
    {
      textSize(50);
      fill(255);
      text("Level" + level+ " Completed!", width/2, height/2);
      
      if(frameCount % 180 == 0)
      {
        invaderkilled.rewind();
        invaderkilled.play();
        spaceObjects.remove(this);
      
        //adds points onto the allyships score board
        for(int i =0; i < spaceObjects.size();i++)
          {
            SpaceObject so = spaceObjects.get(i);
            if (so instanceof AllyShip)
            {
              so.score += 250;
              level += 1;
              timer = 0;
            }
          }
      }
    }
    
    elapsed ++;
    elapsed2++;
    
    if (gameOver == true)
    {
      spaceObjects.remove(this);
    }
  }
  
  
  void render()
  {
      pushMatrix();
      translate(pos.x, pos.y);
      text(+ health, -10 ,50);
      strokeWeight(1);
      noStroke();
      fill(255,0,0);
      arc(-5, -10, 100, 150,  HALF_PI,PI+HALF_PI);
      rect(-halfW,-70,-20,-5);
      rect(-w,-25,-20,-5);
      rect(-w,15,-20,-5);
      rect(-halfW,55,-20,-5);
      fill(119);
      arc(-5, -10, 100, 80,  HALF_PI,PI+HALF_PI);
      fill(255);
      arc(-5, -10, 100, 20,  HALF_PI,PI+HALF_PI);
      
      if(health <= 0)
      {
        explode(-halfW-20,-halfW*2);
        explode(-halfW-20,-halfW/2);
        explode(-halfW-20,halfW);
      }
      popMatrix();
  }
}
