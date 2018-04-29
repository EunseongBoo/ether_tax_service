pragma solidity ^0.4.19;

import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";
import "./ownable.sol";
import "./safemath.sol";

contract User is usingOraclize,Ownable {

    using safeMath for uint256;

    event newUser(uint uid);
    address goverment;
    //@dev fee_won value have to read and init real-world's fee. this method need to use oraclizeAPI
    //@param uid user's unique number
    //@param balance Amount of money deposited by the user. this value will reduce when tax is paid.
    //@param fee_won The amount of tax the user should pay
    //@param withdrawn Whether the tax was paid or not
    struct User {
      address owner;
      uint uid;
      uint balance;
      uint fee_won;
      bool withdrawn;
    }

    User[] public users;

    mapping (uint => address) public userToOwner;
    mapping (uint => uint) public uidToId;
    mapping (uint => uint) public uidToNum;

    //@notice this function need to add more line to use Oraclize and get rmaining tax
    function _getFeeWon (uint id, uint _uid) internal return (bool){
      require(_user);
    }

    //@dev this function create user and init the value.
    //@notice this function need to add the function to fill fee_won. this method is need to use Oraclize.
    function createUser(uint _uid) public {
      require(uidToNum[_uid] == 0);
      uint id = users.push(User(msg.sender,_id,0,0,false)) - 1;
      userToOwner[id] = msg.sender;
      uidToId[_uid] = id;
      uidToNum[_uid].append(1);
      _getFeeWon(id,_uid);

      newUser(_uid);
    }

    function checkUserInfo(uint _uid) external view {
      require(userToOwner[uidToId[_uid]] == msg.sender);
      //send info to web3.js
    }

    function refund(uint _uid) public {
      require(userToOwner[uidToId[_uid]] == msg.sender);
      //refund function implemntation
    }

    function month_fee(){

    }

    function deposit(uint _uid, uint _balance){
      require(userToOwner[uidToId[_uid]] == msg.sender);

    }

    function _getKrwToEther (uint id, uint _uid) private return (uint){
        //using Oraclize
    }
    //@dev goverment can receive tax through this function
    //@dev require(!withdrawn) have to change to function with time
    function withdraw(uint _uid, address dst) public onlyOwner {
        User storage taxpayer = users[uidToId[_uid]];
        require(taxpayer.withdrawn == false); //check if already withdrawn
        uint etherFee =_getKrwToEther(taxpayer.fee_won);
        if( taxpayer.balance >= etherFee ){
          //send ether to dst
          taxpayer.balance = taxpayer.balance.sub(etherFee);
          taxpayer.withdrawn = true;
        }else{

        }
    }
}
