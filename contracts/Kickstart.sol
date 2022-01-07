// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.2 <0.9.0;

import '@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol';

contract Kickstart is Initializable {

    struct Request   {
      string  description;
      uint value;
      address payable recipient;
      bool complete;
      uint approvalCount;
      mapping(address => bool) approvals;
    }
    
    mapping(uint => Request) public requests;
    mapping(address  => bool) public approvers;

    uint private currentIndex;
    
    address payable public manager;
    uint public minimumContribution;
    uint public approversCount;

    modifier restricted  {
        require(msg.sender == manager);
        _;
    }

    function initialize(uint minimum, address payable creator) public initializer {
        // Set the campaign mamager
        setManager(creator);
        
        // Set the campaign minimum contribution
        setMinimumContribution(minimum);
    }

    function contribute() public payable {
        require(msg.value > minimumContribution, 'To contribute you need to atleast pay minimumContribution ${minimumContribution}');
        
        // if the user has not already been added as an approver
        if(!approvers[msg.sender]) {
            approvers[msg.sender] = true;

            approversCount++;
        }
    }

    function createRequest(string memory description, uint256 value, address payable recipient) external restricted {
        Request storage request = requests[currentIndex];

        request.description = description;
        request.value = value;
        request.recipient = recipient;
        request.complete = false;

        // Set the request approval count to 0
        request.approvalCount = 0;

        currentIndex++;
    }

    function approveRequest(uint indexOfRequest) external {
        Request storage request = requests[indexOfRequest];
        
        // The user must be among the approvers, and must have not approved the request before
        require(approvers[msg.sender]);
        require(!request.approvals[msg.sender]);

        request.approvals[msg.sender] = true;

        // increase the request approval count
        request.approvalCount++;
    }

    // To finalize a request, the appovers count must be more than 50% of the total approvers
    function finalizeRequest(uint indexOfRequest) external restricted {
        Request storage request = requests[indexOfRequest];

        // The approvers count must be greater than half of the approvers
        require(request.approvalCount > (approversCount / 2), "More approvers are needed for finalizing this request");
        require(!request.complete, 'Request is already completed');

        // If successful transfer the eth value to the recipient and set completed to true
        request.recipient.transfer(request.value);
        request.complete = true;
    }

    function getSummary() public view returns (uint, uint, uint, uint, address) {
        return (
          minimumContribution,
          address(this).balance,
          currentIndex,
          approversCount,
          manager
        );
    }
    
    function getRequestsCount() public view returns (uint) {
        return currentIndex;
    }

    /** 
        Getters and Setters
    */
    function setManager(address payable creator) private {
        manager = creator;
    }

    function setMinimumContribution(uint minimum) private {
        minimumContribution = minimum;
    }
}