//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/MinatoToken.sol";

contract DeployMinatoToken is Script {
    function run() external {
        vm.startBroadcast();
        new MinatoToken(
            "MinatoToken",
            "MIN",
            1_000_000
        );
        vm.stopBroadcast();
    }
}