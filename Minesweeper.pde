import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
public final static int NUM_MINES = 50;
private MSButton[][] buttons; //2d array of minesweeper buttons
boolean lose = false;
int tileCount = 0;
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(600, 600);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
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
  while(mines.size() < NUM_MINES)
  {
    int r = (int)(Math.random() * NUM_ROWS);
    int c = (int)(Math.random() * NUM_COLS);
    if(!mines.contains(buttons[r][c])){
    mines.add(buttons[r][c]);
  }
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
public boolean isWon(){return false;}
public void displayLosingMessage()
{  
    for(int i=0;i<mines.size();i++)
        if(mines.get(i).isFlagged()==false)
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

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean flagged, marked;
    private String label;
    
    public MSButton ( int row, int col )
    {
         width = 600/NUM_COLS;
         height = 600/NUM_ROWS;
        r = row;
        c = col; 
        x = c*width;
        y = r*height;
        label = "";
        marked = flagged = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
    // called by manager
    
    public void mousePressed () 
    {
         if (lose == false) {
        if (mouseButton == RIGHT && buttons[r][c].isFlagged()) {}
        else if (mouseButton == RIGHT) {marked = !marked;}
        else if (marked == true) {}
        else if (mines.contains(this)) {
          flagged = true;
          displayLosingMessage();
        }
        else if (countmines(r,c) > 0) {
          label = ""+countmines(r,c);
          if (!flagged) {tileCount+=1;}
          if (tileCount == 600-mines.size()) {displayWinningMessage();}
          flagged = true;
        }
        else {

          
          if (!flagged) {tileCount+=1;}
          if (tileCount == 600-mines.size()) {displayWinningMessage();}
          flagged = true;
          
          if(isValid(r-1,c-1) && !buttons[r-1][c-1].isFlagged()) {
          buttons[r-1][c-1].mousePressed();} 
          if(isValid(r-1,c) && !buttons[r-1][c].isFlagged()) {
          buttons[r-1][c].mousePressed();}
          if(isValid(r-1,c+1) && !buttons[r-1][c+1].isFlagged()){
          buttons[r-1][c+1].mousePressed();}
          
          if(isValid(r,c-1) && !buttons[r][c-1].isFlagged()){
          buttons[r][c-1].mousePressed();}
          if(isValid(r,c+1) && !buttons[r][c+1].isFlagged()){
          buttons[r][c+1].mousePressed();}
          
          if(isValid(r+1,c-1) && !buttons[r+1][c-1].isFlagged()){
          buttons[r+1][c-1].mousePressed();}
          if(isValid(r+1,c) && !buttons[r+1][c].isFlagged()){
          buttons[r+1][c].mousePressed();}
          if(isValid(r+1,c+1) && !buttons[r+1][c+1].isFlagged()){
          buttons[r+1][c+1].mousePressed();}
        }
      }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
         
         else if( !marked && flagged && mines.contains(this) ) 
             fill(255,0,0);
         else if( marked && mines.contains(this) ) 
             fill(100);
         else if( !marked && flagged && !mines.contains(this) ) 
             fill(200);
             
        else if(flagged)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
      if(r < 20 && r >= 0)
        if(c < 20 && c >= 0)
            return true;
        return false;
    }
    public int countmines(int row, int col)
    {
        int nummines = 0;
        if (isValid(row-1,col) == true && mines.contains(buttons[row-1][col]))
        {
            nummines++;
        }
        if (isValid(row+1,col) == true && mines.contains(buttons[row+1][col]))
        {
            nummines++;
        }
         if (isValid(row,col-1) == true && mines.contains(buttons[row][col-1]))
        {
            nummines++;
        }
         if (isValid(row,col+1) == true && mines.contains(buttons[row][col+1]))
        {
            nummines++;
        }
         if (isValid(row-1,col+1) == true && mines.contains(buttons[row-1][col+1]))
        {
            nummines++;
        }
         if (isValid(row-1,col-1) == true && mines.contains(buttons[row-1][col-1]))
        {
            nummines++;
        }
         if (isValid(row+1,col+1) == true && mines.contains(buttons[row+1][col+1]))
        {
            nummines++;
        }
         if (isValid(row+1,col-1) == true && mines.contains(buttons[row+1][col-1]))
        {
            nummines++;
        }
        return nummines;
    }
}