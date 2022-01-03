//SPDX-License-Identifier: MIT License
pragma solidity ^0.8.0;

contract DaoProposalBase {

  constructor(address _daoAddress) {}

  /**
   * @notice Used by the DAO contract to record details of the proposal
   */
  function getProposalDetails()
    external
    view
    returns (
      bool requiresFundingOutsideOfBank,
      uint256 startTime,
      uint256 endTime,
      uint256 requiredFundAmount
    )
  {}

  /**
   * @notice Only the dao can
   */
  function approveProposal() external {}

  function denyProposal() external {}
}
