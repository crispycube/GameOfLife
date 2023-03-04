import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private Life[][] buttons; //2d array of Life buttons each representing one cell
private boolean[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = false; //used to start and stop program

public void setup () {
  size(400, 400);
  frameRate(6);
  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  buttons = new Life[NUM_ROWS][NUM_COLS];
  for(int i = 0; i < NUM_ROWS; i++){
    for(int j = 0; j < NUM_COLS; j++){
      buttons[i][j] = new Life(i, j);
    }
  }
  //your code to initialize buffer goes here
  buffer = new boolean[NUM_ROWS][NUM_COLS];
}

public void draw () {
  background( 0 );
  if (running == false) //pause the program
    return;
  copyFromBufferToButtons();

  //use nested loops to draw the buttons here
  for(int i = 0; i < buttons.length; i++){
    for(int j = 0; j < buttons[i].length; j++){
      if(countNeighbors(i, j) == 3){
        buffer[i][j] = true;
      } else if(countNeighbors(i, j) == 2 && buttons[i][j].getLife()){
        buffer[i][j] = true;
      } else { 
        buffer[i][j] = false;
      }
      buttons[i][j].draw();
    }
  }
  copyFromButtonsToBuffer();
}

public void keyPressed() {
  //your code here
  running = !running;
}

public void copyFromBufferToButtons() {
  //your code here
  for(int i = 0; i < NUM_ROWS; i++){
    for(int j = 0; j < NUM_COLS; j++){
      buffer[i][j] = buttons[i][j].getLife();
    }
  }
}

public void copyFromButtonsToBuffer() {
  //your code here
  for(int i = 0; i < NUM_ROWS; i++){
    for(int j = 0; j < NUM_COLS; j++){
      buttons[i][j].setLife(buffer[i][j]);
    }
  }
}

public boolean isValid(int r, int c) {
  //your code here
  if(r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS){
    return true;
  }
  return false;
}

public int countNeighbors(int row, int col) {
  int neighbors = 0;
  //your code here
  for(int i = -1; i <= 1; i++){
    for(int j = -1; j <= 1; j++){
      if(isValid(row+i, col+j) && buttons[row+i][col+j].getLife()){
        neighbors++;
      }
    }
  }
  if(buttons[row][col].getLife()){
    neighbors--;
  }
  return neighbors;
}

public class Life {
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean alive;

  public Life (int row, int col) {
     width = 400/NUM_COLS;
     height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    alive = Math.random() < .5; // 50/50 chance cell will be alive
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () {
    alive = !alive; //turn cell on and off with mouse press
  }
  public void draw () {    
    if (alive != true)
      fill(0);
    else 
      fill( 150 );
    rect(x, y, width, height);
  }
  public boolean getLife() {
    //replace the code one line below with your code
    return alive;
  }
  public void setLife(boolean living) {
    //your code here
    alive = living;
  }
}
