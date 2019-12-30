# BlackJack - console game

**Mechanics and rules of the game:**

There is a player (user) and a dealer (controlled by the program).
At the beginning, the user is asked for a name, after which the game begins.
At the beginning of the game, the user and the dealer have $ 100 in the bank.
The user is given random 2 cards that he sees.
Also 2 random cards are issued to the "dealer", against which the user is playing. The user does not see the dealer’s cards, instead of them asterisks are displayed.
The user sees the sum of his points. The amount is considered as follows: from 2 to 10 - according to the face value of the card, all “pictures” - by 10, ace - 1 or 11, depending on which value is closer to 21 and that does not lead to loss (amount more than 21) .
After the distribution, a bet is automatically placed in the game bank in the amount of $ 10 from the player and dealer. (The player and dealer deduct 10 from the bank)
After that, the move goes to the user. The user has a choice of 3 options:
- __*Skip.*__ In this case, the move goes to the dealer (see below)
- __*Add a card.*__ (only if the user has 2 cards on hand). In this case, the player is added another random card, the amount of points is recalculated, the move goes to the dealer. Only one card can be added.
- __*Open cards.*__ The dealer and player cards are opened, the player sees the amount of dealer points, and the results of the game are being calculated (see below).
- Dealer move (controlled by the program, the goal is to win, that is, to collect the amount with a point as close as possible to 21). The dealer can:
- __*Skip.*__ (if the dealer has 17 or more points). The move goes to the player.
- __Add a card.*__ (if there are less than 17 points). The dealer has a new card (closed to the user). After that, the move passes to the player. Only one card can be added.

Players reveal cards either when they reach 3 cards (automatically), or when the user selects the option “Open cards”. After that, the user sees the dealer’s cards and the sum of his points, as well as the result of the game (who won and who lost).
Counting results:

- The player with the total score closer to 21 wins.
- If a player has more than 21 points, then he lost.
- If the player and dealer have the same points, then a draw is announced and money from the bank is returned to the players.
- The amount from the bank of the game goes to the winner.

After the end of the game, the user is asked if he wants to play again. If yes, then the game starts anew with the distribution of cards, if not, then their program is released.



**Download repo, go to the game directory and start game (in terminal input):**
```
ruby main.rb
```
