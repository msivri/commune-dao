//SPDX-License-Identifier: MIT License
pragma solidity ^0.8.0;

import "hardhat/console.sol";

import "./DaoErrorCodes.sol";

contract DaoAccessModifiers is DaoErrorCodes { 

  /** State mappings used to track access modifiers  */
  mapping(address => address) internal proposalToAuthor;
  mapping(address => bool) internal approvedProposals; 

  constructor(string memory _name, string memory _symbol)
    DaoErrorCodes(_name, _symbol)
  {}

  /**
   *  @dev Only Non Members
   */
  modifier onlyNonMembers() {
    require(balanceOf(msg.sender) == 0, NO_MEMBERS_ALLOWED);
    _;
  }

  /**
   *  @dev Only Non Members
   */
  modifier onlyMembers() {
    require(balanceOf(msg.sender) > 0, ONLY_MEMBERS_ALLOWED);
    _;
  }


  /** 
   * @dev Only Proposal Author
   */
  modifier onlyProposalAuthor(address _proposalAddress) {
    require(
      proposalToAuthor[_proposalAddress] == msg.sender,
      ONLY_PROPOSAL_AUTHOR
    );
    _;
  }

  /**
   * @notice used for allowing approved proposals to make changes to configurations such as membership fee, increasing member count, etc.
   * @dev Only Approved Proposals
   */
  modifier onlyApprovedProposal() {
    require(approvedProposals[msg.sender], ONLY_APPROVED_PROPOSAL_ALLOWED);
    _;
  }  
}
