// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.21;

import { PRBTest } from "@prb/test/PRBTest.sol";
import { console2 } from "forge-std/console2.sol";
import { StdCheats } from "forge-std/StdCheats.sol";
import { Vault } from "../src/core/Vault.sol";
import { WETH9 } from "../src/test/WETH.sol";
import { TinuToken } from "../src/core/TinuToken.sol";
import { UN } from "../src/core/UN.sol";
import { UnitPriceFeed } from "../src/oracle/UnitPriceFeed.sol";
import { VaultPriceFeed } from "../src/core/VaultPriceFeed.sol";
import { DutchAuction } from "../src/core/DutchAuction.sol";

contract BaseSetup is PRBTest, StdCheats {

    address internal owner;
    address internal user;
    WETH9 internal WETH;
    uint256 internal recommendRatio = 200;
    uint256 internal price = 1100 * 1e18;
    uint256 internal liquidationRatio;

    TinuToken public tinu;
    UN public un;

    Vault public vault;
    UnitPriceFeed public priceFeed;
    VaultPriceFeed public vaultPriceFeed;

    function setUp() public virtual {
        owner = payable(address(uint160(uint256(keccak256(abi.encodePacked("owner"))))));
        user = payable(address(uint160(uint256(keccak256(abi.encodePacked("user"))))));
        vm.startPrank(owner);
        tinu = new TinuToken();
        WETH = new WETH9();
        un = new UN(owner);
        priceFeed = new UnitPriceFeed();
        priceFeed.setLatestAnswer(int256(price));
        vaultPriceFeed = new VaultPriceFeed();

        DutchAuction dutchAuction = new DutchAuction(1,1,1);
        vault = new Vault(address(tinu), address(dutchAuction));
        vault.setPriceFeed(address(vaultPriceFeed));
        tinu.setMinter(address(vault));
        vaultPriceFeed.setTokenConfig(address(WETH), address(priceFeed), 18);
        liquidationRatio = vault.liquidationRatio(address(WETH));
        vm.stopPrank();
    }
}