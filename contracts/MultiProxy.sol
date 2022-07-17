//SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

contract MultiProxy is TransparentUpgradeableProxy {
    
    // uint256(keccak256("MultiProxy._implementations"))
    bytes32[96489689774546501236797019198624600535609897770066270544956762099623745924138] private _gap;
    mapping(bytes4 => address) private _implementations;
    
    constructor(address logic_, address admin_) TransparentUpgradeableProxy(logic_, admin_, new bytes(0)) {
        // set logic -> 0 since we use _implementations
        assembly {
            sstore(_IMPLEMENTATION_SLOT, 0)
        }
    }

    function setImplementation(bytes4 selector, address implementation_) external ifAdmin {
        // it is assumed that admin tracks whether there are collisions
        // since msg.sig's across contracts may have collisions
        _implementations[selector] = implementation_; 
    }

    function _fallback() internal virtual override {
      _beforeFallback();
      _delegate(_implementations[msg.sig]);
    }
}
