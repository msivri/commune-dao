//SPDX-License-Identifier: MIT License
pragma solidity ^0.8.0;

import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract DaoAccessModifiers is ERC721 {
  /** Error Codes */
  string public constant NO_MEMBERS_ALLOWED = "10001";
  string public constant ONLY_MEMBERS_ALLOWED = "10002";

  constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {}

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
}
