//SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

import "hardhat/console.sol";

// used for testing
contract StandardProxy is TransparentUpgradeableProxy {
    
    constructor(address logic_, address admin_) TransparentUpgradeableProxy(logic_, admin_, new bytes(0)) {
    }
}
