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
    text("Rocekts",0,0);
    popMatrix();
  }
  
  void update()
  {
     pos.x -= speed/2; 
  }
  
  void applyTo(AllyShip AShip)
  {
    AShip.rocketShells += 10;
  }
  
  
}