pragma solidity ^0.8.10;

contract SimpleMappingExample {
    mapping(uint256 => bool) public myMapping;

    function setValue(uint256 _index) public {
        myMapping[_index] = true;
    }
}
