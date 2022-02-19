// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import "ds-test/test.sol";

contract DSStyle is DSTest {
    function testFailingAssertions() public {
        emit log_string("assertionOne");
        assertEq(1, 2);
        emit log_string("assertionTwo");
        assertEq(3, 4);
        emit log_string("done");
    }
}
