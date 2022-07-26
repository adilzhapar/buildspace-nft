// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

import "hardhat/console.sol";

// We first import some OpenZeppelin Contracts.
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract MyNFT is ERC721URIStorage{
    // Magic given to us by OpenZeppelin to help us keep track of tokenIds.
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;
  uint256 public constant NFT_AMOUNT = 70;
  uint256 public mintedNFT;
  // We need to pass the name of our NFTs token and its symbol.
  constructor() ERC721 ("KeyboardNFT", "KBD") {
    console.log("This is my NFT contract. Woah!");
  }

  event NewEpicNFTMinted(address sender, uint256 tokenId);
  // A function our user will hit to get their NFT.
  function makeAnEpicNFT() public {


     // Get the current tokenId, this starts at 0.
    uint256 newItemId = _tokenIds.current();
    mintedNFT += 1;
    
    require(mintedNFT <= NFT_AMOUNT, "INVALID_NFT_INDEX");

     // Actually mint the NFT to the sender using msg.sender.
    _safeMint(msg.sender, newItemId);

    // Set the NFTs data.
    _setTokenURI(newItemId, "https://jsonkeeper.com/b/3JDB");
    console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);


    // Increment the counter for when the next NFT is minted.
    _tokenIds.increment();
    emit NewEpicNFTMinted(msg.sender, newItemId);


  }

  function getTotalNFTsMintedSoFar() external view returns (uint256){
    return mintedNFT;
  }
}