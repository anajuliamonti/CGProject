void setup(){
  size(500, 500);
  
  RenderOptions options = new RenderOptions(500, 500, 2, 4, 4, 4, 0.25, 2.2, 0);
  
  Camera camera = new Camera(radians(20.0), new Film(options.width, options.height), new PMatrix3D());
  
  camera.lookAt(new PVector(0, 0, 35), new PVector(0, 0, 0), new PVector(0, 1.0, 0));
  
  Diffuse diffuse = new Diffuse(new PVector(1, 1, 1));
  
  Sphere left = new Sphere(new PVector(-1e5 - 5, 0, 0), 1e5, diffuse, false, null);
  Sphere right = new Sphere(new PVector(1e5 + 5, 0, 0), 1e5, diffuse, false, null);
  Sphere top = new Sphere(new PVector(0, 1e5 + 5, 0), 1e5, diffuse, false, null);
  Sphere bottom = new Sphere(new PVector(0, -1e5 - 5, 0), 1e5, diffuse, false, null);
  Sphere back = new Sphere(new PVector(0, 0, -1e5 - 5), 1e5, diffuse, false, null);
  Sphere lightBall = new Sphere(new PVector(0, 2, 0), 2, null, true, new PVector(1.0, 1.0, 1.0));
  Sphere frontBall = new Sphere(new PVector(2, -3, 2), 2, diffuse, true, null);
  Sphere backBall = new Sphere(new PVector(-2, -3, -2), 2, diffuse, false, null);
  
  ArrayList<Shape> shapes = new ArrayList();
  
  shapes.add(left);
  shapes.add(right);
  shapes.add(top);
  shapes.add(bottom);
  shapes.add(back);
  shapes.add(lightBall);
  shapes.add(frontBall);
  shapes.add(backBall);
  
  Scene scene = new Scene(shapes);
  
  Renderer renderer = new Renderer(options, camera, scene);
  
  image(renderer.render(), 0, 0);
  
  noLoop();
}

void draw(){

}
