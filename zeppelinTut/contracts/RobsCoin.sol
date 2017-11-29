pragma solidity ^0.4.13;

import 'zeppelin-solidity/contracts/token/MintableToken.sol';
//import '../node_modules/zeppelin-solidity/contracts/token/MintableToken.sol';

contract RobsCoin is MintableToken {
  string public name = "ROBERTO COIN";
  string public symbol = "ROB";
  uint256 public decimals = 18;
}
