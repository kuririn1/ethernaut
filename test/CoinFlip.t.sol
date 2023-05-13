pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "../src/levels/CoinFlip/CoinFlipFactory.sol";
import "../src/levels/CoinFlip/CoinFlipMyHack.sol";
import "../src/core/Ethernaut.sol";
import '@openzeppelin/contracts/utils/math/SafeMath.sol'; // Path change of openzeppelin contract

contract CoinFlipTest is Test {
    using SafeMath for uint256;
    Ethernaut ethernaut;

    function setUp() public {
        // Setup instance of the Ethernaut contracts
        ethernaut = new Ethernaut();
    }

    function testCoinFlipHack() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////

        CoinFlipFactory coinFlipFactory = new CoinFlipFactory();
        ethernaut.registerLevel(coinFlipFactory);
        vm.startPrank(tx.origin);
        address levelAddress = ethernaut.createLevelInstance(coinFlipFactory);
        CoinFlip ethernautCoinFlip = CoinFlip(payable(levelAddress));

        //////////////////
        // LEVEL ATTACK //
        //////////////////

        vm.roll(100);

        CoinFlipMyHack hacker = new CoinFlipMyHack();

        for (uint i = 1; i < 11; i++) {
             vm.roll(100+i);
             hacker.hack(address(ethernautCoinFlip));
             vm.expectRevert();
             hacker.hack(address(ethernautCoinFlip));
        }

        //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(levelSuccessfullyPassed);
    }
}