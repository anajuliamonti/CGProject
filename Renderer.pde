public class Renderer(){
  public Renderer() {}
  
  public Renderer(RenderOptions options, Camera camera, Scene scene) {}
  
  public PVector computeDirectIllumination(BSDF bsdf, ShaderGlobals shaderGlobals) {
  }
  
  public PVector computeIndirectIllumination(BSDF bsdf, ShaderGlobals shaderGlobals, int depth) {
  }
  
  public PVector trace(Ray ray, int depth){
    Intersection intersection = scene.intersects(ray);
    
    if (intersection.hit)
      return PVector(1.0, 1.0, 1.0);
      
    return PVector(0, 0, 0);
  }
  
  RenderOptions renderOptions = new RenderOptions();
  
  public PImage render(){
    PImage image = createImage(width, height);
    
    for (int i=0;i < width - 1;i++){
      for (int j=0;j < height – 1, j++){
        PVector[] samples = stratifiedSample(renderOptions.cameraSamples);
        
        PVector pColor = new PVector(0,0,0);
        float totalWeight = 0;
        
        PVector point = new PVector(0.5, 0.5);
        
        for(int k=0, k < cameraSamples - 1){
          PVector sample = PVector.mult((PVector.sub(samples[k], point)), renderOptions.filterWidth);
          Ray ray = camera.generateRay(i, j, sample);
          float weight = gaussian2D(sample, renderOptions.filterWidth);
          
          pColor = PVector.add(pColor, PVector.mult(trace(ray, 0), renderOptions.weight));
          
          totalWeight += renderOptions.weight;
        }
        
        pColor = PVector.div(pColor, totalWeight);
        
        //image[i][j] = saturate(exposure(gamma(color, gammaValue), exposureValue)) * 255
        
        image.set(saturate(exposure(gamma(pColor, gammaValue));
        
      }
    }
    
    return;
  }
}
