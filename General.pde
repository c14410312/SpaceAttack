class General extends SpaceObject
{
   General()
   {
      super(width,random(0,height), 50);
   } 
   
   General(float startX, float startY)
  {
     super(startX, startY, 50); 
     health = 500;
     int elapsed;
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
      for(int i = 0; i < 4; i ++)
      {
          EnemyBullet ebullet = new EnemyBullet();
          ebullet.pos.x = pos.x;
          ebullet.pos.y = pos.y  + (i * 20);
          spaceObjects.add(ebullet);
       }
       elapsed = 0;
    }

    
    //removes general and adds points when general killed
    if(health <= 0)
    {
      spaceObjects.remove(this);
      
      //adds points onto the allyships score board
      for(int i =0; i < spaceObjects.size();i++)
        {
          SpaceObject so = spaceObjects.get(i);
          if (so instanceof AllyShip)
          {
            so.score += 150;
            println("General Dead");
          }
        }
    }
    
    elapsed ++;
  }
  
  void render()
  {
      pushMatrix();
      translate(pos.x, pos.y);
      text(+ health, 5 ,10);
      strokeWeight(1);
      noStroke();
      fill(255);
      rect(- halfW, - halfW, w/2, w*2);
      rect(-36,-20,10,-5);
      rect(-36,10,10,-5);
      rect(-36,45,10,-5);
      rect(-36,75,10,-5);
      popMatrix();
  }
}
