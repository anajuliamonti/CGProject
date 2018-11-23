public class Camera{
  float fieldOfView;
  PMatrix3D worldMatrix;
  public Film film;
  
  public Camera(){}
  
  public Camera(float fieldOfView, Film film, PMatrix3D worldMatrix){
    this.fieldOfView = fieldOfView;
    this.film = film;
    this.worldMatrix = worldMatrix;
  }
  
  public void lookAt(PVector position, PVector target, PVector up){
    PVector w = PVector.sub(position, target).normalize();
    PVector u = w.cross(up, w).normalize();
    PVector v = w.cross(w,u);
    
    worldMatrix = new PMatrix3D(u.x, v.x, w.x, position.x,
      u.y, v.y, w.y, position.y,
      u.z, v.z, w.z, position.z,
      0, 0, 0, 1.0);
  }
  
  public void transform(PMatrix3D transformation){
    worldMatrix.preApply(transformation);
  }
  
  public Ray generateRay(float x, float y, PVector sample){
    
    float scale = tan(fieldOfView * 0.5);
        
    PVector pixel = new PVector();
        
    pixel.x = (2.0 * (x + 0.5 + sample.x) / film.width - 1.0) * scale * film.aspectRatio();
    pixel.y = (1.0 - 2.0 * (y + 0.5 + sample.y) / film.height) * scale;
    pixel.z = -1.0;
        
    worldMatrix.mult(pixel, pixel);
        
    PVector origin = new PVector(worldMatrix.m03, worldMatrix.m13, worldMatrix.m23);
    PVector direction = PVector.sub(pixel, origin).normalize();
        
    return new Ray(origin, direction);
  }
}
