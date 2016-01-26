class Shield extends SpaceObject implements AffectAlly
{
  Shield()
  {
     super(width,random(0+10,height-10), 50);  
  }
  
  
  
  void render()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    fill(0,255,255);
    strokeWeight(1);
    rect(- halfW, - halfW, halfW, halfW);
    text("Shield", -30, halfW);
    popMatrix();
  }
  
  void update()
  {
     pos.x -= speed/2; 
  }
  
  void applyTo(AllyShip AShip)
  {
    AShip.shield = true;
    AShip.shieldHealth = 50;
  }
  
  
}
