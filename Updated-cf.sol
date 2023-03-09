// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 * @title CrowdFunding
 * @dev Implements a simple crowd funding contract.
 */
contract CrowdFunding {
    address public owner; // owner of the contract
    uint256 public minimumContribution; // minimum contribution required for contributor to do crowd funding.
    uint256 public deadline; // Final Time to do crowdfunding.
    uint256 public target;
    uint256 public raisedAmount; // Keep track of the total raised amount.
    uint256 public totalContributors; // total contributors who have contributed to crowd funding.
    uint256 public numRequests;

    // Request struct stores the information about a payment request.
    struct Request {
        string description; // description of the payment request.
        address payable recipient; // address of the payment recipient.
        uint256 value; // amount to be paid to the recipient.
        bool completed; // indicates whether the payment has been made or not.
        uint256 noOfVoters; // number of contributors who have voted for this request.
        mapping(address => bool) voters; // mapping of contributors who have voted for this request.
    }
    mapping(uint256 => Request) public allRequests; // mapping of payment requests.
    mapping(address => uint256) public contributors; // mapping of contributors and their contribution amounts.

    // Events
    event ContributionReceived(address indexed contributor, uint256 amount);
    event RefundIssued(address indexed refundRecipient, uint256 amount);
    event RequestCreated(string description, address indexed recipient, uint256 value);
    event RequestVoted(uint256 indexed requestNo, address indexed voter);
    event PaymentMade(address indexed recipient, uint256 value);

    // Constructor
    constructor(uint256 _target, uint256 _deadline) {
        owner = msg.sender;
        deadline = block.timestamp + _deadline;
        target = _target;
        minimumContribution = 600 wei;
    }

    // Modifiers
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can access this function.");
        _;
    }

    modifier isDeadlinePassed() {
        require(
            block.timestamp < deadline,
            "Crowd funding deadline has passed. Please try again later."
        );
        _;
    }

    modifier isContributor() {
        require(contributors[msg.sender] > 0, "Sorry, you are not a contributor. Try to contribute to crowd funding then try again. Thanks.");
        _;
    }

    // Public functions
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function contribute() public payable isDeadlinePassed {
        require(
            msg.value >= minimumContribution,
            "Minimum 100 wei is required to contribute."
        );
        if (contributors[msg.sender] == 0) {
            totalContributors++;
        }
        contributors[msg.sender] += msg.value;
        raisedAmount += msg.value;
        emit ContributionReceived(msg.sender, msg.value);
    }

    function refund() public isDeadlinePassed isContributor {
        require(raisedAmount < target, "You are not eligible for refund");
        require(contributors[msg.sender] > 0);
        address payable user = payable(msg.sender);
        uint256 amount = contributors[msg.sender];
        user.transfer(amount);
        contributors[msg.sender] = 0;
        totalContributors--;
        emit RefundIssued(user, amount);
    }

    function createRequest(string memory _description, address payable _recipient, uint256 _value) public onlyOwner {
        Request storage newRequest = allRequests[numRequests++];
            newRequest.recipient = _recipient;
    newRequest.value = _value;
    newRequest.completed = false;
    newRequest.noOfVoters = 0;
    emit RequestCreated(_description, _recipient, _value);
}

function voteRequest(uint256 _requestNo) public isContributor {
    Request storage thisRequest = allRequests[_requestNo];
    require(
        thisRequest.voters[msg.sender] == false,
        "You have already voted for this request."
    );
    thisRequest.voters[msg.sender] = true;
    thisRequest.noOfVoters++;
    emit RequestVoted(_requestNo, msg.sender);
}

function makePayment(uint256 _requestNo) public onlyOwner {
    Request storage thisRequest = allRequests[_requestNo];
    require(
        thisRequest.completed == false,
        "Payment for this request has already been made."
    );
    require(
        (thisRequest.noOfVoters * 100) / totalContributors > 50,
        "At least 50% of contributors need to vote for this request."
    );
    address payable recipient = thisRequest.recipient;
    uint256 value = thisRequest.value;
    recipient.transfer(value);
    thisRequest.completed = true;
    emit PaymentMade(recipient, value);
}
}
