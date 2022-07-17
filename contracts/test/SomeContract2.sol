//SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

import "hardhat/console.sol";

// testing 
contract SomeContract2 {
    function test2() external {
        console.log("testing SomeContract2");
    }
}
