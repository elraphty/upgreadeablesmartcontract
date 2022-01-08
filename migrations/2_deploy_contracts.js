const { deployProxy } = require('@openzeppelin/truffle-upgrades');

const Kickstart = artifacts.require("Kickstart");
const KickstartFactory = artifacts.require("KickstartFactory");

module.exports = async (deployer) => {   
    const factory = await deployProxy(KickstartFactory, { deployer });
    const kickstart = await deployProxy(Kickstart, [100, '0x0000000000000000000000000000000000000000'], { deployer });
};