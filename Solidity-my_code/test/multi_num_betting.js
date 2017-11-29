var MultiNumberBetting = artifacts.require ("./MultiNumberBetting.sol")

contract('MultiNumberBetting', function(accounts){
  it('should assert true', function(){
    var multi_num_betting;
    return MultiNumberBetting.deployed().then(function(instance){
      multi_num_betting = instance;
      return multi_num_betting.totalGuesses.call();
    }).then(function(result){
      console.log("totalGuesses=", result.toNumber());
      //make a guess
      multi_num_betting.guess(5);
      return multi_num_betting.totalGuesses.call();
    }).then(function(result){
      console.log("totalGuesses=", result.toNumber());
      assert.isTrue(result.toNumber() == 1 )
      //return multi_num_betting.sucessRate.call();
    });
    //.then(function(result){
    //   console.log("sucessRate is", result ,"%");
    // });
  });
});
