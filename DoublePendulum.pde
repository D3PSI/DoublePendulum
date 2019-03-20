Pendulum p1;
Pendulum p2;

float iterationCount = 0;

float g = 0.981;

int p1_length = 2 * width;
int p2_length = 2 * width;

float p1_theta = PI / 4;
float p2_theta = PI / 4;

float p1_vel = 0.001;
float p2_vel = 0.1;

float p1_acc = 0;
float p2_acc = 0;

PVector p1_origin = new PVector(0, 0);
PVector p1_pos = new PVector(p1_length * cos(p1_theta), p1_length * sin(p1_theta));

PVector p2_origin = p1_pos;
PVector p2_pos = new PVector(p2_length * cos(p2_theta), p2_length * sin(p2_theta));

int p1_m = 20;
int p2_m = 20;

float delta_p1_vel = -0.000001;
float delta_p2_vel = -0.000001;

ArrayList< PVector > path = new ArrayList< PVector >();

void setup() {

  size(1000, 1000);
  
  translate(width / 2, height / 2);
  rotate(PI / 2);
  p1 = new Pendulum(p1_origin, p1_pos);
  p2 = new Pendulum(p2_origin, p2_pos);

}

void draw() {

  translate(width / 2, height / 2);
  rotate(PI / 2);
  background(255);
  
  p1_acc = ((-g * (2 * p1_m + p2_m) * sin(p1_theta)) - (p2_m * g * sin(p1_theta - 2 * p2_theta)) - (2 * sin(p1_theta - p2_theta) * p2_m * (p2_vel * p2_vel * p2_length + p1_vel * p1_vel * p1_length * cos(p1_theta - p2_theta)))) / (p1_length * (2 * p1_m + p2_m - p2_m * cos(2 * p1_theta - 2 * p2_theta)));
  
  p2_acc = ((2 * sin(p1_theta - p2_theta) * (p1_vel * p1_vel * p1_length * (p1_m + p2_m) + g * (p1_m + p2_m) * cos(p1_theta) + (p2_vel * p2_vel * p2_length * p2_m * cos(p1_theta - p2_theta))))) / (p2_length * (2 * p1_m + p2_m - p2_m * cos(2 * p1_theta - 2 * p2_theta)));
  
  p1_origin = new PVector(0, 0);
  p1_pos = new PVector(p1_length * cos(p1_theta), p1_length * sin(p1_theta));

  p2_origin = p1_pos;
  p2_pos = new PVector(p2_length * cos(p2_theta), p2_length * sin(p2_theta));
  
  p1.update(p1_origin, p1_pos);
  p2.update(p2_origin, p2_pos);
  p1.display(p1_m);
  p2.display(p2_m);
  
  p1_vel += p1_acc;
  p2_vel += p2_acc;
  
  p1_theta += p1_vel;
  p2_theta += p2_vel;
  
  PVector pathVec = new PVector(p2.pos.x + p1.pos.x, p2.pos.y + p1.pos.y);
  
  path.add(pathVec);
  for(int i = 0; i < path.size(); i++) {
  
    PVector vec = path.get(i);
    
    if(i + 1 < path.size()) {
    
      PVector next = path.get(i + 1);
      stroke(0, 100);
      line(vec.x, vec.y, next.x, next.y);
    
    }
  
  }
  if(path.size() > 10000) {
  
    path.remove(0);
  
  }

  iterationCount++;
  p1_vel += delta_p1_vel;
  p2_vel += delta_p2_vel;

}
