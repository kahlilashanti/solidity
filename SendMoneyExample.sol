pragma solidity ^0.8.10;

//we want our smart contract to receive money
contract SendMoneyExample {
    uint256 public balanceReceived;

    function receiveMoney() public payable {
        //store how much money was received
        balanceReceived += msg.value;
    }

    //function to get balance of smart contract
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    //function to withdraw money from smart contract
    function withDrawMoney() public {
        address payable to = msg.sender;
        //sender is always  the address that called this smart contract

        to.transfer(this.getBalance());
        //transfer takes in an argument which is the amount of wei you want to send
    }

    //tell the smart contract where it should transfer the money to
    function withDrawMoneyTo(address payable _to) public {
        _to.transfer(this.getBalance());
    }
}
