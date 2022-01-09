# Commune DAO
A DAO that aims to have on-chain proposals audited and approved by the community.



The Commune DAO intends to increase trust and community engagement and automate proposal executions with additional smart contracts.

**If you have suggestions, please open an issue.** *Use at your own risk.*

Each proposal is a smart contract that uses the CommuneDAO proposal interface to interface with the DAO code. The following is the flow:

1. Users may become members by purchasing DAO Tokens.
2. If members stake their tokens, they can submit proposals after a set amount of time, become auditors, and vote on proposals.
3. One token = One vote
4. Members can submit proposals in the form of smart contracts. They must stake ETH in proportion to the requested funds.
5. Members elect auditors per proposal. Every proposal may require different expertise and knowledge. Electing per proposal helps elect authoritative figures to audit the proposal and the associated smart contract.
6. Auditors can approve or deny the proposal. They may also elect to ban the proposal's author. If the proposal's author is banned, the author will lose the staked ETH and all DAO tokens as punishment. 
7. A ban requires unanimous votes. A two-thirds auditor majority must either approve or deny.
8. If approved, the proposal goes to a general vote. The general vote only requires a simple majority.
9. If the general vote approves the proposal, the associated smart contract receives the funds, triggering the smart contract to perform its intended purpose.

# Review Diagram 

![alt text](images/circle-diagram.png?raw=true)

![alt text](images/diagram.png?raw=true)


# Screenshots 

## View all proposals

![alt text](images/screen1.png?raw=true)
## Review a single proposal

![alt text](images/screen2.png?raw=true)
## Apply to be an auditor

![alt text](images/screen3.png?raw=true)
## Vote on a proposal

![alt text](images/screen4.png?raw=true)


# Advanced Sample Hardhat Project

This project demonstrates an advanced Hardhat use case, integrating other tools commonly used alongside Hardhat in the ecosystem.

The project comes with a sample contract, a test for that contract, a sample script that deploys that contract, and an example of a task implementation, which simply lists the available accounts. It also comes with a variety of other tools, preconfigured to work with the project code.

Try running some of the following tasks:

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
npx hardhat help
REPORT_GAS=true npx hardhat test
npx hardhat coverage
npx hardhat run scripts/deploy.js
node scripts/deploy.js
npx eslint '**/*.js'
npx eslint '**/*.js' --fix
npx prettier '**/*.{json,sol,md}' --check
npx prettier '**/*.{json,sol,md}' --write
npx solhint 'contracts/**/*.sol'
npx solhint 'contracts/**/*.sol' --fix
```

# Etherscan verification

To try out Etherscan verification, you first need to deploy a contract to an Ethereum network that's supported by Etherscan, such as Ropsten.

In this project, copy the .env.example file to a file named .env, and then edit it to fill in the details. Enter your Etherscan API key, your Ropsten node URL (eg from Alchemy), and the private key of the account which will send the deployment transaction. With a valid .env file in place, first deploy your contract:

```shell
hardhat run --network ropsten scripts/deploy.js
```

Then, copy the deployment address and paste it in to replace `DEPLOYED_CONTRACT_ADDRESS` in this command:

```shell
npx hardhat verify --network ropsten DEPLOYED_CONTRACT_ADDRESS "Hello, Hardhat!"
```
