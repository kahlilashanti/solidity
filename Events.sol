pragma solidity ^0.8.10;

contract EventExample {
    mapping(address => uint256) public tokenBalance;

    //events are used to show the outside world what has been sent
    //or any other contract activity you want the public to have access to
    event TokensSent(address _from, address _to, uint256 _amount);

    constructor() public {
        tokenBalance[msg.sender] = 100;
    }

    function sendToken(address _to, uint256 _amount) public returns (bool) {
        require(tokenBalance[msg.sender] >= _amount, "Not Enough Tokens");
        assert(tokenBalance[_to] + _amount >= tokenBalance[_to]);
        assert(tokenBalance[msg.sender] - _amount <= tokenBalance[msg.sender]);
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;

        //we must emit the event, which starts with the keyword emit
        emit TokensSent(msg.sender, _to, _amount);

        return true;
    }
}
