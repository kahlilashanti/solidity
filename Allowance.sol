pragma solidity ^0.8.10;

//this can be used alongside OpenZeppelin when executing online with remix.ethereum.org
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract AllowanceWallet is Ownable {
    //we need some sort of data struction to hold an unsigned integer to an address
    mapping(address => uint256) public allowance;

    // who is allowed to withdraw and how much are they allowed to withdraw
    function addAllowance(address _who, uint256 _amount) public onlyOwner {
        //set the allowance for the person to the amount
        allowance[_who] = _amount;
    }

    //this code below was what we wrote before using the openzeppelin library for the Ownable contract
    // //ensure only the owner can send money
    // address public owner;

    // constructor()public {
    //     owner = msg.sender;
    // }

    // modifier onlyOwner(){
    //     require(owner == msg.sender, "You are not allowed");
    //     _;
    // }

    //withdraw money from the smart contract
    function withdrawMoney(address payable _to, uint256 _amount)
        public
        onlyOwner
    {
        _to.transfer(_amount);
    }

    //deposit money to the smart contract
    receive() external payable {}
}
