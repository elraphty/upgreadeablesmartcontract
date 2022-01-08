const { upgradeProxy } = require('@openzeppelin/truffle-upgrades');

const KickstartFactory = artifacts.require("KickstartFactory");
const KickstartFactoryV2 = artifacts.require("KickstartFactoryV2");

module.exports = async (deployer) => {   
    const existing = await KickstartFactory.deployed();
    console.log('Existing Address ===', existing.address);

    const instance = await upgradeProxy(existing.address, KickstartFactoryV2, { deployer });
    console.log("Upgraded Address ===", instance.address);
};
