// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {DSTest} from "ds-test/test.sol";
import {Hevm} from "./utils/Hevm.sol";
import "../Greeter.sol";

contract GreeterTest is DSTest {
    Hevm internal immutable hevm = Hevm(HEVM_ADDRESS);
    Greeter greeter;

    function setUp() public {
        greeter = new Greeter("gm");
    }

    function testAlwaysPassing() public {
        greeter.greet("gm");
    }

    function testAlwaysFailing() public {
        greeter.greet("gn");
    }
}
