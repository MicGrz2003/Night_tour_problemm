int n = 4; 
range rows = 1..n;
range cols = 1..n;
range steps = 0..(n*n)-1; 

int di[1..8] = [2, 1, -1, -2, -2, -1, 1, 2];
int dj[1..8] = [1, 2, 2, 1, -1, -2, -2, -1];

int S[rows][cols] = [
  [0, 0, 0, 0],
  [0, 1, 0, 1],
  [0, 0, 1, 0],
  [0, 0, 1, 0]
];

dvar boolean x[rows][cols][steps];

minimize sum(k in steps, i in rows, j in cols) x[i][j][k]*k;

subject to {
  //inicjalizacja pozycji konia
  x[1][4][0] == 1;

  //na planszy jest nie wiecej niz jeden kon za kazdym ruchem
  forall(k in steps) {
    sum(i in rows, j in cols) x[i][j][k] <= 1;
  }

  //kon musi zbic wszystkie pionki
  forall(i in rows, j in cols) {
    sum(k in steps) x[i][j][k] >= S[i][j];
  }

  //ruch konia zgodnie z dozwolonymi
  forall(k in 0..(n*n)-2) {
    forall(i in rows, j in cols) {
      sum(m in 1..8: i + di[m] in rows && j + dj[m] in cols)
        x[i + di[m]][j + dj[m]][k] >= x[i][j][k+1];
    } 
}  
}
 