// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import "ds-test/test.sol";

contract FuzzTest is DSTest {
  constructor() public {
    emit log("constructor");
  }

  function setUp() public {
    emit log("setUp");
  }

  function testFailFuzz(uint128 a, uint128 b) public {
    emit log("testFailFuzz");
    assert(false);
  }

  function testSuccessfulFuzz(uint128 a, uint128 b) public {
    emit log("testSuccessfulFuzz");
    assertEq(uint256(a) + uint256(b), uint256(a) + uint256(b));
  }
}
