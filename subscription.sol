// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

contract Subscription {
    address public owner;
    uint256 public price;
    uint256 public duration;

    mapping(address => uint256) public expiry;

    event Subscribed(address indexed user, uint256 newExpiry);
    event Withdrawn(address indexed owner, uint256 amount);

    constructor(uint256 _price, uint256 _duration) {
        owner = msg.sender;
        price = _price;
        duration = _duration;
    }

    function subscribe() external payable {
        require(msg.value == price, "Invalid payment");

        if (expiry[msg.sender] > block.timestamp) {
            expiry[msg.sender] += duration;
        } else {
            expiry[msg.sender] = block.timestamp + duration;
        }

        emit Subscribed(msg.sender, expiry[msg.sender]);
    }

    function isActive(address _user) public view returns (bool) {
        return expiry[_user] > block.timestamp;
    }

    function withdraw() external {
        require(msg.sender == owner, "Not owner");

        uint256 balance = address(this).balance;
        require(balance > 0, "No funds");

        (bool success, ) = owner.call{value: balance}("");
        require(success, "Withdraw failed");

        emit Withdrawn(owner, balance);
    }
}
