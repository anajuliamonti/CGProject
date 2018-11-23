public final float INVERSE_PI = 0.318;
public final float EPSILON = Float.MIN_VALUE;
public final float INFINITY = Float.MAX_VALUE;

float uniformRandom1D() {
    return random(1.0);
}

PVector uniformRandom2D() {
    return new PVector(uniformRandom1D(), uniformRandom1D());
}

ArrayList<PVector> stratifiedSample (int samples){
  ArrayList<PVector> points = new ArrayList(samples);
  int size = (int)sqrt(samples);
  
  for(int i=0; i < samples; i++){
    PVector offset = new PVector(i / size, i % size);
    PVector point = PVector.add(uniformRandom2D(), offset).div(size);
    
    points.add(point);
  } 
  
  return points;
}

PVector gamma(PVector pColor, float value){
  float inverseGamma = 1/value;
  
  return new PVector(pow(pColor.x, inverseGamma),
                     pow(pColor.y, inverseGamma),
                     pow(pColor.z, inverseGamma));
}

PVector exposure(PVector pColor, float value){
  float power = pow(2, value);
  
  return new PVector(pColor.x * power,
                     pColor.y * power,
                     pColor.z * power);
}

PVector multiplyColor(PVector a, PVector b){
  return new PVector(a.x * b.x, a.y * b.y, a.z * b.z);
}

float gaussian1D(float sample, float width){
  float radius = width * 0.5;
  return max(0, exp(-sample * sample) - exp(-radius * radius));
}

float gaussian2D(PVector sample, float width){
  return gaussian1D(sample.x, width) * gaussian1D(sample.y, width);
}

PVector saturate(PVector pColor){
  return new PVector(constrain(pColor.x, 0, 1.0), constrain(pColor.y, 0, 1.0), constrain(pColor.z, 0, 1.0));
}
