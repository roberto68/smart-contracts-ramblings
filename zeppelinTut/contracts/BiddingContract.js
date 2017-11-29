pragma solidity ^0.4.4;

contract BiddingContract {

  bytes32   name;
  string    description;
  uint      duration;
  uint      startBid;
  uint      createdAt;

  struct Bidder {
    address   address;
    string    name;
    uint      bidAmount;
    // Ethers pull pattern used  -- ??
    bool      claimedEthers;
  }

  // Declare the events
  event HighBidChanged(address addr, bytes32 nm, uint  newHighBid);
  event BidFailed(address addr, bytes32 nm, uint bidAmt);

  // Maintain all bidders in an array
  Bidder[]  bidders; // name collision struct - array?
  // This maintains the high bidder
  Bidder    highBidder = 0;
 // mapping(address=>Bidder) biddersMapping;
  modifier ownerOnly(){ // dorobit!!!
    if (msg)
    _;
    else {
      throw;
    }
  }
  // duration in minutes, start price in ethers
  function BiddingContract(bytes32 nm,
                           string desc,
                           uint dur,
                           uint sBid) {
    // constructor
    name=nm;
    description=desc;
    duration=dur;
    startBid=sBid;
    createdAt = now ;
  }

  // Bid function is what gets called by any bidder
  function  placeBid(string name, uint bid) payable {

    if (now-createdAt < duration){

      if (bid => highBidder){ // Consider the case when there is no bid ???
        highBidder = msg.sender; // ??
        // push bidder where bidder[i].bidder (address)
        bidders.push(msg.sender);
        HighBidChanged(msg.sender, name, bid);
        //  biddersMapping[msg.sender].name = name;
        //  biddersMapping[msg.sender].bidder = msg.sender; // address
        //  biddersMapping[msg.sender].bid = bid;
        //  biddersMapping[msg.sender].claimedEthers = false; // at the end of the bidding
      }
    } else {
      BidFailed (msg.value, name, bid )
       throw;
    }

  }

  function getHighBid() constant returns(uint){
    highBidder;
  }

  // This is invoked by anyone to chek if there are ehters they can claim
  // Losers will be added to the bidders array ... the claim flag in struct
  // maintains the status of whether the caller has already been given the ethers or not
  function  getClaimAmount(address) returns(uint){
    for (i=0, i < bidders.length, i++ ){
        if (address = bidders[i].addrerss){
          if (bidders[i].claimEthers == false){ // not claimed
             claimEthers;

          }
       }
       biders[i].bidAmount;
    }
  }

  // Losers will call this to get their bid ethers back
  // If they are then send ethers to them
  // remove the bidder from the bidders
  function claimEthers() {
    for (i=0, i < bidders.length, i++ ){
        if (bidders[i].claimEthers == true) {
          msg.sender.transfer(getClaimAmount(msg.sender));
          bidders[i].claimEthers == false; // already claimed
        }
     }
  }

  // Can a bid end if there are unclaimed ethers
  // In later version the claims data will be moved to a separate contract
  // Claims will be made losers against the separate contract
  function  canBidEnd() returns (bool) {
    if (now-createdAt < duration){
      if (bidders.length == 0){
        false;
      } // for bid to end
    }else{
      true; // returned value
    }
  }

  // All ethers returned to the owner as part of self destruct
  function endBidding() ownerOnly {
    // msg.sender.transfer(remaining value?)
  }

}
