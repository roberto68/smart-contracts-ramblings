pragma solidity ^0.4.4;

import "./MultiNumberBettingAbstractV1.sol";

// Ex - 1 Part - 3
contract MultiNumberBettingV6{

  uint public  loserCount;
  uint public  winnerCount;

  uint public lastWinnerAt;
  uint public balance = msg.value; //contract balance ??

  address winner;

  // Ex-2 Part 1,2
  uint public constant MAX_BET = 0.0005 ether;
  uint public constant MIN_BET = 0.000001 ether;

  modifier checkBalance {
      uint balance = msg.value;
      if (balance < 2*MAX_BET) revert(); //throw was deprecated;
            else// or else just continue executing the function
      _;
  }
  modifier ownerOnly(address owner) {
      if (owner != msg.sender) revert(); //throw was deprecated;
            else// or else just continue executing the function
      _;
  }

  struct Winner {
    address winnerAddress;
    string  name;
    // Ex - 3 Part - 2
    uint    ethersReceived;
    uint    guess;
    uint    guessedAt;
    uint ethersReceived;
  }

  mapping(address=>Winner) winnersMapping;

  uint8[3]  numArray;

  function MultiNumberBettingV5(uint8 num0, uint8 num1, uint8 num2) {
    // constructor
    numArray[0] = num0;
    numArray[1] = num1;
    numArray[2] = num2;

  }

  // Ex - 3 Part - 1, Make guess payable

    function guess(uint8 num, string name) checkBalance payable returns(bool)  {
    // Ex - 4 Part - 1
    if( num > 10 ) {
      revert();
    }
    uint recvd = msg.value; // amount by which contract is funded
    if(recvd < MIN_BET || recvd > MAX_BET)  revert();

    for(uint8 i = 0 ; i < numArray.length ; i++){
      if(numArray[i] == num) {
        // Increase the winner count
        winnerCount++;

        winnersMapping[msg.sender].winnerAddress = msg.sender; // nechapem uplne funckiu msg.sender
        winnersMapping[msg.sender].name = name;
        winnersMapping[msg.sender].guess = num;
        winnersMapping[msg.sender].guessedAt = now;
        // Ex - 3 Part - 3
        winnersMapping[msg.sender].ethersReceived = msg.value; // transfer of ethers to winner

        lastWinnerAt = winnersMapping[msg.sender].guessedAt;
        msg.sender.send(recvd * 2); //??? msg sender
        // Ex - 4 Part - 2
        // Send the ethers - make sure you address the issue raised in
        // Ex - 4 Part - 2 a

        return true;
      }
    }
    loserCount++;
    return false;
  }

  function totalGuesses() returns (uint){
    return (loserCount+winnerCount);
  }

  // Ex - 4 Part - 4  // CHECK !!!
  function getLastWinnerInfo() ownerOnly(address) returns(address winnerAddress,
                                        string  name,
                                        uint    guess,
                                        uint    guessedAt,
                                        uint    ethersReceived){
    winnerAddress = winnersMapping[winner].winnerAddress;
    name =  winnersMapping[winner].name;
    guess = winnersMapping[winner].guess;
    guessedAt = winnersMapping[winner].guessedAt;
    ethersReceived= winnersMapping[winner].ethersReceived;
    winnerAddress.transfer(amount); // transfer from contract to winneraddress
  }

  // Ex - 3
  function checkWinning(address addr) returns(bool){ //implement modifier

    return (winnersMapping[addr].guessedAt != 0);
  }
}
/*
// how to fund a contract
web3.eth.sendTransaction({to:to, from: from, value:web3.toWei(amount,"ether")}, function(err1, resp1){
  if(err1){
      console.log(err1);
  }
  else{
      console.log(resp1);
  }
}); */
