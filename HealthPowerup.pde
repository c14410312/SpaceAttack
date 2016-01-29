class HealthPowerup extends SpaceObject implements AffectAlly
{
  HealthPowerup()
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
    fill(255,0,0);
    rect(-15,-25,5,halfW);
    rect(-25,-15,halfW,5);
    popMatrix();
  }
  
  void update()
  {
     pos.x -= speed/2; 
  }
  
  void applyTo(AllyShip AShip)
  {
    AShip.health = 100;
  }
  
  
}