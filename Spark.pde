class Spark
{
  float direction;
  float energy;

  float maxEnergy;

  ArrayList<PVector> points = new ArrayList<PVector>();

  PVector currentDirection;
  PVector position;

  float distanceThreshold = 10;
  float travelDistance = 2;

  Spark parent = null;

  float startThickness = 4;

  int locationIndex = 0;

  Spark(float startEnergy, PVector startPosition, float dir)
  {
    energy = startEnergy;
    maxEnergy = startEnergy;
    position = startPosition;
    direction = dir;
  }

  void traverse(Particle[] parts)
  {
    float d = 100000;

    Particle closestParticle = null;
    Particle secondClosestParticle = null;

    for (int i= 0; i < numParticles; i++)
    {
      float buffer = dist(parts[i].position.x, parts[i].position.y, position.x, position.y);
      if (buffer < d)
      {
        d = buffer;
        secondClosestParticle = closestParticle;
        closestParticle = parts[i];
      }
    }    
    
    currentDirection = getDeflection(closestParticle, secondClosestParticle).mult(travelDistance);
    currentDirection.rotate(direction);


    position.add(currentDirection);
    points.add(new PVector(position.x, position.y));
    energy -= 1;
  }


  PVector getDeflection(Particle p1, Particle p2)
  {
    if (p1 == null)
    {
      return null;
    }

    float dx = p1.position.x - p2.position.x;
    float dy = p1.position.y - p2.position.y;

    PVector v = new PVector(dx, dy);
    float angle =  v.heading();


    if (sin(angle+HALF_PI) > 0)
    {
      return v.rotate(HALF_PI).normalize();
    } else
    {
      return v.rotate(-HALF_PI).normalize();
    }
  }


  Spark splitSpark(float startEnergy, PVector startPosition, float dir)
  {

    Spark s =  new Spark(startEnergy, startPosition, dir);

    s.parent = this;

    s.locationIndex = points.size();

    return s;
  }

  float maxThickness()
  {
    if (parent != null)
    {
      return map(locationIndex, parent.points.size(), 0, 0, parent.maxThickness());
    }
    return startThickness;
  }

  void draw()
  {

    int m = points.size();
    for (int i = 1; i < m; i++)
    {
      float t = map(i, m, 0, 0, maxThickness());

      strokeWeight(t);
      line(points.get(i-1).x, points.get(i-1).y, points.get(i).x, points.get(i).y);
    }
  }
}
