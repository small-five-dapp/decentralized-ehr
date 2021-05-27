# Decentralised Electronic Health Records

## Environment Setup
Make sure that you have a working Node.js `>=12.0` installation.
Install all of the `npm` packages.

Optionally, you can also install `hardhat-shortand` globally to take advantage of
shell autocompletion for tasks.
1. `npm i -g hardhat-shorthand`
2. `hardhat-completion install`

## Directory Structure
The most relevant information will be structured as so:
```
small-five-dapp/
   - contracts/
   - test/
   - hardhat.config.js
```
All of our smart contracts, written in Solidity, will be located in the 
`contract/` directory. Similarly, all of our test scripts will be located 
in the `test/` directory.

## Compiling and Testing
To compile the smart contracts, 
```
npx hardhat compile
```
or if you installed `hardhat-shorthand`, 
```
hh compile
```
To run the suite of tests in `test/`, run
```
npx hardhat test
```
or if you installed `hardhat-shorthand`,
```
hh test
```

## Additional Features
To see all available tasks, run 
```
npx hardhat
```

Then, you can run any of the displayed tasks with
```
npx hardhat <task_name>
```
or 
```
hh <task_name>
```
