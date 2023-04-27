// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
interface IERC721Receiver {
    function onERC721Received(address operator, address from, uint256 tokenId, bytes calldata data) external returns (bytes4);
}

//0x150b7a02 4 octect de 32 Bits