// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721.sol";
contract NFTMarketplace {
//Déploiement x
  NftContract[] public NftInstance;
  function createNftContract(string memory _newName, string memory _newSymbol, string memory _baseURI) public {
    NftContract NftChildInstance = new NftContract(_newName,_newSymbol,_baseURI);
    NftInstance.push(NftChildInstance);
  }

    function getInstanceDeployed(uint256 _idContract) public view returns(NftContract) {
    return NftInstance[_idContract];
    }

    function getBaseURI(uint256 _idInstanceDeployed) public view returns(string memory){
       NftContract NftChildInstanceDeployed = NftInstance[_idInstanceDeployed];
      return  NftChildInstanceDeployed.URI();
    }

    function getOwnerContract(uint256 _idInstanceDeployed) public view returns(address)
    {
         NftContract NftChildInstanceDeployed = NftInstance[_idInstanceDeployed];
         return NftChildInstanceDeployed.ownerContract();
    }
    
}
//shiba, shib, https://ipfs.io/