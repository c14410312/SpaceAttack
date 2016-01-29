class Rocket extends SpaceObject implements AffectEnemy
{
  
  void applyTo(EnemyShip enemy)
  {
    enemy.health -= 100;
  }
  
  void applyTo(General gShip)
  {
    gShip.health -= 100;
  }
  
  void applyTo(Asteroid enemy)
  {
     spaceObjects.remove(this); 
  }
  
  void render()
  {
     pushMatrix();
     translate(pos.x, pos.y);
     fill(255);
     strokeWeight(1);
     stroke(0, 200, 50);
     fill(0,255,150);
     ellipse(0, -10, 25,15);
     popMatrix();
  }
  
  void update()
  {
    forward.mult(speed);
    pos.x += speed*2.5;
    
    //removes bullet from array list when out of bounds
    if (pos.x < 0 || pos.y < 0 || pos.x > width || pos.y > height)
    {
      spaceObjects.remove(this);
    }
  }
    
}