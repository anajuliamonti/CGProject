public class Film{
  float width;
  float height;
  
  public Film(){}
  
  public Film(float width, float height){
    this.width = width;
    this.height = height;
  }
  
  public float aspectRatio(){
    return width / height;
  }
}
