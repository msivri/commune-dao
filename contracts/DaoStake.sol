//SPDX-License-Identifier: MIT License
pragma solidity ^0.8.0;

import "hardhat/console.sol";

import "./DaoConfig.sol";

/**
 *  @dev Handles all the proposal and voting logic
 */
contract DaoStake is DaoConfig {
  /**
   *  @dev Stake Setup
   */
  struct Stake {
    uint128 amount;
    uint128 startTime;
  }

  /**
   *  @dev Track who is staking and how much.
   */
  mapping(address => Stake) internal memberToStakedTokens;
  /**
   *  @dev Track total staked.
   */
  uint256 internal totalStaked;

  constructor(string memory _name, string memory _symbol)
    DaoConfig(_name, _symbol)
  {}
}
