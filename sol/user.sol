pragma solidity ^0.4.19;

import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";
import "./ownable.sol";
import "./safemath.sol";

contract User is usingOraclize,Ownable {

    using SafeMath for uint256;

    event newUser(uint uid);
    event e_deposit(uint uid, uint balance);
    event e_refund(uint uid);

    address goverment = 0x253B25B7048227878d198e873aE5eD84EcC2d20B;
    //@dev fee_won value have to read and init real-world's fee. this method need to use oraclizeAPI
    //@param uid user's unique number
    //@param balance Amount of money deposited by the user. this value will reduce when tax is paid.
    //@param fee_won The amount of tax the user should pay
    //@param withdrawn Whether the tax was paid or not

    struct User {
      address user_address;
      uint uid;
      uint balance;
      uint fee_krw;
      bool withdrawn;
    }

    User[] public users;

    mapping (uint => address) public userToOwner;
    mapping (uint => uint) public uidToId;
    mapping (uint => uint) public uidToNum;
    mapping (address => uint) public ownerToNum;
    mapping (address => uint) public ownerToId;
    //@notice this function need to add more line to use Oraclize and get rmaining tax
    function _getFeeWon (uint id, uint _uid) internal {
      //require(_user);
      users[id].fee_krw = 100000;
    }

    //@dev this function create user and init the value.
    //@notice this function need to add the function to fill fee_won. this method is need to use Oraclize.
    function createUser(uint _uid) public {
      require(uidToNum[_uid] == 0);
      uint id = users.push(User(msg.sender,_uid,0,0,false)) - 1;
      userToOwner[id] = msg.sender;
      uidToId[_uid] = id;
      uidToNum[_uid]++;
      ownerToId[msg.sender] = id;
      ownerToNum[msg.sender]++;
      _getFeeWon(id,_uid);

      newUser(_uid);
    }

    function checkUserInfo(uint _uid) external view  {
      require(userToOwner[uidToId[_uid]] == msg.sender);
      //send info to web3.js
      //return userToOwner[uidToId[_uid]];
    }

    function refund(uint _uid) public {
      require(userToOwner[uidToId[_uid]] == msg.sender);
      User storage taxpayer = users[uidToId[_uid]];
      uint balance = address(this).balance;

       if (balance < taxpayer.balance) {
           taxpayer.balance = balance;
       }

      msg.sender.transfer(taxpayer.balance);
      taxpayer.balance = 0;

      e_refund(_uid);
    }

    //function month_fee() {
    //
    //}

    function deposit(uint _uid) payable {
      require(uidToNum[_uid] > 0); // it is not working!
      User storage taxpayer = users[uidToId[_uid]];
      taxpayer.balance = taxpayer.balance.add(msg.value);
      e_deposit(_uid, taxpayer.balance);
    }

    function _getKrwToEther (uint _krw) private returns (uint){
        //using Oraclize
        return 100000; //this line has to change
    }
    //@dev goverment can receive tax through this function
    //@dev require(!withdrawn) have to change to function with time
    function withdraw(uint _uid) public onlyOwner {
        User storage taxpayer = users[uidToId[_uid]];
        require(taxpayer.withdrawn == false); //check if already withdrawn
        uint etherFee =_getKrwToEther(taxpayer.fee_krw);
        if( taxpayer.balance >= etherFee ){
          //goverment.transfer(etherFee);
          goverment.transfer(taxpayer.balance); //this line has to change to above line
          // taxpayer.balance = taxpayer.balance.sub(etherFee);
          taxpayer.balance = taxpayer.balance.sub(taxpayer.balance); //this line has to change to above line
          taxpayer.withdrawn = true;
        }else{

        }
    }
}
