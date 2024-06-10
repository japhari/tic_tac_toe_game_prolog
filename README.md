### How to Run

1. **Save the Corrected Code**:

   - Save the corrected code in a file named `tic_tac_toe.pl`.

2. **Start SWI-Prolog**:

   - Open your terminal or command prompt.
   - Navigate to the directory where you saved `tic_tac_toe.pl`.
   - Start SWI-Prolog by typing `swipl`.

3. **Load the Program**:

   - In the SWI-Prolog prompt, load the Tic-Tac-Toe program by typing:
     ```prolog
     ?- [tic_tac_toe].
     ```

4. **Start the Game**:

   - Start the game by typing:
     ```prolog
     ?- play.
     ```

5. **Play the Game**:
   - The game will prompt you to enter a move. Enter the position number (1-9) for your move.
   - The computer will respond with its move.
   - The game continues until there is a win or a draw.

### Example Game Session

Here’s an example of how a game session might look in SWI-Prolog:

```prolog
?- [tic_tac_toe].
% tictak compiled 0.00 sec, 6 clauses

?- play.
   _   _   _
   _   _   _
   _   _   _

Please enter a move (1-9): 1.
 o    _   _
   _   x   _
   _   _   _

Please enter a move (1-9): 2.
 o  o    _
   _   x   _
   _   _   _

Please enter a move (1-9): 3.
 o  o  o
   _   x   _
   _   _   _
You won.
true.
```
