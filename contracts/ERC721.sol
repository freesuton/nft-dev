// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract ERC721 {

    //we will want to search it all of these so we add index key word
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
    //searched by owners or operators
    //in order to let people to search through the event logs, we can add variable indexed
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

    mapping(address => uint256) internal _balances;

    mapping(uint256 => address) internal _owners;

    mapping(address => mapping(address => bool)) private _operatorApprovals;

    //when you put an token id, it get out the approved address

    //return the number of NFTs assigned to an owner
    function balanceOf(address owner) public view returns(uint256){
        //error checking is required: it is not a zero address
        require(owner != address(0), "Address is zero");
        return _balances[owner];
    }

    //Return the owner of an NFT
    function owner(uint256 tokenId) public view returns(address){
        address owner = _owners[tokenId];
        require(owner != address(0), "TokenID does not exist");
        return owner;
    }

    //Enable or disables an operator to manage all of msg.senders assets.
    function setApprovalForAll(address operator, bool approved) public{
        _operatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    //Checks if an address is an operator for another address
    function isApprovedForAll(address owner, address operator) public view returns(bool){
        return _operatorApprovals[owner][operator];
    }
    //Updates an approved address for an NFT
    function approve(address to, uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(msg.sender == owner || isApprovedForAll(owner, msg.sender), "Msg.sender is not the owner or an approved operator");
        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    //Gets the approved address for a single NFT
    function getApproved(uint256 tokenId) public view returns(address) {
        require(_owners[tokenId] != address(0), "Token ID does not exist");
        return _tokenApprovals[tokenId];
    }

    // Transfers ownership of an NFT
    function transferFrom(address from, address to, uint256 tokenId) public{
        address owner = ownerOf(tokenId);
        require(
            msg.sender == owner || getApproved(tokenId) == msg.sender || isApprovedForAll(owner, msg.sender),
            "Msg.sender is not the owner or approved for transfer"
        );
        require(owner == from, "From address is not the owner");
        require(to != address(0), "Address is zero");
        require(_owners[tokenId] != address(0), "TokenID does not exist" );
        // because we transfer the nft, we need to clear all previous approvals
        approve(address(0), tokenId);

        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId] = to;

        emit Transfer(from, to, tokenId);
    }

    //standard transferFrom
    //Checks if onERC721Received is implemented WHEN sending to "smart contracts".
    //only check when send to smart contract. wallet address is not required
    // input - _data : an arbitrary data or instructions that we will pass to the on ERC721 receiver function
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public {
        transferFrom(from, to, tokenId);
        require(_checkOnERC721Received(), "Receiver not implemented");
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) public {
        safeTransferFrom(from,to,tokenId,"");
    }

    //Oversimplified for test(should not be this in real environment)
    function _checkOnERC721Received() private pure returns(bool) {
        return true;
    }

    // EIP 165： Query if a contract implements another interface
    function supportsInterface(bytes4 interfaceId) public pure virtual returns(bool){
        return interfacedId == 0x80ac58cd;
    }
}