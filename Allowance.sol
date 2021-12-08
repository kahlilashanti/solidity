pragma solidity ^0.8.10;

//this can be used alongside OpenZeppelin when executing online with remix.ethereum.org
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

//SafeMath Library
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

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
