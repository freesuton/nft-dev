// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/String.sol";

contract SuperMarioWorldCollection is ERC1155, Ownable {

    string public name;
    string public symbol;
    uint256 public tokenCount;
    string public baseUri;

    //instantiate ERC1155
    constructor(string memory _name, string memory _symbol, string memory _baseUri) ERC1155(_baseUri){
        name = _name;
        symbol = _symbol;
        baseUri = _baseUri;
    }

    function mint(uint256 amount) public onlyOwner
    {
        tokenCount += 1;
        _mint(msg.sender, tokenCount, amount, "");
    }
    //"https://game.example/api/item/{id}.json"
    function uri(uint256 _tokenId) override public view returns(string memory) {

        //soldiity is not good at dealing with string . for string concatenation we need abi.encodePacked
        return string(
            abi.encodePacked(
                baseUri, //URL
                Strings.toString(_tokenId), // + Token Id
                ".json" // + Json
            )
        );// URL
    }
}