class Particle
{
  
  PVector position;
  float radius = 5;
  
  Particle closestNeighbour = null;
  
  Particle(PVector pos, float rad)
  {
    position = pos;
    radius = rad;
  }
  
  PVector getDeflection()
  {
    if(closestNeighbour == null)
    {
       return null;      
    }
    
    float dx = closestNeighbour.position.x - position.x;
    float dy = closestNeighbour.position.y - position.y;
    
    PVector v = new PVector(dx,dy);
    float angle =  v.heading();
     
    
    if(sin(angle+HALF_PI) > 0)
    {
      return v.rotate(HALF_PI).normalize();
    }
    else
    {
      return v.rotate(-HALF_PI).normalize();
    }
  }
   
  
  void draw()
  {
    noFill();
    ellipse(position.x, position.y, radius, radius);
  }
  
}
