pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "../src/levels/Elevator/ElevatorFactory.sol";
import "../src/levels/Elevator/ElevatorMyHack.sol";
import "../src/core//Ethernaut.sol";

contract ElevatorTest is Test {
    Ethernaut ethernaut;

    function setUp() public {
        // Setup instance of the Ethernaut contract
        ethernaut = new Ethernaut();
    }

    function testElevatorHack() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////

        ElevatorFactory elevatorFactory = new ElevatorFactory();
        ethernaut.registerLevel(elevatorFactory);
        address levelAddress = ethernaut.createLevelInstance(elevatorFactory);
        Elevator ethernautElevator = Elevator(payable(levelAddress));

        //////////////////
        // LEVEL ATTACK //
        //////////////////

        ElevatorMyHack hack = new ElevatorMyHack();
        hack.start(address(ethernautElevator));

        //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        assert(levelSuccessfullyPassed);
    }
}