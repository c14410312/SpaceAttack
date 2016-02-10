class GeneralRocket extends SpaceObject implements AffectAlly
{
  float spread = 5;
  
  void applyTo(AllyShip AShip)
  {
    AShip.health -= 25;
  }
  
  void render()
  {
     pushMatrix();
     translate(pos.x, pos.y);
     fill(255);
     strokeWeight(1);
     stroke(255,150,0);
     fill(255,0,0);
     ellipse(0, -10, 35,20);
     popMatrix();
  }
  
  void update()
  {
    spread -= 0.1;
    forward.mult(speed);
    pos.x -= speed*2.5;
    pos.y += spread;
    
    //removes rokets from array list when out of bounds
    if (pos.x < 0 || pos.y < 0 || pos.x > width || pos.y > height)
    {
      spaceObjects.remove(this);
    }
  }
    
}
