// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

contract RevertingTest {
    function testFailRevert() public {
        require(false, "should revert here");
    }
}
