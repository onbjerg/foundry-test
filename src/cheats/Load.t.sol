// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import "ds-test/test.sol";

contract Storage {
    uint256 slot0 = 10;
}

contract LoadTest is DSTest {
    Cheats constant cheats = Cheats(HEVM_ADDRESS);
    uint256 slot0 = 20;
    Storage storage;

    function setUp() public {
        storage = new Storage();
    }

    function testLoadOwnStorage() public {
        uint val = cheats.load(address(this), bytes32(0));
        assertEq(val, 20, "load failed");
    }

    function testLoadOtherStorage() public {
        uint val = cheats.load(address(storage), bytes32(0));
        assertEq(val, 10, "load failed");
    }
}
