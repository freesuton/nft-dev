// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/String.sol";

contract SuperMarioWorldCollection is ERC1155, Ownable {

    string public name;
    string public symbol;
    uint256 public tokenCount;

    constructor(string memory _name, string memory _symbol, string memory _baseUri){

    }
}