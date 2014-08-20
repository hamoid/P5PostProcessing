/**
  
  DOF example based on https://github.com/neilmendoza/ofxPostProcessing
  
  Move your mouse in X to change de focus distance
  
**/
  
  DofManager dof;
  
  boolean renderDepth = false;

  PShape shp;

  public void setup() {
    size(800, 400, P3D);
    dof = new DofManager();
    dof.setup(this, width, height);

    shp = createShape(SPHERE, 100);
    shp.setFill(color(255));
    shp.setStroke(false);
   }

  public void draw() {
    background(0);

    drawGeometry(dof.getSrc(), true);
    drawGeometry(dof.getDepth(), false);

    frame.setTitle("" + frameRate);

    dof.draw();

    dof.setMaxDepth(2000);
    dof.setFocus(map(mouseX, 0, width, -0.5f, 1.5f));
    dof.setMaxBlur(0.015);
    dof.setAperture( 0.02f);
    

    if(!renderDepth)
      image(dof.getDest(), 0, 0);
    else
      image(dof.getDepth(), 0, 0);
    //image(dof.getSrc(), width / 2, 0);
  }

  private void drawGeometry(PGraphics pg, boolean lights) {
    pg.beginDraw();
    pg.background(0);
    if (lights) {
      pg.directionalLight(255, 100, 50, 1, 0, 0);
      pg.directionalLight(50, 100, 255, -1, 0, 0);
    }
    for (int i = 0; i < 20; i++) {
      pg.pushMatrix();
      pg.translate((i*7763)%width, (i*777)%height, 30*i*sin(i+millis()*0.0001)-500);
      pg.shape(shp);
      pg.popMatrix();
    }
    pg.endDraw();
  }
  
  void keyPressed(){
   renderDepth = !renderDepth; 
  }
