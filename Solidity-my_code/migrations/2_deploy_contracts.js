var Calculator = artifacts.require("./Calculator.sol");
var MultiNumberBetting = artifacts.require("./MultiNumberBetting.sol");
var MultiNumberBettingV2 = artifacts.require("./MultiNumberBettingV2.sol");
var MultiNumberBettingV4 = artifacts.require("./MultiNumberBettingV4.sol");
var MultiNumberBettingV6 = artifacts.require("./MultiNumberBettingV6.sol");

module.exports = function(deployer) {
  deployer.deploy(Calculator, 10);
  deployer.deploy(MultiNumberBetting, 8,5,12);
  deployer.deploy(MultiNumberBettingV2, 8,3,12);
  deployer.deploy(MultiNumberBettingV4,1,3,9);
  deployer.deploy(MultiNumberBettingV6,1,3,9);
};
