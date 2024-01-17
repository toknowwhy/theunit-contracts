// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface ITreasury {
    function trackerData(address) external view returns(uint256);
}