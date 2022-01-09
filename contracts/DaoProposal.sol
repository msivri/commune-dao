//SPDX-License-Identifier: MIT License
pragma solidity ^0.8.0;

import "hardhat/console.sol";

import "./DaoConfig.sol";

/**
 *  Handles all the proposal and voting logic
 */
contract DaoProposal is DaoConfig {
  /**
   *  Stake Setup
   */
  struct DaoStake {
    uint128 amount;
    uint128 startTime;
  }

  /**
   *  Track who is staking and how much.
   */
  mapping(address => DaoStake) internal memberToStakedTokens;
  /**
   *  Track total staked.
   */
  uint256 internal totalStaked;

  /**
   *  Track who voted to prevent multiple voting
   */
  mapping(address => mapping(address => bool)) internal auditorVotedOnProposal;
  mapping(address => mapping(address => bool)) internal memberVotedOnAuditor;
  mapping(address => mapping(address => bool)) internal memberVotedOnProposal;

  /**
   *  Proposal
   */
  struct Proposal {
    address author;
    address smartContract;
    bool auditPassed;
    bool auditRequired;
    bool approved;
    bool denied;
    bool banned;
    bool isRemovedByAuthor;
    uint256 fundsRequired;
    uint256 fundsDeposited;
    uint256 auditFinishedAt;
    uint128 submittedAt;
    uint128 expireAt;
    uint64 auditYesVotes;
    uint64 auditNoVotes;
    uint64 generalYesVotes;
    uint64 generalNoVotes;
  }
  mapping(address => Proposal) internal proposals;

  constructor(string memory _name, string memory _symbol)
    DaoConfig(_name, _symbol)
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
   * @notice Queues a propoal
   */
  function proposeSmartContract(address _proposalContractAddress)
    external
    onlyMembers
  {}

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

  // TODO: BRING PROPOSAL TO VOTE IF IT THE START DATE IS GOOD.

  /**
   * @notice All votes are public. DAO members should never disclose their DAO wallet ownership.
   *         Votes are weighed by the time tokens are staked for. Votes that are staked longer has a max weight.
   */
  function voteOnProposal(address _proposalContractAddress, bool _approve)
    external
    onlyMembers
  {}

  /**
   * @notice Proposal can be only executed by the approved proposal.
   * @dev Execute proposal.
   */
  function executeProposal(address _proposalContractAddress)
    external
    onlyApprovedProposal
  {}

  /**
   * @notice A proposal is denied when it is expired or voting threshold passed to disapprove.
   * @dev Return any funds committed to the treasury
   */
  function banProposalAuthor(address _proposalContractAddress)
    private
    onlyMembers
  {}

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
