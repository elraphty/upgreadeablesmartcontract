// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.2 <0.9.0;

import '@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol';
import "./Kickstart.sol";

contract KickstartFactory is ReentrancyGuardUpgradeable {
    address[] public deployedCampaigns;
    
    // Create a new campaign
    function createCampaign(uint minimum) public nonReentrant {
        address newCampaign = address(new Kickstart(minimum, payable(msg.sender)));
        
        // Deployed campaigns setter
        addDeployedCampaign(newCampaign);
    }
    
    // Get all created campaigns
    function getDeployedCampaigns() public view returns (address[] memory){
        return deployedCampaigns;
    }

    /** Setter functions */
    function addDeployedCampaign(address newCampaign) private {
        deployedCampaigns.push(newCampaign);
    }
}