class Asteroid extends SpaceObject implements AffectAlly
{
   float thetaDir;
   float place;
  
   Asteroid()
   {
      super(width,random(0+10,height-10), 50); 
      forward.x = random(-1, 1);
      forward.y = random(-1, 1);
      forward.normalize();
      thetaDir = random(-0.1f, 0.1f);
      place = random(10,25);
   }
   
   void render()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    fill(255);
    strokeWeight(1);
    stroke(255);
    rotate(theta);
    ellipse(halfW,-halfW, 50, 50);
    stroke(0);
    ellipse(halfW-10,-halfW, 10, 10);
    ellipse(halfW+10,-halfW + place, 20, 20);
    ellipse(halfW+10,-halfW - place, 20, 20);
    noStroke();
    ellipse(halfW-10,-halfW +place, 20, 20);
    popMatrix();
  }
  
  void update()
  {
     pos.x -= speed*0.5; 
     //theta += 0.01f;
     
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
