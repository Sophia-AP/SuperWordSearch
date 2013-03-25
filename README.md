Introduction
In a typical word search puzzle (http://en.wikipedia.org/wiki/Word_search), you are given an NxM grid of seemingly random letters and a list of P words that are in the grid. The words can be found going in any of the 8 directions in a two dimensional grid:
●  top to bottom
●	bottom to top
●	left to right
●	right to left
●	bottom left to top right
●	bottom right to top left
●	top left to bottom right
●	top right to bottom left

You're a college professor (for English and Topology, of all things), and your students have become very good at traditional Word Search. Since you want them to continue spending time on academic games, you created a variant of Word Search (inventively) called Super Word Search.
The rules of the game
As with a standard word search, you get an NxM grid of letters, and P words that are to be found in the grid. You also get a "mode" flag with one of the following values: WRAP, NO_WRAP. The flag value indicates whether words can wrap-around after they hit a boundary of the grid.

Row numbers start at 0 (top row) and go to N-1 (bottom row). Column numbers start at 0 (leftmost column) and go to M-1 (rightmost column). Grid coordinates are specified as (row_num, column_num).
Here is an example to illustrate the difference between WRAP and NO_WRAP:

  012
  ---
0|ABC
1|DEF
2|GHI

If we are in WRAP mode:
●	"FED" is a word that starts at (1,2) and ends at (1,0).
●	"CAB" is a word that starts at (0,2) and ends at (0,1).
●	"GAD" is a word that starts at (2,0) and ends at (1,0).
●	"BID" is a word that starts at (0,1) and ends at (1,0).

If we are in NO_WRAP mode:
●	"FED" is a word that starts at (1,2) and ends at (1,0).
●	"CAB" is not a word since it requires wrapping in the horizontal direction.
●	"GAD" is not a word since it requires wrapping in the vertical direction.
●	"BID" is not a word since it requires wrapping in the horizontal and vertical directions.

A letter in the grid is not allowed to be in a word more than once. So, while technically "HIGH" can be found in the above grid in WRAP mode, we will not allow it because it uses the H at (2,1) twice.
Input Format
N M
N rows of M letters
"WRAP" or "NO_WRAP"
P
P words with 1 word per lines

Your program should accept the name of an input file which will contain data in the above format.
Output Format
For each of the P words, you are to output the start and end coordinates of that word in the format "(row_start, column_start) (row_end, column_end)". If the word cannot be found in the grid, output "NOT FOUND".

You are guaranteed that each word will occur at most once in the grid, so a word's start and end coordinates will always be unique (if the word is in the grid), and will never be ambiguous.
Your program can write its output to the screen/console.
Examples
Input
3 3
ABC
DEF
GHI
NO_WRAP
5
FED
CAB
GAD
BID
HIGH
Output
(1,2) (1,0)
NOT FOUND
NOT FOUND
NOT FOUND
NOT FOUND
Input
3 3
ABC
DEF
GHI
WRAP
5
FED
CAB
GAD
BID
HIGH
Output
(1,2) (1,0)
(0,2) (0,1)
(2,0) (1,0)
(0,1) (1,0)
NOT FOUND

Scoring
You will be graded on code correctness, the design of your data structures and algorithms, and code quality/readability.

