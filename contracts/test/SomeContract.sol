//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

import "hardhat/console.sol";

// testing 
contract SomeContract {
    function test() external {
        console.log("testing SomeContract");
    }
}
