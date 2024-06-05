// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import * as Const from "../src/Constants.sol";

import "../src/Multicall2.sol";
import "../src/UnsupportedProtocol.sol";
import {Permit2} from "../permit2/src/Permit2.sol";


// import { ADD_1BP_FEE_TIER } from './steps/add-1bp-fee-tier'
// import { DEPLOY_MULTICALL2 } from './steps/deploy-multicall2'
// import { DEPLOY_NFT_DESCRIPTOR_LIBRARY_V1_3_0 } from './steps/deploy-nft-descriptor-library-v1_3_0'
// import { DEPLOY_NFT_POSITION_DESCRIPTOR_V1_3_0 } from './steps/deploy-nft-position-descriptor-v1_3_0'
// import { DEPLOY_NONFUNGIBLE_POSITION_MANAGER } from './steps/deploy-nonfungible-position-manager'
// import { DEPLOY_PROXY_ADMIN } from './steps/deploy-proxy-admin'
// import { DEPLOY_QUOTER_V2 } from './steps/deploy-quoter-v2'
// import { DEPLOY_TICK_LENS } from './steps/deploy-tick-lens'
// import { DEPLOY_TRANSPARENT_PROXY_DESCRIPTOR } from './steps/deploy-transparent-proxy-descriptor'
// import { DEPLOY_V3_CORE_FACTORY } from './steps/deploy-v3-core-factory'
// import { DEPLOY_V3_MIGRATOR } from './steps/deploy-v3-migrator'
// import { DEPLOY_V3_STAKER } from './steps/deploy-v3-staker'
// import { DEPLOY_V3_SWAP_ROUTER_02 } from './steps/deploy-v3-swap-router-02'
// import { TRANSFER_PROXY_ADMIN } from './steps/transfer-proxy-admin'
// import { TRANSFER_V3_CORE_FACTORY_OWNER } from './steps/transfer-v3-core-factory-owner'

contract UniV3Script is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();


        
        Multicall2 multicall2 = new Multicall2();
        console.log("multicall2 contract deployed at address: ", address(multicall2));
        
        vm.stopBroadcast();
    }
}
