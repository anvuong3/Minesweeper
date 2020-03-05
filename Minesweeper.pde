import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
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
    int r = (int)random(0,NUM_ROWS);
    int c = (int)random(0,NUM_COLS);
    if(mines.contains(buttons[r][c]))
        setMines(); 
    else 
        mines.add(buttons[r][c]);
    
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();

}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here

}
public void displayWinningMessage()
{
    //your code here
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
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if(mouseButton == LEFT && !flagged)
            clicked = true;

        if(mouseButton == RIGHT && !clicked)
            flagged = !flagged;
        else if(!flagged && mines.contains(this))
        {
            displayLosingMessage();
            noLoop();
        }
        else if(clicked && countMines(myRow, myCol) > 0)
           setLabel(countMines(myRow, myCol));
        else
        {
            if(!flagged)
                for(int r = myRow - 1; r < myRow + 2; r++)
                    for(int c = myCol - 1; c < myCol + 2; c++)
                        if(isValid(r, c) && !buttons[r][c].isFlagged())
                            buttons[r][c].mousePressed();
        }
    
}
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
            fill(255,0,0);
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
    public boolean isFlagged()
    {
        return flagged;
    }
}
