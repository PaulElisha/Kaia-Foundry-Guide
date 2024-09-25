## TestGenerator


This tool is designed to help enhance development process. It helps to generate test cases by reading the contract's abi.json file and generates test cases based on function, parameters or function signatures and the expected behaviour. 

It leverages the foundry standard library for parsing external data in json format `StdJson` to extract the functions and the expected behaviours data, which it then uses to generate test cases. 

### Functions

`**generateTestCases**`: This function is used to generate test cases of your smart contract, it leverages the foundry library for parsing in data to 'StdJson' to read an external file in json format, which is the abi and the expected behaviour file to store data on chain in an array called functions.

## Usage

Install using:

```solidity
forge install
```

Import in your script file to and inherit it to generate test cases for your smart contract.

Create a separate file, e.g, `**generatedTest.t.sol**` and write to the file path, your generated test cases.



