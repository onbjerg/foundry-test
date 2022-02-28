// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import "ds-test/test.sol";
import "./Cheats.sol";

contract SignTest is DSTest {
    Cheats constant cheats = Cheats(HEVM_ADDRESS);

    function testUnimplemented() public {
        require(false, "unimplemented");
    }
}
