pragma solidity ^0.4.19;

import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";

contract test is usingOraclize,Ownable {

    event newUser(uint uid);

    //@dev fee_won value have to read and init real-world's fee. this method need to use oraclizeAPI
    //@param uid user's unique number
    //@param balance Amount of money deposited by the user. this value will reduce when tax is paid.
    //@param fee_won The amount of tax the user should pay
    //@param withdrawn Whether the tax was paid or not
    struct user {
      uint uid;
      uint balance;
      uint fee_won;
      bool withdrawn;
    }

    user[] public users;

    mapping (uint => address) public UserToOwner;
    mapping (address => uint) public ownerUserNum;

    function createUser(address _dst, uint _id) public payable {
        dst = _dst;
        id = _id;
        withdrawn = false;
    }

    function refund() public {

    }

    function month_fee(){

    }
    //@dev goverment can receive tax through this function
    //@dev require(!withdrawn) have to change to function with time
    function withdraw(uint _id) public {
        require(dst == msg.sender)
        require(!withdrawn) //check if already withdrawn

    }
}
