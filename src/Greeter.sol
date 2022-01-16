// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

contract Greeter {
    error IncorrectGreeting(
        string actual,
        string expected
    );

    event Greeted(
        address greeter,
        string greeting
    );

    string public greeting;

    constructor(string memory _greeting) {
        greeting = _greeting;
    }

    function greet(string memory _greeting) public returns (string memory) {
        if (keccak256(abi.encode(_greeting)) != keccak256(abi.encode(greeting))) {
            revert IncorrectGreeting(_greeting, greeting);
        }

        emit Greeted(msg.sender, _greeting);
        return greeting;
    }
}
