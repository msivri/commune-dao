//SPDX-License-Identifier: MIT License
pragma solidity ^0.8.0;

import "hardhat/console.sol";

import "./DaoProposal.sol";

contract Dao is DaoProposal {
  /** Error Codes */
  string public constant INCORRECT_FEE_AMOUNT = "50001";
  string public constant NO_TOKEN_TO_RECLAIM = "50002";
  string public constant INVALID_AMOUNT_TO_STAKE = "50003";
  string public constant INVALID_AMOUNT_TO_LEAVE_STAKE = "50004";

  constructor(string memory _name, string memory _symbol)
    DaoProposal(_name, _symbol)
  {}

  /**
   * @notice Mint DAO Token
   */
  function joinDAO() external payable {
    require(msg.value == membershipFee, INCORRECT_FEE_AMOUNT);
    uint256 id = totalSupply() + 1;
    _beforeTokenTransfer(address(0), msg.sender, id);
    _mint(msg.sender, id);
  }

  /**
   * @notice If someone left the DAO, the tokens are up for grabs.
   */
  function reclaimDAO(uint256 _amount) external payable {
    // Staked tokens are not up for grabs
    require(
      balanceOf(address(this)) - totalStaked >= _amount,
      NO_TOKEN_TO_RECLAIM
    );
    // TODO: Should membership fee change based on total equity? (fee * total_tokens / equity)
    require(msg.value == membershipFee, INCORRECT_FEE_AMOUNT);

    // Move tokens from this contract to sender
    for (uint256 i = 0; 0 < _amount; i++) {
      uint256 id = tokenOfOwnerByIndex(address(this), i);
      _beforeTokenTransfer(address(this), msg.sender, id);
      _transfer(address(this), msg.sender, id);
    }
  }

  /**
   * @notice Only a member can leave the DAO.s
   *         Leaving DAO sends tokens back to the contract and withdraws all funds.
   */
  function leaveDAO() external onlyMembers {
    uint256 balance = balanceOf(msg.sender);

    for (uint256 i = 0; 0 < balance; i++) {
      uint256 id = tokenOfOwnerByIndex(msg.sender, i);
      _beforeTokenTransfer(msg.sender, address(this), id);
      _transfer(msg.sender, address(this), id);
    }

    // TODO: Test for re-enterancy
    if (balance > 0) {
      // TODO: Withdraw cut
    }

    // Check if any tokens are staked
    DaoStake storage senderStake = stakedTokens[msg.sender];
    if (senderStake.amount > 0) {
      totalStaked -= senderStake.amount;
      senderStake.amount = 0;
    }
  }

  /**
   * @notice Staking allows voting on proposals and submitting proposals.
   * @dev Transfers token to this contract to stake tokens.
   */
  function stake(uint256 _amount) external onlyMembers {
    uint256 balance = balanceOf(msg.sender);
    require(balance >= _amount, INVALID_AMOUNT_TO_STAKE);

    for (uint256 i = 0; 0 < _amount; i++) {
      uint256 id = tokenOfOwnerByIndex(msg.sender, i);
      _beforeTokenTransfer(msg.sender, address(this), id);
      _transfer(msg.sender, address(this), id);
    }

    // Stake token after transfer
    DaoStake storage senderStake = stakedTokens[msg.sender];
    senderStake.amount += uint128(_amount);
    if (senderStake.startTime == 0) {
      senderStake.startTime = uint128(block.timestamp);
    }
    totalStaked += _amount;
  }

  /**
   * @notice Member can remove some or all tokens from staking. Removing all tokens resets membership timer.
   * @dev Transfers token to msg.sender if any of its tokens are staked.
   */
  function leaveStake(uint256 _amount) external onlyMembers {
    DaoStake storage senderStake = stakedTokens[msg.sender];
    require(senderStake.amount >= _amount, INVALID_AMOUNT_TO_LEAVE_STAKE);

    // Reduce staked amount
    senderStake.amount -= uint128(_amount);
    totalStaked -= _amount;
    if (senderStake.amount == 0) {
      senderStake.startTime = 0;
    }

    // Move tokens to owner
    for (uint256 i = 0; 0 < _amount; i++) {
      uint256 id = tokenOfOwnerByIndex(address(this), i);
      _beforeTokenTransfer(address(this), msg.sender, id);
      _transfer(address(this), msg.sender, id);
    }
  }
}
