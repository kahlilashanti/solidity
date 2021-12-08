pragma solidity ^0.8.10;

//this can be used alongside OpenZeppelin when executing online with remix.ethereum.org
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Allowance is Ownable {
    //move the functions that have to do with allowance into their own smart contract
    //we need some sort of data struction to hold an unsigned integer to an address
    mapping(address => uint256) public allowance;

    // who is allowed to withdraw and how much are they allowed to withdraw
    function addAllowance(address _who, uint256 _amount) public onlyOwner {
        //set the allowance for the person to the amount
        allowance[_who] = _amount;
    }

    modifier ownerOrAllowed(uint256 _amount) {
        require(
            isOwner() || allowance[msg.sender] >= _amount,
            "You are not allowed"
        );
        _;
    }

    function reduceAllowance(address _who, uint256 _amount) internal {
        allowance[_who] -= _amount;
    }
}

contract AllowanceWallet is Allowance {
    //withdraw money from the smart contract
    function withdrawMoney(address payable _to, uint256 _amount)
        public
        ownerOrAllowed(_amount)
    {
        //lets make sure you can only withdraw if there are funds
        require(
            _amount <= address(this).balance,
            "there are not enough funds in this smart contract"
        );
        //limit how much can be withdrawn
        if (!isOwner()) {
            reduceAllowance(msg.sender, _amount);
        }
        _to.transfer(_amount);
    }

    //deposit money to the smart contract
    receive() external payable {}
}
