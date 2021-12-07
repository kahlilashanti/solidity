pragma solidity ^0.8.10;

contract Owned {
    address owner;

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "you are not allowed");
        _;
    }
}

//'is Owned' inherits from the contract above
contract InheritanceModifierExample is Owned {
    mapping(address => uint256) public tokenBalance;

    uint256 tokenPrice = 1 ether;

    //we are creating a token and we give the owner of the contract 100 tokens to begin with
    constructor() public {
        tokenBalance[owner] = 100;
    }

    //this is used to create code once and use multiple times elsewhere
    //'don't repeat yourself'
    // modifier onlyOwner() {
    //     require(msg.sender == owner, "you are not allowed");
    //     _;
    // }

    //if you are not the owner you can buy tokens and each token costs 1 ether
    function createNewToken() public onlyOwner {
        tokenBalance[owner]++;
    }

    function burnToken() public onlyOwner {
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
