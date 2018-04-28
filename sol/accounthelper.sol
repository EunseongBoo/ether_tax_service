pragma solidity ^0.4.19;

contract AccountHelper is Account {

  uint MaximumFee = 1 ether;

  function deposit(uint id) external payable {
    require(msg.value < MaximumFee )
    
  }

}
