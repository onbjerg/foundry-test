// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

contract FailingSetup {
    event Test(uint256 n);

    function setUp() public {
        emit Test(42);
        require(false, "we failed");
    }
}
