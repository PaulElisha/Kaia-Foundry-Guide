// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../../src/TestGenerator/TestGenerator.sol";
import "../../src/TestGenerator/abi.json";
import "../../src/TestGenerator/expectedBehaviour.json";

contract GenerateTests is Script {
    TestGenerator generator;

    function run() public {
        generator = new TestGenerator();

        string memory tests = generator.generateTestCases(
            "abi.json",
            "expectedbehaviour,json"
        );

        vm.writeFile("test/GeneratedTests.t.sol", tests);

        console.log("Generated tests written to GeneratedTests.t.sol");
    }
}
