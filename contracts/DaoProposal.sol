//SPDX-License-Identifier: MIT License
pragma solidity ^0.8.0;

import "hardhat/console.sol";

import "./DaoMembershipFee.sol";

contract DaoProposal is DaoMembershipFee {
  struct DaoStake {
    uint128 amount;
    uint128 startTime;
  }

  mapping(address => DaoStake) internal stakedTokens;
  uint256 internal totalStaked;

  constructor(string memory _name, string memory _symbol)
    DaoMembershipFee(_name, _symbol)
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
   * @notice Remove a propoal if it has not executed already.
   */
  function removeProposeSmartContract(address _proposalContractAddress)
    external
    onlyMembers
  {}

  // TODO: BRING PROPOSAL TO VOTE IF IT THE START DATE IS GOOD.

  /**
   * @notice All votes are public. DAO members should never disclose their DAO wallet ownership.
   *         Votes are weighed by the time tokens are staked for. Votes that are staked longer has a max weight.
   *         Proposal is instantly approved or denied when the last required vote is cast.
   */
  function voteOnProposal(address _proposalContractAddress, bool _approve)
    external
    onlyMembers
  {}

  /**
   * @notice A proposal is denied when it is expired or voting threshold passed to disapprove.
   * @dev Return any funds committed to the treasury
   */
  function _executeProposal(address _proposalContractAddress)
    private
    onlyMembers
  {}

  /**
   * @notice A proposal is denied when it is expired or voting threshold passed to disapprove.
   * @dev Return any funds committed to the treasury
   */
  function _denyProposal(address _proposalContractAddress)
    private
    onlyMembers
  {}
}
