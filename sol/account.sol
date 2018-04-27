pragma solidity ^0.4.19;

contract account {
    
    event newAccount(uint uid, string name);
    
    struct Account{
        uint uid;
        string name;
        uint balance;
    }
    
    Account[] public accounts;
    
    mapping (uint => address) public accountToOwner;
    mapping (address => uint) public OwnerAccountNum;
    
    function createAccount(uint _uid, string _name) public {
        require(OwnerAccountNum[msg.sender] == 0 );
        accounts.push(Account(_uid,_name,0));
        accountToOwner[_uid] = msg.sender;
        OwnerAccountNum[msg.sender]++;
        newAccount(_uid,_name);
    }
}
