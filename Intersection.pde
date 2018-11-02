public class Intersection {
    boolean hit = false;
    float distance = INFINITY;
    int index = -1;

    public Intersection() {
    }

    public Intersection(boolean hit, float distance, int index) {
        this.hit = hit;
        this.distance = distance;
        this.index = index;
    }
}
