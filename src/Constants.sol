// SPDX-License-Identifier: MIT
pragma solidity ^0.7.6;

library Constants {
    uint24 constant ONE_BP_FEE = 50000;
    int24 constant ONE_BP_TICK_SPACING = 1000;

    address constant _WETH9 = address(0xfFf9976782d46CC05630D1f6eBAb18b2324d6B14); // sepolia
    bytes32 constant _nativeCurrencyLabelBytes =
        bytes32(0x4554480000000000000000000000000000000000000000000000000000000000);

    uint256 constant _maxIncentiveDuration = 2592000;
    uint256 constant _maxIncentiveStartLeadTime = 63072000;

    address constant _uniSwapV2Factory = address(0x0000000000000000000000000000000000000000);
    address constant _seaportV1_5 = address(0x00000000000000ADc04C56Bf30aC9d3c0aAF14dC);
    address constant _openseaConduit = address(0x1E0049783F008A0085193E00003D00cd54003c71);

    bytes32 constant _pairInitCodeHash = 0x96e8ac4277198ff8b6f785478aa9a39f403cb768dd02cbee326c3e7da348845f;
    bytes32 constant _poolInitCodeHash = 0xe34f199b19b2b4f47f68442619d555527d244f78a3297ea89325f843f87b8b54;
}
