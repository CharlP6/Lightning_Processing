//import Particle;

Particle[] particles;

int numParticles = 30000;

float totalEnergy = 1;

ArrayList<Spark> bolt = new ArrayList<Spark>();

void setup()
{
  size(800, 800);
  particles = new Particle[numParticles];

  for (int i = 0; i < 1; i++)
  {
    bolt.add(new Spark(10000, new PVector(width/2, 0), 0));
  }



  for (int i= 0; i < numParticles; i++)
  {
    particles[i] = new Particle(new PVector(random(width), random(height)), 8);
  }
}

void updateLightning(float splitChance, float splitEnergyTransfer, float splitEnergyRemaining, float maxSplitAngle, float minSplitAngle)
{
  ArrayList<Spark> ns = new ArrayList<Spark>();

  totalEnergy = 0;
  //int n = 0;
  for (Spark b : bolt)
  {
    if (b.energy > 0)
    {
      totalEnergy += b.energy;
      b.traverse(particles);
      float sc = random(0, 1);

      if (sc < splitChance)
      {
        float splitAngle = random(minSplitAngle, maxSplitAngle);
        if (random(-1, 1)>0)
        {
          splitAngle *= -1;
        }

        ns.add(b.splitSpark(b.energy*splitEnergyTransfer, b.position.copy(), b.direction + splitAngle));

        b.energy *= splitEnergyRemaining;
      }
    }
    //stroke(360*n/bolt.size(),100,100);
    b.draw();
    //n++;
  }

  for (Spark s : ns)
  {
    bolt.add(s);
  }
}

int frameNum = 1132;

void draw()
{
  //translate(width/2,height/2);
  //background(115, 77, 38);
  //stroke(153, 153, 102);

  //background(0, 0, 10);
  //stroke(0, 180, 250);
  //colorMode(HSB,360,100,100);
  background(200);
  stroke(0);

  noFill();

  float splitChance = 0.05;
  float splitEnergyTransfer = random(0.08);
  float splitEnergyRemaining = 0.85;
  float maxSplitAngle = PI/3;
  float minSplitAngle = PI/6;

  updateLightning(splitChance, splitEnergyTransfer, splitEnergyRemaining, maxSplitAngle, minSplitAngle);

  if (totalEnergy > 0)
  {
    //save("frame_" + frameNum + ".jpg");
    //println(frameRate);
    frameNum++;
  } else
  {
    print("Done!");
    noLoop();
  }
}
