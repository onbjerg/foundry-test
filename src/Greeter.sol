// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

/**
 * @title Greeter
 * @notice Greets people.
 *
 * Greet the greeters greeting the greets.
 */
contract Greeter {
    /**
     * @dev Thrown when someone greets with the wrong greeting.
     */
    error IncorrectGreeting(
        string actual,
        string expected
    );

    /**
     * @notice Emitted when someone is greeted.
     * @dev The greeting matches the correct greeting at the time.
     */
    event Greeted(
        address greeter,
        string greeting
    );

    /**
     * @notice The correct greeting.
     * @dev The greeting is immutable and set at the time of
     * construction.
     */
    string public immutable greeting;

    constructor(string memory _greeting) {
        greeting = _greeting;
    }

    /**
     * @notice Greet the contract.
     * @dev Returns the correct greeting.
     *
     * Revert with [IncorrectGreeting] if the user provides the wrong greeting.
     * Emits {Greeter~Greeted} if the greeting is correct.
     */
    function greet(string memory _greeting) public returns (string memory) {
        if (keccak256(abi.encode(_greeting)) != keccak256(abi.encode(greeting))) {
            revert IncorrectGreeting(_greeting, greeting);
        }

        emit Greeted(msg.sender, _greeting);
        return greeting;
    }
}
