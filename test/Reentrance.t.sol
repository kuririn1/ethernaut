pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "../src/levels/Reentrance/ReentranceFactory.sol";
import "../src/levels/Reentrance/ReentranceMyHack.sol";
import "../src/core/Ethernaut.sol";

contract ReentranceTest is Test {
    Ethernaut ethernaut;
    address eoaAddress = address(100);

    function setUp() public {
        // Setup instance of the Ethernaut contract
        ethernaut = new Ethernaut();
        // Deal EOA address some ether
        vm.deal(eoaAddress, 3 ether);
    }

    function testReentranceHack() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////

        ReentranceFactory reentranceFactory = new ReentranceFactory();
        ethernaut.registerLevel(reentranceFactory);
        vm.startPrank(eoaAddress);
        address levelAddress = ethernaut.createLevelInstance{value: 1 ether}(reentranceFactory);
        Reentrance ethernautReentrance = Reentrance(payable(levelAddress));

        //////////////////
        // LEVEL ATTACK //
        //////////////////

        uint256 balance = address(ethernautReentrance).balance;

        console.log("Balance before: %s", balance);

        ReentranceMyHack hack = new ReentranceMyHack();

        hack.setAddress(address(ethernautReentrance));
        hack.startAttack{value: balance}();

        balance = address(ethernautReentrance).balance;

        console.log("Balance after: %s", balance);

        //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(levelSuccessfullyPassed);
    }
}