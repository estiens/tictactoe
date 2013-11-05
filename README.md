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
| MediumAi | HardAi| 0% | 5.4% | 94.6%
| HardAi | EasyAi | 97.5% | 0% | 2.5%
| EasyAi | HardAi | 0% | 85.1% | 14.9%
| MediumAi | MediumAi | 6.4% | 5.0% | 88.6%
| MediumAi | EasyAi | 96% | 3.8 % | .2% |
| EasyAi   | MediumAi| 1.6% | 84.2% | 14.2% |
|EasyAi | Easy Ai| 58.6% | 28.8% | 12.6% |

