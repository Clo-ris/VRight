// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleVotingDApp {
    struct Proposal {
        string description;
        uint voteCount;
    }

    address public owner;
    Proposal[] public proposals;
    mapping(address => bool) public voters;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier hasNotVoted() {
        require(!voters[msg.sender], "You have already voted");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function createProposal(string memory description) public onlyOwner {
        proposals.push(Proposal({
            description: description,
            voteCount: 0
        }));
    }

    function vote(uint proposalIndex) public hasNotVoted {
        require(proposalIndex < proposals.length, "Invalid proposal index");
        proposals[proposalIndex].voteCount += 1;
        voters[msg.sender] = true;
    }

    function getProposal(uint proposalIndex) public view returns (string memory description, uint voteCount) {
        require(proposalIndex < proposals.length, "Invalid proposal index");
        Proposal storage proposal = proposals[proposalIndex];
        return (proposal.description, proposal.voteCount);
    }

    function getProposalsCount() public view returns (uint) {
        return proposals.length;
    }
}
