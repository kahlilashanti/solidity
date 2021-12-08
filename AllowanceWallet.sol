pragma solidity ^0.8.10;

//this can be used alongside OpenZeppelin when executing online with remix.ethereum.org
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

//SafeMath Library
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

//events allow you to listen to things happening on the blockchain with a contract without pulling on a blockchain node
//events are stored in a sidechain. you cannot retrieve them from within solidity

contract Allowance is Ownable {
    using SafeMath for uint256;

    //event to tell you the allowance has changed
    event AllowanceChanged(
        address indexed _forWho,
        address indexed _fromWhom,
        uint256 _oldAmount,
        uint256 _newAmount
    );
    //we need some sort of data struction to hold an unsigned integer to an address
    mapping(address => uint256) public allowance;

    // who is allowed to withdraw and how much are they allowed to withdraw
    function addAllowance(address _who, uint256 _amount) public onlyOwner {
        //events must be emitted
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
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
        emit AllowanceChanged(
            _who,
            msg.sender,
            allowance[_who],
            allowance[_who].sub(_amount)
        );
        allowance[_who] - allowance[who].sub(_amount);
    }
}

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
