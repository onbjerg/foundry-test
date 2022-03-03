// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import "ds-test/test.sol";
import "./Cheats.sol";

contract Reverter {
    error CustomError();

    function revertWithMessage(string memory message) public {
        require(false, message);
    }

    function doNotRevert() public {}

    function panic() public returns (uint256) {
        return uint256(100) - uint256(101);
    }

    function revertWithCustomError() public {
        revert CustomError();
    }

    function nestedRevert(Reverter inner, string memory message) public {
        inner.revertWithMessage(message);
    }
}

contract ConstructorReverter {
    constructor(string memory message) public {
        require(false, message);
    }
}

contract ExpectRevertTest is DSTest {
    Cheats constant cheats = Cheats(HEVM_ADDRESS);

    function testExpectRevertString() public {
        Reverter reverter = new Reverter();
        cheats.expectRevert("revert");
        reverter.revertWithMessage("revert");
    }

    function testExpectRevertConstructor() public {
        cheats.expectRevert("constructor revert");
        new ConstructorReverter("constructor revert");
    }

    function testExpectRevertBuiltin() public {
        Reverter reverter = new Reverter();
        cheats.expectRevert(abi.encodeWithSignature("Panic(uint256)", 0x11));
        reverter.panic();
    }

    function testExpectRevertCustomError() public {
        Reverter reverter = new Reverter();
        cheats.expectRevert(abi.encodePacked(Reverter.CustomError.selector));
        reverter.revertWithCustomError();
    }

    function testExpectRevertNested() public {
        Reverter reverter = new Reverter();
        Reverter inner = new Reverter();
        cheats.expectRevert("nested revert");
        reverter.nestedRevert(inner, "nested revert");
    }

    function testFailExpectRevertErrorDoesNotMatch() public {
        Reverter reverter = new Reverter();
        cheats.expectRevert("should revert with this message");
        reverter.revertWithMessage("but reverts with this message");
    }

    function testFailExpectRevertDidNotRevert() public {
        Reverter reverter = new Reverter();
        cheats.expectRevert("does not revert, but we think it should");
        reverter.doNotRevert();
    }

    function testFailExpectRevertDangling() public {
        cheats.expectRevert("dangling");
    }
}
