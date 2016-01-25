class Asteroid extends SpaceObject implements AffectAlly
{
   float thetaDir;
  
   Asteroid()
   {
      super(width,random(0+10,height-10), 50); 
      forward.x = random(-1, 1);
      forward.y = random(-1, 1);
      forward.normalize();
      thetaDir = random(-0.1f, 0.1f);
   }
   
   void render()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    fill(255);
    strokeWeight(1);
    stroke(255);
    rotate(theta);
    float lastX = 0; float lastY = - halfW;
    int sides = 6;
    float thetaInc = TWO_PI / sides;
    for(int i = 0 ; i <= sides ; i ++)
    {
      float t = i * thetaInc;
      float x = sin(t) * halfW;
      float y = -cos(t) * halfW;
      line(lastX, lastY, x, y);
      lastX = x;
      lastY = y;
    }
    popMatrix();
  }
  
  void update()
  {
     pos.x -= speed*0.5; 
     theta += thetaDir;
     
    //removes Asteroid from array list when out of bounds
    if (pos.x < 0 || pos.y < 0 || pos.x > width || pos.y > height)
    {
      spaceObjects.remove(this);
    }
  }
  
  void applyTo(AllyShip AShip)
  {
    if(AShip.shield == true)
    {
       AShip.shieldHealth -= 25; 
    }
    else
    {
      AShip.health -= 25;
    }
    spaceObjects.remove(this);
  }
}
