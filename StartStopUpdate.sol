pragma solidity ^0.8.10;

contract StartStopUpdateExample {
    //to prevent anyone from being able to send
    //store the address of the owner of the smart contract
    address owner;

    //to pause a smart contract
    bool public paused; //intially false

    function setPaused(bool _paused) public {
        //this is something only owner can do so we use require statement
        require(msg.sender == owner, "you are not the owner");
        paused = _paused;
    }

    constructor() public {
        owner = msg.sender;
    }

    function sendMoney() public payable {}

    function withDrawAllMoney(address payable _to) public {
        //require statement is the solidity equivalent of an if/else statement in javascript
        require(msg.sender == owner, "you are not the owner");
        require(!paused, "contract is paused");
        _to.transfer(address(this).balance);
    }

    //destroy or stop a smart contract
    function destroySmartContract(address payable _to) public {
        //only owner can destroy the contract so we use the require statement
        require(msg.sender == owner, "you are not the owner");
        selfdestruct(_to);
    }
}
