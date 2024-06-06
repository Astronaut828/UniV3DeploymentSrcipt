// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.6;

import {Script, console2} from "forge-std/Script.sol";
import "../src/Constants.sol";
import {Multicall2} from "../src/Multicall2.sol";


// import {UnsupportedProtocol} from "../V3-UniversalRouter/contracts/deploy/UnsupportedProtocol.sol";
// import {Permit2} from "../Permit2/src/Permit2.sol";
import {UniswapV3Factory} from "../V3-core/contracts/UniswapV3Factory.sol";
import "../V3-core/contracts/interfaces/IUniswapV3Factory.sol";
import {ProxyAdmin} from "@openzeppelin/contracts/proxy/ProxyAdmin.sol";
import {TickLens} from "../V3-periphery/contracts/lens/TickLens.sol";
// import {NFTDescriptor} from "../V3-periphery/contracts/libraries/NFTDescriptor.sol";
import {NonfungibleTokenPositionDescriptor} from "../V3-periphery/contracts/NonfungibleTokenPositionDescriptor.sol";
import {TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/TransparentUpgradeableProxy.sol";
import {NonfungiblePositionManager} from "../V3-periphery/contracts/NonfungiblePositionManager.sol";
import {INonfungiblePositionManager} from "../V3-periphery/contracts/interfaces/INonfungiblePositionManager.sol";
import {V3Migrator} from "../V3-periphery/contracts/V3Migrator.sol";
import {UniswapV3Staker} from "../V3-staker/contracts/UniswapV3Staker.sol";
import {QuoterV2} from "../V3-periphery/contracts/lens/QuoterV2.sol";
import {SwapRouter02} from "../Swap-Router/contracts/SwapRouter02.sol";
// import {UniversalRouter} from "../V3-UniversalRouter/contracts/UniversalRouter.sol";

contract UniV3Script is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        // Step 1
        Multicall2 multicall2 = new Multicall2();
        console2.log("multicall2 contract deployed at address: ", address(multicall2));

        // Step 2
        // UnsupportedProtocol unsupportedProtocol = new UnsupportedProtocol();
        // console2.log("unsupportedProtocol contract deployed at address: ", address(unsupportedProtocol));

        // Step 3
        // Permit2 permit2 = new Permit2(); // Salted ?
        // console2.log("permit2 contract deployed at address: ", address(permit2));

        // Step 4
        UniswapV3Factory uniSwapV3Factory = new UniswapV3Factory();
        console2.log("uniSwapV3Factory contract deployed at address: ", address(uniSwapV3Factory));

        // Step 5 // Enable fee amounts
        uniSwapV3Factory.enableFeeAmount(Constants.ONE_BP_FEE, Constants.ONE_BP_TICK_SPACING);
        console2.log("uniSwapV3Factory 5% fee amount enabled");

        // Step 6
        ProxyAdmin proxyAdmin = new ProxyAdmin();
        console2.log("proxyAdmin contract deployed at address: ", address(proxyAdmin));

        // Step 7
        TickLens tickLens = new TickLens();
        console2.log("tickLens contract deployed at address: ", address(tickLens));

        // Step 8
        // NFTDescriptor nftDescriptor = new NFTDescriptor();
        // console2.log("nftDescriptor contract deployed at address: ", address(nftDescriptor));

        // Step 9
        NonfungibleTokenPositionDescriptor nonfungibleTokenPositionDescriptor =
        // new NonfungibleTokenPositionDescriptor(Constants._WETH9, Constants._nativeCurrencyLabelBytes, address(nftDescriptor));
        new NonfungibleTokenPositionDescriptor(Constants._WETH9, Constants._nativeCurrencyLabelBytes, address(0x000));
        console2.log(
            "nonfungibleTokenPositionDescriptor contract deployed at address: ",
            address(nonfungibleTokenPositionDescriptor)
        );

        // Step 10
        TransparentUpgradeableProxy transparentUpgradeableProxy =
            new TransparentUpgradeableProxy(address(nonfungibleTokenPositionDescriptor), address(proxyAdmin), "");
        console2.log("transparentUpgradeableProxy contract deployed at address: ", address(transparentUpgradeableProxy));

        // Step 11
        NonfungiblePositionManager nonfungiblePositionManager = new NonfungiblePositionManager(
            address(uniSwapV3Factory), Constants._WETH9, address(transparentUpgradeableProxy)
        );
        console2.log("nonfungiblePositionManager contract deployed at address: ", address(nonfungiblePositionManager));

        // Step 12
        V3Migrator v3Migrator =
            new V3Migrator(address(uniSwapV3Factory), Constants._WETH9, address(nonfungiblePositionManager));
        console2.log("v3Migrator contract deployed at address: ", address(v3Migrator));

        // Step 13 // Set UniswapV3Factory owner to msg.sender
        // uniswapV3Factory.setOwner(msg.sender);
        // console2.log("uniSwapV3Factory owner set to: ", msg.sender);

        // Step 14
        UniswapV3Staker uniswapV3Staker = new UniswapV3Staker(
            IUniswapV3Factory(address(uniSwapV3Factory)),
            INonfungiblePositionManager(address(nonfungiblePositionManager)),
            Constants._maxIncentiveDuration,
            Constants._maxIncentiveStartLeadTime
        );
        console2.log("uniswapV3Staker contract deployed at address: ", address(uniswapV3Staker));

        // Step 15
        QuoterV2 quoterV2 = new QuoterV2(address(uniSwapV3Factory), Constants._WETH9);
        console2.log("quoterV2 contract deployed at address: ", address(quoterV2));

        // Step 16
        SwapRouter02 swapRouter02 = new SwapRouter02(
            Constants._uniSwapV2Factory,
            address(uniSwapV3Factory),
            address(nonfungiblePositionManager),
            Constants._WETH9
        );
        console2.log("swapRouter02 contract deployed at address: ", address(swapRouter02));

        // Construct RouterParameters struct
        // RouterParameters memory routerParams = RouterParameters({
        //     permit2: address(permit2),
        //     weth9: Const._WETH9,
        //     seaportV1_5: Const._seaportV1_5,
        //     seaportV1_4: address(unsupportedProtocol),
        //     openseaConduit: Const._openseaConduit,
        //     nftxZap: address(unsupportedProtocol),
        //     x2y2: address(unsupportedProtocol),
        //     foundation: address(unsupportedProtocol),
        //     sudoswap: address(unsupportedProtocol),
        //     elementMarket: address(unsupportedProtocol),
        //     nft20Zap: address(unsupportedProtocol),
        //     cryptopunks: address(unsupportedProtocol),
        //     looksRareV2: address(unsupportedProtocol),
        //     routerRewardsDistributor: address(unsupportedProtocol),
        //     looksRareRewardsDistributor: address(unsupportedProtocol),
        //     looksRareToken: address(unsupportedProtocol),
        //     v2Factory: Const._v2Factory,
        //     v3Factory: address(uniSwapV3Factory),
        //     pairInitCodeHash: Const._pairInitCodeHash,
        //     poolInitCodeHash: Const._poolInitCodeHash
        // });

        // Step 17
        // UniversalRouter universalRouter = new UniversalRouter(routerParams);
        // console.log("universalRouter contract deployed at address: ", address(universalRouter));

        vm.stopBroadcast();
    }
}
