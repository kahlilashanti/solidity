pragma solidity ^0.8.10;

//this can be used alongside OpenZeppelin when executing online with remix.ethereum.org
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract AllowanceWallet is Ownable {
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
