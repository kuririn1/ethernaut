pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "../src/levels/Force/ForceFactory.sol";
import "../src/levels/Force/ForceMyHack.sol";
import "../src/core//Ethernaut.sol";

contract ForceTest is Test {
    Ethernaut ethernaut;
    address eoaAddress = address(100);

    function setUp() public {
        // Setup instance of the Ethernaut contract
        ethernaut = new Ethernaut();
        // Deal EOA address some ether
        vm.deal(eoaAddress, 5 ether);
    }

    function testForceHack() public {

        /////////////////
        // LEVEL SETUP //
        /////////////////

        ForceFactory forceFactory = new ForceFactory();
        ethernaut.registerLevel(forceFactory);
        vm.startPrank(eoaAddress);
        address levelAddress = ethernaut.createLevelInstance(forceFactory);
        Force ethernautForce = Force(payable(levelAddress));


        //////////////////
        // LEVEL ATTACK //
        //////////////////

        ForceMyHack hack = new ForceMyHack();

        hack.sendEther{value: 1 ether}(payable(address(ethernautForce)));

         //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(levelSuccessfullyPassed);
    }
}