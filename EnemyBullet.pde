class EnemyBullet extends SpaceObject implements AffectAlly
{
 
   void render()
  {
     pushMatrix();
     translate(pos.x, pos.y);
     line(0, -halfW/2, 5, -halfW/2);
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
    AShip.health -= 5;
  }
}
