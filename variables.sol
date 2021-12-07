pragma solidity ^0.8.10;

contract WorkingWithVariables {
    uint256 public myUint;

    function setMyUint(uint256 _myUint) public {
        myUint = _myUint;
    }

    bool public myBool;

    function setMyBool(bool _myBool) public {
        myBool = _myBool;
    }

    uint8 public myUint8;

    //incrementing and decrementing functions
    function incrementUint() public {
        myUint8++;
    }

    //be careful because they wrap around
    function decrementUint() public {
        myUint8--;
    }

    address public myAddress;

    //by default an address is zero which holds 20 bytes of value

    function setAddress(address _address) public {
        myAddress = _address;
    }

    //to get the balance
    function getBalaceOfAddress() public view returns (uint256) {
        //wei is the smallest unit on the blockchain
        //ether is 10 ^ 18 wei
        return myAddress.balance;
    }

    string public myString;

    //when setting a string you have to specify where the data will be stored
    //in this case it will be in memory and not a variable, which makes it cheaper for gas
    //solidity is not made to work with strings - it is quite expensive
    //strings don't have concatenate and other features you find in other coding languages.
    function setMyString(string memory _myString) public {
        myString = _myString;
    }
}
