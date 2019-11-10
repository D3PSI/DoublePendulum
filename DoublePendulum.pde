Pendulum p1;
Pendulum p2;

float iterationCount = 0;

float g = 0.981;

int p1_length = 200;
int p2_length = 200;

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

int p1_mass = 20;
int p2_mass = 20;

float etot = 0;

ArrayList< PVector > path = new ArrayList< PVector >();

void setup() {

  size(1000, 1000);
  
  translate(width / 2, height / 2);
  rotate(PI / 2);
  frameRate(60);
  p1 = new Pendulum(p1_origin, p1_pos);
  p2 = new Pendulum(p2_origin, p2_pos);

}

void draw() {

  translate(width / 2, height / 2);
  rotate(PI / 2);
  background(255);
  
  p1_acc = ((-g * (2 * p1_mass + p2_mass) * sin(p1_theta)) - (p2_mass * g * sin(p1_theta - 2 * p2_theta)) - (2 * sin(p1_theta - p2_theta) * p2_mass * (p2_vel * p2_vel * p2_length + p1_vel * p1_vel * p1_length * cos(p1_theta - p2_theta)))) / (p1_length * (2 * p1_mass + p2_mass - p2_mass * cos(2 * p1_theta - 2 * p2_theta)));
  
  p2_acc = ((2 * sin(p1_theta - p2_theta) * (p1_vel * p1_vel * p1_length * (p1_mass + p2_mass) + g * (p1_mass + p2_mass) * cos(p1_theta) + (p2_vel * p2_vel * p2_length * p2_mass * cos(p1_theta - p2_theta))))) / (p2_length * (2 * p1_mass + p2_mass - p2_mass * cos(2 * p1_theta - 2 * p2_theta)));
  
  p1_origin = new PVector(0, 0);
  p1_pos = new PVector(p1_length * cos(p1_theta), p1_length * sin(p1_theta));

  p2_origin = p1_pos;
  p2_pos = new PVector(p2_length * cos(p2_theta), p2_length * sin(p2_theta));
  
  etot = 0.5f * p1_mass * p1_vel * p1_vel * p1_length * p1_length + 0.5f * p2_mass *
            (p1_vel * p1_vel * p1_length * p1_length + p2_vel * p2_vel * p2_length * p2_length +
            2.0f * p1_length * p2_length * p1_vel * p2_vel * cos(p1_theta - p2_theta)) - (p1_mass + p2_mass) * g * p1_length * cos(p1_theta)-p2_mass * g * p2_length * cos(p2_theta);
  
  println(etot);
  
  p1.update(p1_origin, p1_pos);
  p2.update(p2_origin, p2_pos);
  p1.display(p1_mass);
  p2.display(p2_mass);
  
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

}
