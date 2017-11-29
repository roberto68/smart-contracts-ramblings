pragma solidity ^0.4.4;
contract MultiNumberBetting {

uint public constant MAX_BET=0.005 ether;
uint public constant MIN_BET=0.000001 ether;
uint8 loserCount;
uint8 winnerCount;
uint8[3] numArray;

  function MultiNumberBetting (uint8 num0, uint8 num1, uint8 num2){ //constructor
    numArray[0] = num0;
    numArray[1] = num1;
    numArray[2] = num2;
  }
function guess(uint8 num) returns(bool){
    for(uint8 i = 0; i < numArray.length; i++){
      if(numArray[i] == num ){
      winnerCount++;
      return true;
    }
  }
  loserCount++;
  return false;
 }
function totalGuesses() returns (uint8){
  return uint8(winnerCount);
}
function sucessRate() returns (uint256){
  return (winnerCount / loserCount)*100; // float neche zozrat test !!!!
}

}
