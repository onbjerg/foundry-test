// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

contract FailingSetupTest {
    event Test(uint256 n);

    function setUp() public {
        emit Test(42);
        require(false, "setup failed predictably");
    }

    function testShouldNeverBeCalled() public {
        require(false, "setup did not fail");
    }
}
