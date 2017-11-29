var ConvertLib = artifacts.require("./ConvertLib.sol");
var MetaCoin = artifacts.require("./MetaCoin.sol");
var RobsCoinCrowdsale = artifacts.require("./RobsCoinCrowdsale.sol");

module.exports = function(deployer, network, accounts) {
  const starTime = web3.eth.getBlock(web3.eth.blockNumber).timestamp + 1 // one second in the future
  const endTime = startTime + (86400 * 20) // 20 days
  const rate = new web3.bigNumber(1000);
  const wallet = accounts [0];

  deployer.deploy(RobsCoinCrowdsale, starTime, endTime, rate);
};
