// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import "ds-test/test.sol";

contract Storage {
    uint slot0 = 10;
    uint slot1 = 20;
}

contract StoreTest is DSTest {
    Cheats constant cheats = Cheats(HEVM_ADDRESS);
    Storage storage;

    function setUp() public {
        storage = new Storage();
    }

    function testStore() public {
        assertEq(storage.slot0, 10, "initial value for slot 0 is incorrect");
        assertEq(storage.slot1, 20, "initial value for slot 1 is incorrect");

        cheats.store(address(storage), bytes32(0), 1);
        assertEq(storage.slot0, 1, "store failed");
        assertEq(storage.slot1, 20, "store failed");
    }

    function testStoreFuzzed(uint256 slot0, uint256 slot1) public {
        assertEq(storage.slot0, 10, "initial value for slot 0 is incorrect");
        assertEq(storage.slot1, 20, "initial value for slot 1 is incorrect");

        cheats.store(address(storage), bytes32(0), slot0);
        cheats.store(address(storage), bytes32(1), slot1);
        assertEq(storage.slot0, slot0, "store failed");
        assertEq(storage.slot1, slot1, "store failed"); 
    }
}
