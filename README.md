# Crowdfunction
This is a Solidity contract for a crowd funding platform. It allows contributors to contribute a minimum amount of 100 wei to the crowd funding campaign, and sets a deadline for the campaign. It also has a target amount that must be reached for the campaign to be successful. The contract tracks the total amount raised and the total number of contributors.

The contract also includes a struct called Request which represents a request for payment from the crowd funding campaign. Each request has a description, a recipient address, a value, a completion status, and a mapping of voters.

The contract has a number of modifiers, which are functions that are used to modify the behavior of other functions. The onlyOwner modifier allows only the owner of the contract to access a function. The isDeadlinePassed modifier checks that the deadline for the crowd funding campaign has not passed before allowing access to a function. The isContributor modifier checks that the caller is a contributor to the crowd funding campaign before allowing access to a function.

The contract has several functions:

getBalance returns the balance of the contract
contribute allows a contributor to contribute to the crowd funding campaign
refund allows a contributor to request a refund if the target is not reached and the deadline has passed
createRequest allows the owner to create a payment request for the crowd funding campaign
voteRequest allows a contributor to vote on a payment request
makePayment allows the owner to make a payment for a request if the number of votes is greater than half of the total contributors

