// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

interface IVault {

    // The number of all tokens in the pool
    // function poolAmounts(address _token) external view returns (uint256);
    function approve(address _operator, bool _allow) external;
    function increaseCollateral(address _collateralToken, address _receiver) external returns (bool);
    
    function decreaseCollateral(
        address _collateralToken,
        address _receiver, 
        uint256 _collateralAmount
    ) external returns(bool);
    
    function decreaseCollateralFrom(
        address _from,
        address _collateralToken,
        address _receiver,
        uint256 _collateralAmount,
        bytes calldata _data
    ) external returns (bool);

    function liquidation(address _token, address _account, address _feeTo
    ) external returns (bool);

    // function vaultOwnerAccount(address _receiver, address _collateralToken) external view returns (uint256);
    function flashLoan(address _collateralToken, uint256 _amount, address _receiver, bytes calldata _data) external returns (bool);
    function flashLoanFrom(address _from, address _collateralToken, uint256 _amount, address _receiver, bytes calldata _data) external returns (bool);
    function flashLoanAssets(
        address _from,
        address _collateralToken, 
        uint256 _amount, 
        address _receiver,
        bytes calldata _data
    ) external returns (bool);

    function increaseDebt(address _collateralToken, uint256 _amount, address _receiver) external returns (bool);
    function increaseDebtFrom(address from,address _collateralToken, uint256 _amount, address _receiver) external returns (bool);

    function decreaseDebt(
        address _collateralToken,
        address _receiver
    ) external returns (bool);

     function getPrice(address _token) external view returns (uint256);

    function transferVaultOwner(address _newAccount, address _collateralToken) external;
    // function transferFromVaultOwner(address _from ,address _newAccount, address _collateralToken, uint256 _tokenAssets, uint256 _unitDebt) external;

    function vaultOwnerAccount(address _account, address _collateralToken) external view returns (uint256, uint256);

    function setFreeFlashLoanWhitelist(address _addr, bool _isActive) external;
}