//SPDX-License-Identifier: MIT License
pragma solidity ^0.8.0;

import "hardhat/console.sol";

import "./DaoAccessModifiers.sol";

contract DaoMembershipFee is DaoAccessModifiers {
  /** Error Codes */
  uint256 public membershipFee = 0.01 ether;

  constructor(string memory _name, string memory _symbol) DaoAccessModifiers(_name, _symbol) {}

   /**
   * @notice Propose to change membership fee
   */
  function proposeToChangeMembershipFee(uint256 _membershipFee)
    external
    onlyMembers
  {


  }

}
