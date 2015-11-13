// final double PENALTY = 10.0;
final double PENALTY = 1.0;

final int MAX_SONG_LENGTH = 20;
final int MAX_NUM_FORMS = 24;
final int NUM_FORM_ELEMENTS = 3;
final int NUM_FINGERS = 4;
final int NUM_STRINGS = 6;
final int NUM_FRETS = 19;

int[] song = { 48, 50, 52, 53, 55, 57, 59, 60 }; // ドレミファソラシド
// int[] song = { 47, 48, 50, 52, 53, 55 }; // シドレミファソ
int[] open_strings = { 64, 59, 55, 50, 45, 40 };

void setup(){  
  int[][][] forms = new int[MAX_SONG_LENGTH][MAX_NUM_FORMS][NUM_FORM_ELEMENTS];
  int[] num_forms = new int[MAX_SONG_LENGTH];

  for(int t = 0; t < song.length; t++){
    num_forms[t] = 0;
    for(int str = 0; str < NUM_STRINGS; str++){
      int fret = song[t] - open_strings[str];
      if(fret == 0){ // 開放弦の場合
        forms[t][num_forms[t]][0] = str;
        forms[t][num_forms[t]][1] = fret;
        forms[t][num_forms[t]][2] = -1; // 開放弦の指番号は-1
        num_forms[t]++;
      } else if(fret > 0 && fret <= NUM_FRETS){ // 開放弦以外の場合
        for(int finger = 0; finger < NUM_FINGERS; finger++){
          forms[t][num_forms[t]][0] = str;
          forms[t][num_forms[t]][1] = fret;
          forms[t][num_forms[t]][2] = finger;
          num_forms[t]++;
        }
      }
    }
  }
/*
  for(int t = 0; t < song.length; t++){
    for(int i = 0; i < num_forms[t]; i++){
      println(forms[t][i][0] + " - " + forms[t][i][1] + " - " + forms[t][i][2]);
    }
    println("");
  }
*/

  double[] prevState = new double[MAX_NUM_FORMS];
  double[] currState = new double[MAX_NUM_FORMS];
  int[][] back = new int[MAX_SONG_LENGTH][MAX_NUM_FORMS]; // back[0][*]は未使用
  double prob = 0.0;
  double max = 0.0;
  int imax = 0;

  for(int i = 0; i < num_forms[0]; i++){
    prevState[i] = 1.0;
  }

  for(int t = 1; t < song.length; t++){
    for(int j = 0; j < num_forms[t]; j++){
      max = 0.0;
      imax = 0;
      for(int i = 0; i < num_forms[t-1]; i++){
        //prob = 今までの確率の積 * 遷移確率
        prob = prevState[i] * transProb(forms[t-1][i], forms[t][j]);
        if(prob > max){
          max = prob;
          imax = i;
        }
      }
      currState[j] = max;
      back[t][j] = imax;
    }
    for(int i = 0; i < num_forms[t]; i++){
      prevState[i] = currState[i];
    }
  }

  //最適経路算出
  int[] best_path = new int[MAX_SONG_LENGTH];
  max = 0.0;
  imax = -1;
  for(int i = 0; i < num_forms[song.length-1]; i++){
    if(currState[i] > max){
      imax = i;
      max = currState[i];
    }
  }
  best_path[song.length-1] = imax;
  for(int t = song.length-1; t > 0; t--){
    imax = back[t][imax];
    best_path[t-1] = imax;
  }

  //最適経路表示
  size(800, 300);
  Tab tab = new Tab();
  tab.setup();
  int[] form = new int[3];
  for(int t = 0; t < song.length; t++){
    form = forms[t][best_path[t]];
    tab.push(form);
    print((t+1) + "番目 ");
    if(form[2] == -1){
      println((form[0]+1)+"弦開放弦");
    } else {
      println((form[0]+1)+"弦" + form[1]+"フレット" + (form[2]+1)+"の指");
    }
  }

}