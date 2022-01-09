//SPDX-License-Identifier: MIT License
pragma solidity ^0.8.0;

import "hardhat/console.sol";

import "./DaoProposal.sol";

/**
 *  @dev Handles all the proposal and voting logic
 */
contract DaoProposalAuditor is DaoProposal {
  /**
   *  @dev Proposal auditor candidates are tracked outside of the proposal
   */
  mapping(address => address[]) internal proposalAuditorCandidates;
  /**
   *  @dev Candidate count is used to iterate through candidates to calculate total votes and tally up the top candidates
   */
  mapping(address => uint256) internal proposalAuditorCandidateCount;
  /**
   *  @dev Candidate vote count to tally up the top candidates.
   */
  mapping(address => mapping(address => uint256))
    internal proposalAuditorCandidateVotes;
  /**
   *  @dev Candidate social
   */
  mapping(address => mapping(address => string))
    internal proposalAuditorCandidateSocial;
  /**
   *  @dev Check if member voted for candidate
   */
  mapping(address => mapping(address => bool))
    internal proposalMemberVotedForAuditor;
  /**
   *  @dev Check if member voted for candidate
   */
  mapping(address => mapping(address => bool)) internal proposalHasAuditor;
  /**
   *  @dev Check if member voted for candidate
   */
  mapping(address => mapping(address => bool))
    internal proposalAuditorVotedForProposal;
  /**
   *  @dev Check if member voted for candidate
   */
  mapping(address => mapping(address => bool))
    internal proposalAuditorVotedForBan;

  constructor(string memory _name, string memory _symbol)
    DaoProposal(_name, _symbol)
  {}

  /**
   * @notice To ban the proposal author, auditors must vote.
   * @dev Ban proposal author
   */
  function applyToBeAuditor(
    address _proposalContractAddress,
    string memory _social
  ) external onlyMembers {
    require(
      proposalAuditorCandidateVotes[_proposalContractAddress][msg.sender] == 0,
      ALREADY_AUDITOR_CANDIDATE
    );

    proposalAuditorCandidateVotes[_proposalContractAddress][msg.sender] = 1;
    proposalAuditorCandidateSocial[_proposalContractAddress][
      msg.sender
    ] = _social;
  }

  /**
   * @notice Auditors are all elected when there are enough candidates with enough yes votes
   * @dev Elect Auditor by voting on one auditor
   */
  function electAuditor(
    address _proposalContractAddress,
    address _candidateAddress
  ) external onlyMembers {
    require(
      !proposalMemberVotedForAuditor[_proposalContractAddress][msg.sender],
      MEMBER_ALREADY_VOTED_FOR_AUDITOR
    );
    // Member is a candidate
    require(
      proposalAuditorCandidateVotes[_proposalContractAddress][
        _candidateAddress
      ] > 0,
      NOT_AN_AUDITOR_CANDIDATE
    );
    Proposal storage proposal = proposals[_proposalContractAddress];
    require(!proposal.auditorsAreReady, AUDITORS_ARE_ALREADY_ELECTED);

    // Record the vote to prevent voting again
    proposalMemberVotedForAuditor[_proposalContractAddress][msg.sender] = true;

    // Increase auditor count

    // Check if all auditors are voted for

    // Mark auditors as ready
    proposal.auditorsAreReady = true;
  }

  /**
   * @notice Auditors only have one vote on the proposal
   * @dev Ban proposal author
   */
  function auditorVoteOnProposal(
    address _proposalContractAddress,
    bool _voteYes
  ) external onlyMembers {
    Proposal storage proposal = proposals[_proposalContractAddress];
    require(proposal.auditorsAreReady, AUDITORS_MUST_BE_READY);
    require(
      !proposalAuditorVotedForProposal[_proposalContractAddress][msg.sender],
      AUDITOR_ALREADY_VOTED_ON_PROPOSAL
    );
    require(
      proposalHasAuditor[_proposalContractAddress][msg.sender],
      IS_NOT_VALID_AUDITOR
    );

    // Prevent from voting again
    proposalAuditorVotedForProposal[_proposalContractAddress][
      msg.sender
    ] = true;

    // Increase vote
    if (_voteYes) proposal.auditYesVotes += 1;
    else proposal.auditNoVotes += 1;

    // Close vote if everyone voted
    if (
      proposal.requiredAuditorCount ==
      proposal.auditNoVotes + proposal.auditYesVotes
    ) {
      if (proposal.auditYesVotes > proposal.auditNoVotes)
        proposal.auditPassed = true;

      proposal.auditRequired = false;
    }
  }

  /**
   * @notice To ban the proposal author, auditors must vote.
   *         They can vote on ban even if they already voted on the proposal.
   *         Banning is not allowed if the proposal audit is already approved.
   * @dev Ban proposal author
   */
  function banProposalAuthor(address _proposalContractAddress)
    external
    onlyMembers
  {
    Proposal storage proposal = proposals[_proposalContractAddress];
    require(proposal.auditorsAreReady, AUDITORS_MUST_BE_READY);
    require(
      !proposalAuditorVotedForBan[_proposalContractAddress][msg.sender],
      AUDITOR_ALREADY_VOTED_ON_PROPOSAL
    );
    require(
      proposalHasAuditor[_proposalContractAddress][msg.sender],
      IS_NOT_VALID_AUDITOR
    );

    proposal.auditBanCount += 1;

    // Ban
    if (proposal.auditBanCount == proposal.requiredAuditorCount) {
      // TODO: take all the tokens away from the proposal author
      proposal.banned = true;
    }
  }
}