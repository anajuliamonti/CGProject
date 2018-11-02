import Ray;

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
      0, 0, 0, 1);
  }
  
  public void transform(PMatrix3D transformation){}
  
  public Ray generateRay(float x, float y, PVector sample){
    float scale = tan(fieldOfView * 0.5);
    
    PVector pixel = new PVector();
    
    //pixel.x = (2.0 * (xj))
    
    //Comecar a implementar a partir do slide 3
    //----------------------------------------------------------
    
    float xc = film.aspectRatio() * (fieldOfView/2) * x;
    float yc = (fieldOfView/2) * y;
    
    PVector Pc = new PVector(xc, yc, -1);
    PVector Plinha = new PVector(1, 1, 1);
    Plinha = worldMatrix.mult(Pc,Plinha);
    
    PVector D = PVector.sub(Plinha, sample).normalize();

    return new Ray(Pc, D);
  }
}
