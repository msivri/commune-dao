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
  

  constructor(string memory _name, string memory _symbol)
    ERC721(_name, _symbol)
  {}
}
