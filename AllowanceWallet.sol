pragma solidity ^0.8.10;

import "./Allowance.sol";

//events allow you to listen to things happening on the blockchain with a contract without pulling on a blockchain node
//events are stored in a sidechain. you cannot retrieve them from within solidity

contract AllowanceWallet is Allowance {
    event MoneySent(address indexed _beneficiary, uint256 _amount);
    event MoneyReceived(address indexed _from, uint256 _amount);

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
        emit MoneySent(_to, _amount);
        _to.transfer(_amount);
    }

    function renounceOwnership() public {
        revert("cannot renounce ownership");
    }

    //deposit money to the smart contract
    receive() external payable {
        emit MoneyReceived(msg.sender, msg.value);
    }
}
