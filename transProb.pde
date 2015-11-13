double transProb(int[] form1, int[] form2) {

  double prob;

  if (form1[2] == -1 || form2[2] == -1) {
    // 片方のフォームでも開放弦ならば1.0
    prob = 1.0;
  } else {
    // 両方のフォームが開放弦でない場合
    int i1 = form1[1] - form1[2];
    int i2 = form2[1] - form2[2];
    prob = 1.0 / (abs(i1 - i2) + 1);
  }

  if (form1[0] != form2[0]) {
    prob = prob / PENALTY;
  }

  return prob;
}

