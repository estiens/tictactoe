tictactoe
=========

Tic-Tac-Toe console game with an unbeatable AI

*TO PLAY*

`rake` or `rake play_game`

*TEST COVERAGE*

* Test coverage of board and player logic is nearly 100%

* Test coverage is not included for view-based logic (puts statments and gets statements)

*LIMITATIONS*

* Hard AI makes use of some hard-coded logic specific to a 3x3 board. Thus it will not be completely unbeatable on a larger board, but is unbeatable in standard tic-tac-toe

*SIMULATION RESULTS*

All simulations include 20k iterations


| Player 1       | Player 2          | Player 1 Win  | Player 2 Win | Tie |
| ------------- |:-------------:| -----:|--:|--:|--:|
| HardAi     | HardAi | 0% | 0% | 100% |
| HardAi     | MediumAi|9.9%|0%|90.1%
| MediumAi | HardAi| 0 | 5.4% | 94.6%
| HardAi | EasyAi | 97.5% | 0% | 2.5%
| EasyAi | HardAi | 85.1% | 0% | 14.9%
| MediumAi | MediumAi | 13.2% | 10.8% | 17593
| MediumAi | EasyAi |
| EasyAi   | MediumAi|
|EasyAi | Easy Ai| 5732 | 11773 | 2495

