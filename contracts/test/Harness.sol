//SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

import "hardhat/console.sol";

// used for testing 
contract Harness {

    address private _standardProxy;
    address private _multiProxy;
    
    constructor(address standardProxy_, address multiProxy_) {
        _standardProxy = standardProxy_; 
        _multiProxy = multiProxy_; 
    }

    function testStandard() external {
        bytes memory data = abi.encodeWithSignature("test()");
        (bool success, ) = _standardProxy.call(data);
        require(success, "call failed");
    }

    function test() external {
        bytes memory data = abi.encodeWithSignature("test()");
        (bool success, ) = _multiProxy.call(data);
        require(success, "call failed");
    }

    function test2() external {
        bytes memory data = abi.encodeWithSignature("test2()");
        (bool success, ) = _multiProxy.call(data);
        require(success, "call failed");
    }

}
