# Solidity Upgredeable Smart Contract

### This is a solidity upgradeable smart contract  built with truffle anf open zeplin

## To run
 - Make sure u have nodejs and npm installed
 - Install truffle globally `npm install truffle -g` or locally npm install truffle in the project root directory
 - And also have ganache desktop or ganache-cli installed
 - Run npm install to install dependencies


## Truffle commands
 - truffle compile // for compiling the contracts
 - truffle migrate // for contract migration
 - truffle console // to get access to truffle console


In the truffle console run this commands to test the deployed contracts

```
   // This will create KicstartFactory contract instance
   let factory = await KickstartFactory.deployed()

   // Create a new kickstart campaign
   factory.createCampaign(100)

   // Get the created campaign
   factory.getDeployedCampaigns()

   // Copy the address in the campaign list
   // Create a kickstart instance by running this command
    
   let kickstart = await Kickstart.deployed('0x11924C6967680124814fe7bFE0EB4a352CEB9Ef6')
   // Replace the address with the address copied from the campaign list`
```
