// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./IERC165.sol";
interface IERC721 is IERC165 {
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId); //ok
    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId); //ok
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);//ok
    function balanceOf(address _owner) external view returns (uint256); //ok
    function ownerOf(uint256 _tokenId) external view returns (address); //ok
    function transferFrom(address _from, address _to, uint256 _tokenId) external;
    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes calldata _data) external; //ok
    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external; //ok
    function approve(address _approved, uint256 _tokenId) external; //ok
    function setApprovalForAll(address _operator, bool _approved) external; //ok
    function getApproved(uint256 _tokenId) external view returns (address); //ok
    function isApprovedForAll(address _owner, address _operator) external view returns (bool);
}
