
const {ethers} = require("hardhat");

async function main(){

  //1st to do is to get a compiled contract
  const AnimalWorld = await ethers.getContractFactory("AnimalWorldCollection");
  //it is important to keep a / in the end
  const animalWorld = await AnimalWorld.deploy(
      "SuperMarioWorldCollection",
      "SPWC",
      "https://ipfs.io/ipfs/QmSeMaCMfnZyoYgJ6ws132oppLxSPfG7d4t4kw6RmKKkn3/"
  );
  await animalWorld.deployed();
  console.log("Success! Contract was deployed to: ", animalWorld.address);

  // we don't need url anymore
  // await animalWorld.mint("https://ipfs.io/ipfs/QmSeMaCMfnZyoYgJ6ws132oppLxSPfG7d4t4kw6RmKKkn3");
  // await animalWorld.mint(3);
  await animalWorld.mint(2);
  await animalWorld.mint(1);

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
