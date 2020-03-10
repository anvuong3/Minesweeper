import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
public final static int NUM_MINES = 50;
private int tileCount = 0;
private boolean lose = false;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r++){
        for(int c = 0; c < NUM_COLS; c++){
            buttons[r][c] = new MSButton(r,c);
        }
    }
    
    
    setMines();
}
public void setMines()
{
    //your code
    while(mines.size() < NUM_MINES){
        int r = (int)random(0,NUM_ROWS);
        int c = (int)random(0,NUM_COLS);
        if(mines.contains(buttons[r][c]))
            mines.add(buttons[r][c]);
    }
    
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
    for (int i = 0; i < NUM_ROWS; i++) {
    for (int j = 0; j < NUM_COLS; j++) {
        buttons[i][j].draw();
      }
    }

}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
    for(int i=0;i<mines.size();i++)
        if(mines.get(i).isClicked()==false)
            mines.get(i).mousePressed();
    lose = true;
    buttons[NUM_ROWS/2][(NUM_COLS/2)-4].setLabel("Y");
    buttons[NUM_ROWS/2][(NUM_COLS/2)-3].setLabel("O");
    buttons[NUM_ROWS/2][(NUM_COLS/2-2)].setLabel("U");
    buttons[NUM_ROWS/2][(NUM_COLS/2-1)].setLabel("");
    buttons[NUM_ROWS/2][(NUM_COLS/2)].setLabel("L");
    buttons[NUM_ROWS/2][(NUM_COLS/2+1)].setLabel("O");
    buttons[NUM_ROWS/2][(NUM_COLS/2+2)].setLabel("S");
    buttons[NUM_ROWS/2][(NUM_COLS/2+3)].setLabel("E");

}
public void displayWinningMessage()
{
    //your code here
    lose = true;
    buttons[NUM_ROWS/2][(NUM_COLS/2)-4].setLabel("Y");
    buttons[NUM_ROWS/2][(NUM_COLS/2)-3].setLabel("O");
    buttons[NUM_ROWS/2][(NUM_COLS/2-2)].setLabel("U");
    buttons[NUM_ROWS/2][(NUM_COLS/2-1)].setLabel("");
    buttons[NUM_ROWS/2][(NUM_COLS/2)].setLabel("W");
    buttons[NUM_ROWS/2][(NUM_COLS/2+1)].setLabel("I");
    buttons[NUM_ROWS/2][(NUM_COLS/2+2)].setLabel("N");
    buttons[NUM_ROWS/2][(NUM_COLS/2+3)].setLabel("!");
}
public boolean isValid(int r, int c)
{
      if(r < 0 || r >= NUM_ROWS){
        return false;
      }
      if(c < 0 || c >= NUM_COLS){
        return false;
      }
      return true;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    //your code here
    for(int i = row - 1; i <= row+1; i++){
    for(int j = col - 1; j <= col+1; j++){
      if(isValid(i,j) == true && mines.contains(buttons[i][j])){
        numMines++;
      }
    }
  }
  if(mines.contains(buttons[row][col])){
    numMines--;
  }
      return numMines;
}
public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = row;
        c = col; 
        x = c*width;
        y = r*height;
        myLabel = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    public void mousePressed () 
    {
        if (lose == false) {
        if (mouseButton == RIGHT && buttons[r][c].isClicked()) {}
        else if (mouseButton == RIGHT) {marked = !marked;}
        else if (marked == true) {}
        else if (mines.contains(this)) {
          clicked = true;
          displayLosingMessage();
        }
        else if (countMines(r,c) > 0) {
          myLabel = ""+countMines(r,c);
          if (!clicked) {tileCount+=1;}
          if (tileCount == 400-mines.size()) {displayWinningMessage();}
            clicked = true;
        }
        else {

          
          if (!clicked) {tileCount+=1;}
          if (tileCount == 400-mines.size()) {displayWinningMessage();}
          clicked = true;
          
            if(isValid(r-1,c-1) && !buttons[r-1][c-1].isClicked()) {
          buttons[r-1][c-1].mousePressed();} 
          if(isValid(r-1,c) && !buttons[r-1][c].isClicked()) {
          buttons[r-1][c].mousePressed();}
          if(isValid(r-1,c+1) && !buttons[r-1][c+1].isClicked()){
          buttons[r-1][c+1].mousePressed();}
          
          if(isValid(r,c-1) && !buttons[r][c-1].isClicked()){
          buttons[r][c-1].mousePressed();}
          if(isValid(r,c+1) && !buttons[r][c+1].isClicked()){
          buttons[r][c+1].mousePressed();}
          
          if(isValid(r+1,c-1) && !buttons[r+1][c-1].isClicked()){
          buttons[r+1][c-1].mousePressed();}
          if(isValid(r+1,c) && !buttons[r+1][c].isClicked()){
          buttons[r+1][c].mousePressed();}
          if(isValid(r+1,c+1) && !buttons[r+1][c+1].isClicked()){
          buttons[r+1][c+1].mousePressed();}
        }
    
    }
}
    public void draw () 
    {    
        if (marked)
            fill(0);
         
         else if( !marked && clicked && mines.contains(this) ) 
             fill(255,0,0);
         else if( marked && mines.contains(this) ) 
             fill(100);
         else if( !marked && clicked && !mines.contains(this) ) 
             fill(200);
             
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isMarked()
    {
        return marked;
    }
}
