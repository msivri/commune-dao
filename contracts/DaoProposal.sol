//SPDX-License-Identifier: MIT License
pragma solidity ^0.8.0;

import "hardhat/console.sol";

import "./DaoStake.sol";

/**
 *  @dev Handles all the proposal and voting logic
 */
contract DaoProposal is DaoStake {
  /**
   *  @dev Track who voted to prevent multiple voting
   */
  mapping(address => mapping(address => bool)) internal auditorVotedOnProposal;
  mapping(address => mapping(address => bool)) internal memberVotedOnProposal;

  /**
   *  @dev Proposal
   */
  struct Proposal {
    address author;
    address smartContract;
    bool auditPassed;
    bool auditRequired;
    bool auditorsAreReady;
    bool approved;
    bool denied;
    bool banned;
    bool isRemovedByAuthor;
    uint256 fundsRequiredAmount;
    uint256 fundsDepositedAmount;
    uint256 auditFinishedAt;
    uint128 submittedAt;
    uint128 expireAt;
    uint128 requiredAuditorCount;
    uint128 auditBanCount;
    uint64 auditYesVotes;
    uint64 auditNoVotes;
    uint64 generalYesVotes;
    uint64 generalNoVotes;
  }
  mapping(address => Proposal) internal proposals;

  constructor(string memory _name, string memory _symbol)
    DaoStake(_name, _symbol)
  {}

  /**
   *  @dev Voting in session
   */
  modifier votingInSession() {
    require(false);
    _;
  }

  /**
   *  @dev Voting is not session
   */
  modifier votingNotInSession() {
    require(false);
    _;
  }

  /**
   * @notice Proposals require a deposit
   */
  function proposeSmartContract(address _proposalContractAddress)
    external
    payable
    onlyMembers
  {
    // Check if sent amount is correct amount for the deposit
    // Check if required stake length is fullfilled
    // Create proposal
  }

  /**
   * @notice Only an expired or denied porposal can be removed.
   * @dev Remove a propoal if it has not executed already.
   */
  function removeProposedSmartContract(address _proposalContractAddress)
    external
    onlyProposalAuthor(_proposalContractAddress)
  {
    Proposal storage proposal = proposals[_proposalContractAddress];
    // Check if proposal finished audit OR if the audit is expired OR proposal is expired
    require(
      proposal.denied ||
        !proposal.auditRequired ||
        isProposalExpired(_proposalContractAddress),
      CANNOT_REMOVE_PROPOSAL
    );

    proposal.isRemovedByAuthor = true;
  }

  /**
   * @notice All votes are public.
   */
  function voteOnProposal(address _proposalContractAddress, bool _approve)
    external
    onlyMembers
  {
    // Check if audit passed, not removed and not banned
  }

  /**
   * @notice Proposal can be only executed by the approved proposal.
   * @dev Execute proposal.
   */
  function executeProposal(address _proposalContractAddress)
    external
    onlyApprovedProposal
  {
    // Check if audit passed, not removed and not banned, and approved
  }

  /**
   * @dev Helper function to check if proposal is expired.
   */
  function isProposalExpired(address _proposalContractAddress)
    public
    view
    returns (bool)
  {
    Proposal memory proposal = proposals[_proposalContractAddress];

    // If proposal has an expiration, that is checked first
    if (proposal.expireAt > 0 && proposal.expireAt <= block.timestamp)
      return true;

    // If audit has not passed, check if audit period has expired
    if (
      proposal.auditRequired &&
      proposal.submittedAt + auditExpirationPeriodInSeconds <= block.timestamp
    ) return true;

    // If audit is passed, check if general vote is expired
    if (
      !proposal.auditRequired &&
      proposal.auditFinishedAt + proposalGeneralVoteExpirationPeriodInSeconds <
      block.timestamp
    ) return true;

    return false;
  }
}
