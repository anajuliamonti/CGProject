public class Intersection {
    boolean hit;
    float distance;
    int index;

    public Intersection() {
      hit = false;
      distance = INFINITY;
      index = -1;
    }

    public Intersection(boolean hit, float distance, int index) {
        this.hit = hit;
        this.distance = distance;
        this.index = index;
    }
}
