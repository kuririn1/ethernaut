pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "../src/levels/Privacy/PrivacyFactory.sol";
import "../src/core//Ethernaut.sol";

contract PrivacyTest is Test {
    Ethernaut ethernaut;

    function setUp() public {
        // Setup instance of the Ethernaut contract
        ethernaut = new Ethernaut();
    }

    function testPrivacyHack() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////

        PrivacyFactory privacyFactory = new PrivacyFactory();
        ethernaut.registerLevel(privacyFactory);
        vm.startPrank(tx.origin);
        address levelAddress = ethernaut.createLevelInstance(privacyFactory);
        Privacy ethernautPrivacy = Privacy(payable(levelAddress));

        //////////////////
        // LEVEL ATTACK //
        //////////////////

        

        //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(levelSuccessfullyPassed);
    }
}