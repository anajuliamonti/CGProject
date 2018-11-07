public class ShaderGlobals {
    PVector point;
    PVector normal;
    PVector uv;
    PVector tangentU;
    PVector tangentV;
    PVector viewDirection;
    PVector lightDirection;
    PVector lightPoint;
    PVector lightNormal;

    public ShaderGlobals() {
    }
    
    public ShaderGlobals(PVector point, PVector normal, PVector uv, PVector tangentU, PVector tangentV, PVector viewDirection, PVector lightDirection, PVector lightPoint, PVector lightNormal){
      this.point = point;
      this.normal = normal;
      this.uv = uv;
      this.tangentU = tangentU;
      this.tangentV = tangentV;
      this.viewDirection = viewDirection;  
      this.lightDirection = lightDirection;
      this.lightPoint = lightPoint;
      this.lightNormal = lightNormal;
    }
}
