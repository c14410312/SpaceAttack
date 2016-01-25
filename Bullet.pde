class Bullet extends SpaceObject implements AffectEnemy
{
  
  void applyTo(EnemyShip enemy)
  {
    enemy.health -= 25;
  }
  
  void applyTo(General gShip)
  {
    gShip.health -= 25;
  }
 
   void render()
  {
     pushMatrix();
     translate(pos.x, pos.y);
     fill(0,0,250);
     strokeWeight(1);
     stroke(150,0,190);
     ellipse(0, -halfW, 20 , 2 );
     ellipse(0, 14, 20, 2);
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
