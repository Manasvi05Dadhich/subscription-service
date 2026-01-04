// SPDX-License-Identifier: MIT
pragma solidity 0.8.33;

contract Subscription{
    address public user;
    uint256 public price;
    uint256 public duration;

    mapping(address => uint256) public expiry;
    constructor(uint256 _payment, uint256 _duration){
        user= msg.sender;
        price= _payment;
        duration = _duration;
    }

    function subscription() external payable {
        require(msg.value== price, "invalid price");

        if (expiry[msg.sender] > block.timestamp){
            expiry[msg.sender]+= duration;
        }
        else if (expiry[msg.sender] <= block.timestamp){
            expiry[msg.sender]= block.timestamp + duration
        }
    }
}