//SPDX-License-Identifier: MIT License
pragma solidity ^0.8.0;

import "hardhat/console.sol";

import "./DaoAccessModifiers.sol";

contract DaoConfig is DaoAccessModifiers {
  /** Configurations */

  /** Fee to join the DAO */
  uint256 public membershipFee = 0.01 ether;
  
  // TODO: PACKING OPTIMIZATION BELOW

  /** Max number of tokens allowed */
  uint256 public maxTokens = 1000;
  /** Deposit amount for the proposal that will be forfeited if mailicious */
  uint256 public proposalDepositPercentage = 1;
  /** General vote % required to approve the proposal. */
  uint256 public proposalGeneralVoteToApprovePercentage = 51;
  /** General vote period will expire after this much time is passed between audit approval and voting. Time-sensetive proposals may expire before this. */
  uint256 public proposalGeneralVoteExpirationPeriodInSeconds = 1209600; // Default is 14 days
  /** Required Auditor count determines how many auditors must audit the proposal before it can be sent to general vote. */
  uint256 public requiredAuditorCount = 1;
  /** Auditor vote % required to approve the proposal to move it to general vote. */
  uint256 public requiredAuditorVoteToApprovePercentage = 50;
  /** Auditor vote % required to ban the proposal autor and forfiet their deposit. */
  uint256 public requiredAuditorVoteToBanPercentage = 100;
  /** Audit period will expire after this much time is passed between election and voting. Time-sensetive proposals may expire before this. */
  uint256 public auditExpirationPeriodInSeconds = 1209600; // Default is 14 days


  /** Error Codes */
  constructor(string memory _name, string memory _symbol)
    DaoAccessModifiers(_name, _symbol)
  {}

  function changeMembershipFee(uint256 _fee) external onlyApprovedProposal {
    membershipFee = _fee;
  }

  function changeMaxTokens(uint256 _maxTokens) external onlyApprovedProposal {
    maxTokens = _maxTokens;
  }

  function changeProposalDepositPercentage(uint256 _proposalDepositPercentage)
    external
    onlyApprovedProposal
  {
    proposalDepositPercentage = _proposalDepositPercentage;
  }

  function changeRequiredAuditorCount(uint256 _requiredAuditorCount)
    external
    onlyApprovedProposal
  {
    requiredAuditorCount = _requiredAuditorCount;
  }
}
