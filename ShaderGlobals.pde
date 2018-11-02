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
    
    public ShaderGlobals(PVector point, PVector normal, PVector uv, PVector tangentU, PVector tangentV, PVector viewDirection, PVector lightDirection, PVector lightPoint, PVector lightNormal){}
}
