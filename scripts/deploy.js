
const {ethers} = require("hardhat");

async function main(){

  //1st to do is to get a compiled contract
  const SuperMarioWorld = await ethers.getContractFactory("SuperMarioWorld");
  const superMarioWorld = await SuperMarioWorld.deploy("Alaska SeaLife Center", "ASC");

  await superMarioWorld.deployed();
  console.log("Success! Contract was deployed to: ", superMarioWorld.address);

  await superMarioWorld.mint("https://ipfs.io/ipfs/QmZRpUvBFmrHruBAKasN2zTuVrYgNiXQ7kTtZ36eHvnLVm");

  console.log("NFT successfully minted");
}
// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
