// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

import "../interfaces/IRewardDistributor.sol";
import "../interfaces/IRewardTracker.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract RewardDistributor is IRewardDistributor {

    address public override rewardToken;
    uint256 public override tokensPerInterval;
    uint256 public lastDistributionTime;
    address public rewardTracker;

    address public admin;
    address public gov;

    event Distribute(uint256 amount);
    event TokensPerIntervalChange(uint256 amount);

    modifier onlyAdmin() {
        require(msg.sender == admin, "RewardDistributor: forbidden");
        _;
    }

    constructor(address _rewardToken, address _rewardTracker) {
        rewardToken = _rewardToken;
        rewardTracker = _rewardTracker;
        admin = msg.sender;
        gov = msg.sender;
    }

    modifier onlyGov() {
        require(msg.sender == gov, "Governable: forbidden");
        _;
    }

    function setGov(address _gov) external onlyGov {
        gov = _gov;
    }

    function setAdmin(address _admin) external onlyGov {
        admin = _admin;
    }

    // to help users who accidentally send their tokens to this contract
    function withdrawToken(address _token, address _account, uint256 _amount) external onlyGov {
        // IERC20(_token).safeTransfer(_account, _amount);
    }

    function updateLastDistributionTime() external onlyAdmin {
        lastDistributionTime = block.timestamp;
    }

    function setTokensPerInterval(uint256 _amount) external onlyAdmin {
        require(lastDistributionTime != 0, "RewardDistributor: invalid lastDistributionTime");
        IRewardTracker(rewardTracker).updateRewards();
        tokensPerInterval = _amount;
        emit TokensPerIntervalChange(_amount);
    }

    function pendingRewards() public view override returns (uint256) {
        if (block.timestamp == lastDistributionTime) {
            return 0;
        }

        uint256 timeDiff = block.timestamp - lastDistributionTime;
        return tokensPerInterval * timeDiff;
    }

    function distribute() external override returns (uint256) {
        // require(msg.sender == rewardTracker, "RewardDistributor: invalid msg.sender");
        // uint256 amount = pendingRewards();
        // if (amount == 0) { return 0; }

        // lastDistributionTime = block.timestamp;

        // uint256 balance = IERC20(rewardToken).balanceOf(address(this));
        // if (amount > balance) { amount = balance; }

        // // IERC20(rewardToken).safeTransfer(msg.sender, amount);
        // safeTransfer(rewardToken, msg.sender, amount);

        // emit Distribute(amount);

        // return amount;
        return 0;
    }

    function safeTransfer(address _token, address _to, uint256 _amount) internal {
         IERC20(_token).transfer(_to, _amount);
    }
}