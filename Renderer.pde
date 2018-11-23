public class Renderer{
  public RenderOptions renderOptions;
  public Camera camera;
  public Scene scene;
  
  public Renderer() {}
  
  public Renderer(RenderOptions options, Camera camera, Scene scene) {
    this.renderOptions = options;
    this.camera = camera;
    this.scene = scene;
  }
  
  public PVector computeDirectIllumination(BSDF bsdf, ShaderGlobals shaderGlobals) {
    PVector directIllumination = new PVector(0, 0, 0);
    
    for(int i = 0; i < scene.shapes.size(); i++){
      Shape light = scene.shapes.get(i);
      
      if(light.explicitLight){
        shaderGlobals.lightDirection = PVector.sub(((Sphere)light).position, shaderGlobals.point);
        
        Ray ray = new Ray(shaderGlobals.point, shaderGlobals.lightDirection);
        
        Intersection intersection = scene.intersects(ray);
        
        if(intersection.hit && intersection.index == i){
          PVector bsdfValue = bsdf.evaluate(shaderGlobals);
          float cosine = shaderGlobals.normal.dot(shaderGlobals.lightDirection);
          PVector lightIntensity = light.evaluate(shaderGlobals);
          
          directIllumination.add(multiplyColor(PVector.mult(bsdfValue, cosine), lightIntensity));
        }
      }
    }
    
    return directIllumination;
  }
  
  public PVector computeIndirectIllumination(BSDF bsdf, ShaderGlobals shaderGlobals, int depth) {
    return null;
  }
  
  public PVector trace(Ray ray, int depth){
    Intersection intersection = scene.intersects(ray);
    
    if (intersection.hit){
      Shape shape = scene.shapes.get(intersection.index);
      ShaderGlobals shaderGlobals = shape.calculateShaderGlobals(ray, intersection);
      
      if(shape.explicitLight){
        return shape.evaluate(shaderGlobals);
      }
      
      return computeDirectIllumination(shape.bsdf, shaderGlobals);
    }
      
    return new PVector(0, 0, 0);
  }
  
  public PImage render(){
    
      print("ok");
       print(renderOptions.width);
    PImage image = createImage(renderOptions.width, renderOptions.height, RGB);
  
    
    for (int i=0; i < renderOptions.width; i++){
      for (int j=0; j < renderOptions.height; j++){
        
        ArrayList<PVector> samples = stratifiedSample(renderOptions.cameraSamples);
        
        PVector pColor = new PVector(0,0,0);
        float totalWeight = 0;
        
        //PVector point = new PVector(0.5, 0.5);
        
        for(int k=0; k < renderOptions.cameraSamples; k++){
          PVector sample = PVector.sub(samples.get(k), new PVector(0.5, 0.5)).mult(renderOptions.filterWidth);
          Ray ray = camera.generateRay(i, j, sample);
          float weight = gaussian2D(sample, renderOptions.filterWidth);
          
          
          
          pColor.add(PVector.mult(trace(ray, 0), weight));
          
          print(weight);
          
          totalWeight += weight;
        }
        
        pColor.div(totalWeight);
        
        pColor = saturate(gamma(exposure(pColor, renderOptions.gamma), renderOptions.exposure)).mult(255.0);
        
        image.set(i, j, color(pColor.x, pColor.y, pColor.z));
        
      }
    }
    
    return image;
  }
}
