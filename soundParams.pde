import ddf.minim.*;

Minim minim;
AudioPlayer HitSound;

void loadSounds() {
  minim = new Minim(this);
  HitSound = minim.loadFile("Hit.wav");
}
