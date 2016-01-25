class HealthPowerup extends SpaceObject implements AffectAlly
{
  HealthPowerup()
  {
     super(width,random(0+10,height-10), 50);  
  }
  
  
  
  void render()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    fill(255);
    strokeWeight(1);
    rect(- halfW, - halfW, halfW, halfW);
    text("Health", -30, halfW);
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

