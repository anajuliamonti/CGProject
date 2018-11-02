public class Sphere extends Shape {
    PVector position;
    float radius;

    public Sphere() {
    }

    public Sphere(PVector position, float radius, BSDF bsdf, boolean explicitLight, PVector emission) {
      super(null,bsdf,explicitLight,emission);
      this.position = position;
      this.radius = radius;
    }
    
    @Override
    public Intersection intersects(Ray ray){
      PVector d = PVector.sub(position, ray.origin);
      float t = d.dot(ray.direction);
      
      if(t<0)
        return new Intersection();
        
      float d2 = d.dot(d) - t * t;
      float r2 = radius * radius;
      
      if(d2 > r2)
        return new Intersection();
        
      float dt = sqrt(r2 - d2);
    }
    
    @Override
    public ShaderGlobals calculateShaderGlobals(Ray ray, Intersection intersection){
      PVector point = ray.point(intersection.distance);
      PVector normal = PVector.sub(point, position).normalize();
      
      float theta = atan2(normal.x, normal.y);
      float phi = acos(normal.y);
      
      PVector uv = new PVector((theta * INVERSE_PI + 1.0) * 0.5, phi * INVERSE_PI);
      
      float st = sin(theta);
      float sp = sin(phi);
      float ct = cos(theta);
      float cp = cos(phi);
      
      PVector tangentU = new PVector(ct, 0, -st);
      PVector tangentV = new PVector(st * cp, -sp, ct * cp);
      
      PVector viewDirection = PVector.mult(ray.direction, -1.0);
      
      return new ShaderGlobals(point, normal, uv, tangentU, tangentV, viewDirection, null);
      
    }
    
}
