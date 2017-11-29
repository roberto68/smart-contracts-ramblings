pragma solidity ^0.4.4;

/**
 * Exercise: V4
 * Section: 7
 * Part of an online course - for more info checkout link below
 * http://acloudfan.com/learn-blockchain
 */
import "./multinumberbetting.sol";

 contract MultiNumberBettingV5 is MultiNumberBettingAbstractV1 {

  uint public  loserCount;
  uint public  winnerCount;

  uint public lastWinnerAt;

  //Ex - 2 Part - 1 Remove this variable
  // string lastWinnerName ;

  // Ex - 2 Keep this
  address winner;

  // Ex-1 Part - 1  Declare a struct
  struct Winner {
    address winnerAddress;
    string  name;
    uint    guess;
    uint    guessedAt;
  }
  // Ex-1 Part - 2 Add a mapping
  mapping(address=>Winner) winnersMapping;

  uint8[3]  numArray;

  function MultiNumberBettingV5(uint8 num0, uint8 num1, uint8 num2) {
    // constructor
    numArray[0] = num0;
    numArray[1] = num1;
    numArray[2] = num2;
  }


  function guess(uint8 num, string name) returns (bool){

    // If num > 10 throw (replaced throw; with revert();)
    if(num > 10) revert();

    for(uint8 i = 0 ; i < numArray.length ; i++){
      if(numArray[i] == num) {
        // Increase the winner count
        winnerCount++;

        // Ex - 1 Part - 3
        winnersMapping[msg.sender].winnerAddress = msg.sender;
        winnersMapping[msg.sender].name = name;
        winnersMapping[msg.sender].guess = num;
        winnersMapping[msg.sender].guessedAt = now;

        // Ex - 2 Part - 2 removed the lastWinnerName
        // So delete this line
        // lastWinnerName = name;

        lastWinnerAt = winnersMapping[msg.sender].guessedAt;
        winner=msg.sender;

        return true;
      }
    }
    loserCount++;
    return false;
  }

  function totalGuesses() returns (uint){
    return (loserCount+winnerCount);
  }

  function daysSinceLastWinning()  returns (uint){
    return (now - lastWinnerAt*1 days);
  }

  function hoursSinceLastWinning() returns (uint){
    return (now - lastWinnerAt*1 hours);
  }

  function  minutesSinceLastWinning() returns (uint){
    return (now - lastWinnerAt*1 minutes);
  }

  // Ex - 2 Part - 4
  function getLastWinnerInfo() returns (address winnerAddress,
                                         string  name,
                                         uint    guess,
                                         uint    guessedAt){
    winnerAddress = winnersMapping[winner].winnerAddress;
    name =  winnersMapping[winner].name;
    guess = winnersMapping[winner].guess;
    guessedAt = winnersMapping[winner].guessedAt;
  }

  function checkWinning(address addr) returns(bool){

    return (winnersMapping[addr].guessedAt != 0);
  }

}
