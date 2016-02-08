class RocketPowerUp extends SpaceObject implements AffectAlly
{
  RocketPowerUp()
  {
     super(width,random(0+10,height-10), 50);  
  }
  
  
  
  void render()
  {
    pushMatrix();
    noStroke();
    translate(pos.x, pos.y);
    fill(255);
    rect(- halfW, - halfW, halfW, halfW);
    text("Rocekts",-30,halfW);
    popMatrix();
  }
  
  void update()
  {
     pos.x -= speed/2; 
     //removes powerup from array list when out of bounds
    if (pos.x < 0 || pos.y < 0 || pos.x > width || pos.y > height)
    {
      spaceObjects.remove(this);
    }
  }
  
  void applyTo(AllyShip AShip)
  {
    AShip.rocketShells += 10;
  }
  
  
}
