// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

contract Counter {
    uint256 public number;

    function setNumber(uint256 num) public {
        number = num;
    }

    function increment() public returns (uint256) {
        return number++;
    }
}
