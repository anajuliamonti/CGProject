public final float INVERSE_PI = 0.318;
public final float EPSILON = Float.MIN_VALUE;
public final float INFINITY = Float.MAX_VALUE;

PVector gamma(PVector color, float value){
  float inverseGamma = 1/value;
  
  return new PVector(pow(color.x, inverseGamma),
                pow(color.y, inverseGamma),
                pow(color.z, inverseGamma));
}

PVector exposure(PVector color, float value){
  float power = pow(2, value);
  return PVector(color.x * power,
               color.y * power,
               color.z * power);
  }
