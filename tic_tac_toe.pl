% Definitions for ordered lines (rows, columns, diagonals)
ordered_line(1, 2, 3).  % Top row
ordered_line(4, 5, 6).  % Middle row
ordered_line(7, 8, 9).  % Bottom row
ordered_line(1, 4, 7).  % Left column
ordered_line(2, 5, 8).  % Middle column
ordered_line(3, 6, 9).  % Right column
ordered_line(1, 5, 9).  % Main diagonal
ordered_line(3, 5, 7).  % Anti-diagonal

% Line permutations derived from ordered lines
line(A, B, C) :- ordered_line(A, B, C).
line(A, B, C) :- ordered_line(A, C, B).
line(A, B, C) :- ordered_line(B, A, C).
line(A, B, C) :- ordered_line(B, C, A).
line(A, B, C) :- ordered_line(C, A, B).
line(A, B, C) :- ordered_line(C, B, A).

% Definitions for board states
full(A) :- x(A).           % A position is full if X occupies it
full(A) :- o(A).           % A position is full if O occupies it
empty(A) :- \+(full(A)).   % A position is empty if it's not full
same(A, A).                % Two positions are the same if they are equal
different(A, B) :- \+(same(A, B)). % Two positions are different if they are not the same

% Move selection based on strategy
move(A) :- good(A), empty(A), !.

% Definitions for good moves
good(A) :- win(A).              % A move is good if it leads to a win
good(A) :- block_win(A).        % A move is good if it blocks an opponent's win
good(A) :- strong_build(A).     % A move is good if it builds a strong position
good(A) :- weak_build(A).       % A move is good if it builds a weak position
good(5). good(1). good(3). good(7). good(9). good(2). good(4). good(6). good(8). % Preferred positions

% Win and block win conditions
win(A) :- x(B), x(C), line(A, B, C).
block_win(A) :- o(B), o(C), line(A, B, C).

% Building strategies
split(A) :- x(B), x(C), different(B, C), line(A, B, D), line(A, C, E), empty(D), empty(E).
strong_build(A) :- x(B), line(A, B, C), empty(C), \+(risky(C)).
weak_build(A) :- x(B), line(A, B, C), empty(C), \+(double_risky(C)).
risky(C) :- o(D), line(C, D, E), empty(E).
double_risky(C) :- o(D), o(E), different(D, E), line(C, D, F), line(C, E, G), empty(F), empty(G).

% End game conditions
all_full :- full(1), full(2), full(3), full(4), full(5), full(6), full(7), full(8), full(9).
done :- ordered_line(A, B, C), x(A), x(B), x(C), printboard, write('I won.'), nl, !.
done :- ordered_line(A, B, C), o(A), o(B), o(C), printboard, write('You won.'), nl, !.
done :- all_full, printboard, write('Draw.'), nl, !.

% User move and computer move handling
getmove :-
    repeat,
    write('Please enter a move (1-9): '),
    read(X),
    integer(X),
    X >= 1,
    X =< 9,
    empty(X), !,
    assert(o(X)).
getmove :-
    write('Invalid move. Please try again.'), nl,
    getmove.

makemove :- move(X), !, assert(x(X)).
makemove :- all_full.

% Printing the board
printsquare(N) :- o(N), write(' o ').
printsquare(N) :- x(N), write(' x ').
printsquare(N) :- empty(N), write('   ').
printboard :- printsquare(1), printsquare(2), printsquare(3), nl,
              printsquare(4), printsquare(5), printsquare(6), nl,
              printsquare(7), printsquare(8), printsquare(9), nl.

% Clearing the board
clear :- retractall(x(_)), retractall(o(_)).

% Main game loop
play :- clear, repeat, printboard, getmove, respond.
respond :- done.
respond :- makemove, printboard, done.
