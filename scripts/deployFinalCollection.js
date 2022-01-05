
const {ethers} = require("hardhat");

async function main(){

  //1st to do is to get a compiled contract
  const AnimalWorld = await ethers.getContractFactory("AnimalWorld");
  const animalWorld = await AnimalWorld.deploy("Alaska SeaLife Center", "ASC");

  await animalWorld.deployed();
  console.log("Success! Contract was deployed to: ", animalWorld.address);

  await animalWorld.mint("https://ipfs.io/ipfs/QmSpv8P84fwi6XkdFemhzKXJiJxZJsgnWiraWZtvarStLZ");

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
