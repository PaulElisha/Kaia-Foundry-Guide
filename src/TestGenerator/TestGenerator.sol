// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/StdJson.sol";
import "forge-std/console2.sol";
import "forge-std/Vm.sol";

contract TestGenerator {
    using stdJson for string;

    function generateTestCases(
        string memory abiFilePath,
        string memory jsonFilePath
    ) public view returns (string memory) {
        string memory abiContent = vm.readFile(abiFilePath);
        string memory jsonContent = vm.readFile(jsonFilePath);

        string[] memory functions = abiContent.parseJson(
            ".[] | select(.type == 'function') | .name"
        );

        string memory testCases = "";

        for (uint256 i = 0; i < functions.length; i++) {
            string memory functionName = functions[i];

            string[] memory validInputs = jsonContent.parseJson(
                string(
                    abi.encodePacked(
                        ".functions[?(@.name == '",
                        functionName,
                        "')].expectedBehavior.validInputs"
                    )
                )
            );
            string[] memory invalidInputs = jsonContent.parseJson(
                string(
                    abi.encodePacked(
                        ".functions[?(@.name == '",
                        functionName,
                        "')].expectedBehavior.invalidInputs"
                    )
                )
            );

            for (uint256 j = 0; j < validInputs.length; j++) {
                testCases = string(
                    abi.encodePacked(
                        testCases,
                        "it('should succeed with valid input ",
                        validInputs[j],
                        "', async () => {\n",
                        "    await contract.",
                        functionName,
                        "(",
                        validInputs[j],
                        ");\n",
                        "});\n"
                    )
                );
            }

            for (uint256 k = 0; k < invalidInputs.length; k++) {
                testCases = string(
                    abi.encodePacked(
                        testCases,
                        "it('should revert with invalid input ",
                        invalidInputs[k],
                        "', async () => {\n",
                        "    await expect(contract.",
                        functionName,
                        "(",
                        invalidInputs[k],
                        ")).to.be.reverted;\n",
                        "});\n"
                    )
                );
            }
        }

        return testCases;
    }
}
