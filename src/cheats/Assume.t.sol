// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import "ds-test/test.sol";

contract AssumeTest is DSTest {
    Cheats constant cheats = Cheats(HEVM_ADDRESS);

    function testUnimplemented() public {
        require(false, "unimplemented");
    }
}