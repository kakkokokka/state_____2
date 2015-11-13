final float TAB_TOP = 100;
final float TAB_LEFT = 80;
final float TAB_LENGTH = 640;
final float STRING_SPACE = 20;
final float TIME_SPACE = 60;
final float FINGERING_SPACE = 140;
final int NUM_STRING = 6;
final color COLOR_WHITE = color(255, 255, 255);
final color COLOR_BLACK = color(0, 0, 0);
final String FONT_NAME = "Serif";
final int FONT_SIZE_SMALL = 24;
final int FONT_SIZE_LARGE = 48;

class Tab {

  int time = 0;
  
  void setup(){
    smooth();
    background(COLOR_WHITE);
    for (int s = 0; s < NUM_STRING; s++) {
      line(TAB_LEFT, TAB_TOP + STRING_SPACE * s,
           TAB_LEFT + TAB_LENGTH, TAB_TOP + STRING_SPACE * s);
    }
    fill(COLOR_BLACK);
    PFont font = createFont(FONT_NAME, FONT_SIZE_SMALL);
    textFont(font);
    textAlign(CENTER, CENTER);
    textSize(FONT_SIZE_LARGE);
    text("T", TAB_LEFT + 16, TAB_TOP + 16);
    text("A", TAB_LEFT + 16, TAB_TOP + 50);
    text("B", TAB_LEFT + 16, TAB_TOP + 84);
  }

  void push(int[] form){
    textSize(FONT_SIZE_SMALL);
    text(form[1], TAB_LEFT + TIME_SPACE * (time + 1),
         TAB_TOP + STRING_SPACE * form[0]);
    text("(" + (form[2] + 1) + ")",
         TAB_LEFT + TIME_SPACE * (time + 1), TAB_TOP + FINGERING_SPACE);
    time++;
  }

}

