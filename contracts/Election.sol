// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Election {

    address public owner;
    string public electionName;
    uint public totalVotes;

    mapping(address=>Voter) public voters;
    Candidate[] public candidates;

    struct Candidate{
        string candidateName;
        uint candidateTotalVote;
    }

    struct Voter{
        string voterName;
        uint whomVoterVoted;
        bool isVoterAuthorized;
        bool isVoterVoted;
    }

    modifier onlyOwner(){
        require(owner == msg.sender);
        _;
    }

    // Function to start the election
    function startElection(string memory _electionName) public {
        electionName = _electionName;
        owner = msg.sender;
        totalVotes = 0;
    }

    // Function to add candidate
    function addCandidate(string memory _candidateName) public onlyOwner {
        candidates.push(Candidate({candidateName:_candidateName,candidateTotalVote:0}));
    }

    // Funtion to return a candidate at specific index
    function showCandidateInfo(uint _index) public view returns(Candidate memory){
        return candidates[_index];
    }

    // Function to authorize Voter
    function authorizeVoter(address _voterAddress) public onlyOwner {
        voters[_voterAddress].isVoterAuthorized = true;
    }

    // Function to get number of candidates
    function getCandidatesCount()public view returns(uint){
        return candidates.length;
    }

    // Function to vote
    function vote(uint _whomToVote) public {
        require(voters[msg.sender].isVoterAuthorized);
        require(!voters[msg.sender].isVoterVoted);
        voters[msg.sender].isVoterVoted = true;

        candidates[_whomToVote].candidateTotalVote++;
        totalVotes++;
    }
}