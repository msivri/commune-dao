//SPDX-License-Identifier: MIT License
pragma solidity ^0.8.0;

import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract DaoErrorCodes is ERC721Enumerable {
  /** Error Codes */
  string public constant NO_MEMBERS_ALLOWED = "10001";
  string public constant ONLY_MEMBERS_ALLOWED = "10002";
  string public constant ONLY_APPROVED_PROPOSAL_ALLOWED = "10003";
  string public constant ONLY_PROPOSAL_AUTHOR = "10004";
  string public constant ONLY_AUDITED_PROPOSAL = "10005";
  string public constant ONLY_EXPIRED_PROPOSAL = "10006";
  string public constant ONLY_DENIED_PROPOSAL = "10007";
  string public constant CANNOT_REMOVE_PROPOSAL = "10008";
  string public constant AUDITORS_ARE_ALREADY_ELECTED = "10009";
  string public constant AUDITORS_MUST_BE_READY = "10010";
  string public constant MEMBER_ALREADY_VOTED_FOR_AUDITOR = "10011";
  string public constant NOT_AN_AUDITOR_CANDIDATE = "10012";
  string public constant ALREADY_AUDITOR_CANDIDATE = "10013";
  string public constant AUDITOR_ALREADY_VOTED_ON_PROPOSAL = "10014";
  string public constant IS_NOT_VALID_AUDITOR = "10015";

  constructor(string memory _name, string memory _symbol)
    ERC721(_name, _symbol)
  {}
}
