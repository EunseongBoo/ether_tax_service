pragma solidity ^0.4.19;

import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";

contract test is usingOraclize,Ownable {

    event newUser(uint uid);

    struct user {
      uint uid;
      uint balance;
      bool withdrawn;
    }

    function test(address _dst, uint _id) public payable {
        dst = _dst;
        id = _id;
        withdrawn = false;
    }

    function refund() public {

    }
    function month()
    //@dev goverment can receive tax through this function
    //@dev require(!withdrawn) have to change to function with time
    function withdraw(uint _id) public {
        require(dst == msg.sender)
        require(!withdrawn) //check if already withdrawn

    }
}
