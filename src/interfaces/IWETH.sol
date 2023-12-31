//SPDX-License-Identifier: MIT

pragma solidity 0.8.21;

interface IWETH {
    function deposit() external payable;
    function transfer(address to, uint value) external returns (bool);
    function withdraw(uint) external;
    function approve(address guy, uint wad) external;
    function balanceOf(address from) external view returns(uint256)
    ;
}
