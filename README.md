# CrowdFunding Contract
This repository contains the Solidity code for a CrowdFunding smart contract. The contract enables users to contribute funds towards a specific goal within a specific deadline. Contributors can also vote on requests to access the funds, and if the majority of the contributors approve the request, the contract owner can make payments to the designated recipient.

## Getting Started
To use the CrowdFunding contract, you will need to have this software installed:

- [Remix IDE](https://remix.ethereum.org/) or any other Ethereum development environment

## Deployment
- Clone the repository to your local environment.
- Compile the contract using the Solidity Compiler.
- Deploy the contract on the Ethereum blockchain using Remix IDE or any other Ethereum development environment.
## Contract Details
The CrowdFunding contract includes the following functionalities:

- `contribute()` - allows contributors to send funds to the contract
- `refund()` - allows contributors to get their funds back if the goal is not reached within the deadline
- `createRequest()` - allows the contract owner to create a request to withdraw funds
- `voteRequest()` - allows contributors to vote on a request to withdraw funds
- `makePayment()` - allows the contract owner to make a payment to the recipient if the request is approved by the majority of the contributors
## Contract Variables
The following variables are defined in the contract:

- `owner` - the address of the contract owner
- `minimumContribution` - the minimum amount required for contributors to participate in the crowdfunding
- `deadline` - the deadline for the crowdfunding campaign
- `target` - the target amount to be raised during the crowdfunding campaign
- `raisedAmount` - the total amount raised by the contributors
- `totalContributors` - the total number of contributors who have participated in the crowdfunding campaign
- `numRequests` - the number of requests created by the contract owner
- `allRequests` - a mapping of request numbers to Request structs
- `contributors` - a mapping of contributor addresses to the amount they have contributed
## Modifiers
The following modifiers are used in the contract:

- `onlyOwner()` - restricts access to a function to the contract owner
- `isDeadlinePassed()` - restricts access to a function after the deadline has passed
- `isContributor()` - restricts access to a function to contributors only
##nRequest Struct
The Request struct contains the following fields:

- `description` - a description of the request
- `recipient` - the address of the recipient of the funds
- `value` - the amount of funds to be transferred to the recipient
- `completed` - a flag indicating whether the request has been completed
- `noOfVoters` - the number of contributors who have voted on the request
- `voters` - a mapping of contributor addresses to a boolean value indicating whether they have voted on the request
## License
This project is licensed under the [MIT license](https://github.com/%3Cyour_github_username%3E/%3Cyour_repository_name%3E/blob/main/LICENSE).
