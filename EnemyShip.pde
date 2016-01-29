class EnemyShip extends SpaceObject
{
   EnemyShip()
  {
     super(width,random(0+10,height-10), 50);
     println("Default Enemy Ship constructer");
  }
  
  EnemyShip(float startX, float startY)
  {
     super(startX, startY, 50); 
     health = 100;
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
        fill(255);
      }
      else
      {
        fill(0);
      }
      strokeWeight(1);
      stroke(0);
      text(+ health, 5 ,10);
      rect(- halfW, - halfW, w/2, w/2);
      rect(-36,-10,10,-5);
      
      if(health <= 0)
      {
        explode(-halfW,-halfW);
      }
      popMatrix();
  }
}