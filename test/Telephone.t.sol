pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "../src/levels/Telephone/TelephoneFactory.sol";
import "../src/levels/Telephone/TelephoneMyHack.sol";
import "../src/core//Ethernaut.sol";

contract TelephoneTest is Test {
    Ethernaut ethernaut;

    function setUp() public {
        // Setup instance of the Ethernaut contract
        ethernaut = new Ethernaut();
    }

    function testTelephoneHack() public {

        /////////////////
        // LEVEL SETUP //
        /////////////////

        TelephoneFactory telephoneFactory = new TelephoneFactory();
        ethernaut.registerLevel(telephoneFactory);
        vm.startPrank(tx.origin);
        address levelAddress = ethernaut.createLevelInstance(telephoneFactory);
        Telephone ethernautTelephone = Telephone(payable(levelAddress));


        //////////////////
        // LEVEL ATTACK //
        //////////////////

        TelephoneMyHack hacker = new TelephoneMyHack();

        hacker.hack(address(ethernautTelephone));

        //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(levelSuccessfullyPassed);
    }
}