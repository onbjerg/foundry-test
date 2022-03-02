// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import "ds-test/test.sol";
import "./Cheats.sol";

contract Victim {
    function assertCallerAndOrigin(
        address expectedSender,
        string memory senderMessage,
        address expectedOrigin,
        string memory originMessage
    ) public {
        require(msg.sender == expectedSender, senderMessage);
        require(tx.origin == expectedOrigin, originMessage);
    }
}

contract ConstructorVictim is Victim {
    constructor(
        address expectedSender,
        string memory senderMessage,
        address expectedOrigin,
        string memory originMessage
    ) public {
        require(msg.sender == expectedSender, senderMessage);
        require(tx.origin == expectedOrigin, originMessage);
    }
}

contract PrankTest is DSTest {
    Cheats constant cheats = Cheats(HEVM_ADDRESS);

    function testPrankSender(address sender) public {
        // Perform the prank
        Victim victim = new Victim();
        cheats.prank(sender);
        victim.assertCallerAndOrigin(
            sender,
            "msg.sender was not set during prank",
            tx.origin,
            "tx.origin invariant failed"
        );

        // Ensure we cleaned up correctly
        victim.assertCallerAndOrigin(
            address(this),
            "msg.sender was not cleaned up",
            tx.origin,
            "tx.origin invariant failed"
        );
    }

    function testPrankOrigin(address sender, address origin) public {
        address oldOrigin = tx.origin;

        // Perform the prank
        Victim victim = new Victim();
        cheats.prank(sender, origin);
        victim.assertCallerAndOrigin(
            sender,
            "msg.sender was not set during prank",
            origin,
            "tx.origin was not set during prank"
        );

        // Ensure we cleaned up correctly
        victim.assertCallerAndOrigin(
            address(this),
            "msg.sender was not cleaned up",
            oldOrigin,
            "tx.origin was not cleaned up"
        );
    }

    function testPrankConstructorSender(address sender) public {
        cheats.prank(sender);
        ConstructorVictim victim = new ConstructorVictim(
            sender,
            "msg.sender was not set during prank",
            tx.origin,
            "tx.origin invariant failed"
        );

        // Ensure we cleaned up correctly
        victim.assertCallerAndOrigin(
            address(this),
            "msg.sender was not cleaned up",
            tx.origin,
            "tx.origin invariant failed"
        );
    }

    function testPrankConstructorOrigin(address sender, address origin) public {
        address oldOrigin = tx.origin;

        // Perform the prank
        cheats.prank(sender, origin);
        ConstructorVictim victim = new ConstructorVictim(
            sender,
            "msg.sender was not set during prank",
            origin,
            "tx.origin was not set during prank"
        );

        // Ensure we cleaned up correctly
        victim.assertCallerAndOrigin(
            address(this),
            "msg.sender was not cleaned up",
            tx.origin,
            "tx.origin was not cleaned up"
        ); 
    }

    function testPrankStartStop(address sender, address origin) public {
        address oldOrigin = tx.origin;

        // Perform the prank
        Victim victim = new Victim();
        cheats.startPrank(sender, origin);
        victim.assertCallerAndOrigin(
            sender,
            "msg.sender was not set during prank",
            origin,
            "tx.origin was not set during prank"
        );
        victim.assertCallerAndOrigin(
            sender,
            "msg.sender was not set during prank (call 2)",
            origin,
            "tx.origin was not set during prank (call 2)"
        );
        cheats.stopPrank();

        // Ensure we cleaned up correctly
        victim.assertCallerAndOrigin(
            address(this),
            "msg.sender was not cleaned up",
            oldOrigin,
            "tx.origin was not cleaned up"
        ); 
    }

    function testPrankStartStopConstructor(address sender, address origin) public {
        address oldOrigin = tx.origin;

        // Perform the prank
        cheats.startPrank(sender, origin);
        ConstructorVictim victim = new ConstructorVictim(
            sender,
            "msg.sender was not set during prank",
            origin,
            "tx.origin was not set during prank"
        );
        new ConstructorVictim(
            sender,
            "msg.sender was not set during prank (call 2)",
            origin,
            "tx.origin was not set during prank (call 2)"
        );
        cheats.stopPrank();

        // Ensure we cleaned up correctly
        victim.assertCallerAndOrigin(
            address(this),
            "msg.sender was not cleaned up",
            tx.origin,
            "tx.origin was not cleaned up"
        );
    }

    function testPrankComplex() public {
        require(false, "unimplemented");
    }
}
