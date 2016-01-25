class Bullet extends SpaceObject implements AffectEnemy
{
  
  void applyTo(EnemyShip enemy)
  {
    enemy.health -= 25;
  }
 
   void render()
  {
     pushMatrix();
     translate(pos.x, pos.y);
     line(0, 0-halfW, 5, 0-halfW);
     line(0, 14, 5, 14);
     popMatrix();
  }   
  
  void update()
  {
    forward.mult(speed);
    pos.x += speed*2;
    
    //removes bullet from array list when out of bounds
    if (pos.x < 0 || pos.y < 0 || pos.x > width || pos.y > height)
    {
      spaceObjects.remove(this);
    }
  }
}
