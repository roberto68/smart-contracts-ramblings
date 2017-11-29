
var MultiNumberBettingV2 = artifacts.require("./MultiNumberBettingV2.sol");

contract('MultiNumberBettingV2', function(accounts) {
  it("should assert true", function() {
    var multi_number_betting_v2;
    return MultiNumberBettingV2.deployed().then(function(instance){
      multi_number_betting_v2 = instance;

      // Send a losing guess
      multi_number_betting_v2.guess(4,"John Miller")
      return multi_number_betting_v2.totalGuesses.call();
    }).then(function(result){
      console.log("totalGuesses=", result.toNumber());
      assert.isTrue(result.toNumber() == 0 );  // failing why the fuck ???
      // Send a winning guess
      return multi_number_betting_v2.getLastWinner.call();
      }).then(function(result){
        console.log("Winner name= "+result);
        assert.isTrue((result) == '***');
      multi_number_betting_v2.guess(3,"Bob Davis")
      return multi_number_betting_v2.totalGuesses.call();
    }).then(function(result){
      console.log("totalGuesses=", result.toNumber());
      assert.isTrue(result.toNumber() == 1 );
      return multi_number_betting_v2.getLastWinner.call();
    }).then(function(result){
      console.log("Winner name= "+result);
      assert.isTrue((result) == 'Bob');
    });
  });
});
