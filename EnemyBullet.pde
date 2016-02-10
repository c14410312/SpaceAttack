class EnemyBullet extends SpaceObject implements AffectAlly
{
 
   void render()
  {
     pushMatrix();
     translate(pos.x, pos.y);
     if(level ==1)
     {
       fill(0,0,250);
     }
     if(level == 2)
     {
        fill(255,102,102); 
     }
     if(level == 3)
     {
        fill(255,255,0); 
     }
     strokeWeight(1);
     stroke(200,0,0);
     ellipse(0, -halfW/2, 20 , 2 );
     popMatrix();
  }   
  
  void update()
  {
    forward.mult(speed);
    pos.x -= speed*2;
    
    //removes bullet from array list when out of bounds
    if (pos.x < 0 || pos.y < 0 || pos.x > width || pos.y > height)
    {
      spaceObjects.remove(this);
    }
  }
  
  void applyTo(AllyShip AShip)
  {
    //deducts health
    if(AShip.shield == true)
    {
       AShip.shieldHealth -= 5; 
    }
    else
    {
      AShip.health -= 5;
    }
  }
}
