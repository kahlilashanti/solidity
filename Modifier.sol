pragma solidity ^0.8.10;

contract InheritanceModifierExample {
    mapping(address => uint256) public tokenBalance;

    address owner;

    uint256 tokenPrice = 1 ether;

    //we are creating a token and we give the owner of the contract 100 tokens to begin with
    constructor() public {
        owner = msg.sender;
        tokenBalance[owner] = 100;
    }

    //if you are not the owner you can buy tokens and each token costs 1 ether
    function createNewToken() public {
        require(msg.sender == owner, "you are not allowed");
        tokenBalance[owner]++;
    }

    function burnToken() public {
        require(msg.sender == owner, "you are not allowed");
        tokenBalance[owner]--;
    }

    function purchaseToken() public payable {
        require(
            (tokenBalance[owner] * tokenPrice) / msg.value > 0,
            "not enough tokens"
        );
        tokenBalance[owner] -= msg.value / tokenPrice;
        tokenBalance[msg.sender] += msg.value / tokenPrice;
    }
}
