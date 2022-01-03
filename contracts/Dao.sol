//SPDX-License-Identifier: MIT License
pragma solidity ^0.8.0;

import "hardhat/console.sol";

import "./DaoProposal.sol";

contract Dao is DaoProposal {

  constructor(string memory _name, string memory _symbol) DaoProposal(_name, _symbol) {}
 

  /**
   * @notice No one can join during an active vote on a proposal.
   */
  function joinDAO() external votingNotInSession {}

  /**
   * @notice Only a member can leave the DAO. Members that leave DAO forfeit all funds in the DAO. 
   *         This is to prevent defunding the DAO due to diagreements on voting results.
   */
  function leaveDAO() external onlyMembers {}
 
  // Stake
  // LeaveStake

 

}
