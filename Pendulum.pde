public class Pendulum {

  PVector origin;
  PVector pos;
  
  Pendulum(PVector origin_, PVector pos_) {
  
    origin = origin_;
    pos = pos_;
  
  }
  
  public void update(PVector origin_, PVector pos_) {
  
    origin = origin_;
    pos = pos_;
  
  }
  
  public void display(int m_) {
    
    translate(origin.x, origin.y);
    stroke(0);
    strokeWeight(3);
    line(0, 0, pos.x, pos.y);
    fill(0);
    ellipse(pos.x, pos.y, m_, m_);
    strokeWeight(1);
    translate(-origin.x, -origin.y);
  
  }

}
