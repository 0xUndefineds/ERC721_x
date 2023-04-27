// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;// Integre par défauts les vérifications de débordements pour les opération arithmétiques tel que les entiers
import "./IERC721Receiver.sol";
import  "./IERC721.sol";
contract NftContract is IERC721 {

        string private _name;
        string private _symbol;
        string private _baseURI;
        uint private  _currentTokenId = 0 ;
        address public  ownerContract = msg.sender;
        mapping(address => uint256) private _balances; // _balances[0x5B38] = 1
        mapping(uint256 => address) private _owners;  // _owner[1] = 0x5B38
        mapping(uint256 => address) private _tokenApprovals; //_tokenApprovals[1] = 0xAEFA
        mapping(uint256 => string)  private _tokenURIs; // 1 = "https://metadata.com/tokens/Orax/1"
        mapping(address => mapping(address => bool)) private _operatorApprovals; // [0xOwner][0xTransferer]=true 

        event ownerContractTransferred(address indexed previousOwner, address indexed newOwner);
        //shiba, shib, https://shib.metadata.fr/
        constructor(string memory name_, string memory symbol_, string memory baseURI_) 
        {
                _name = name_;
                _symbol = symbol_;
                _baseURI = baseURI_;

        }
    function supportsInterface(bytes4 interfaceId) public  pure override(IERC165) returns (bool) {
        return interfaceId == type(IERC721).interfaceId || interfaceId == type(IERC165).interfaceId;
    }
        function mint(address to, string memory _tokenURI) public onlyOwner {
               
                _owners[_currentTokenId] = to;
                _balances[to] = _balances[to] + 1 ;
                _tokenURIs[_currentTokenId] = _tokenURI;
                emit Transfer(address(0),to,_currentTokenId);
                 _currentTokenId = _currentTokenId+1;
                

        }


        function balanceOf(address owner) view public override returns(uint256) 
        {
                require(owner != address(0),"Addresse Invalide !");
                return _balances[owner];
        }


        function ownerOf(uint256 tokenId) public override view returns(address) 
        {
                return _owners[tokenId];
        }


        bytes4 private constant _ERC721_RECEIVED = bytes4(keccak256("onERC721Received(address,address,uint256,bytes)")); //Indique qu'on apte à recevoir des nft
        function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public override
        {
                transferFrom(from, to, tokenId);
                if (_isContract(to))
                {
                        bytes4 retval = IERC721Receiver(to).onERC721Received(msg.sender, from, tokenId, _data);
                        require(retval == _ERC721_RECEIVED, "ERC721: transfer to non ERC721Receiver implementer");
                }
        }


        function safeTransferFrom(address from, address to, uint256 tokenId) public override
        {
                safeTransferFrom(from, to, tokenId, "");
        }


        function transferFrom(address from, address to, uint256 tokenId) public override
        { 
                require(_owners[tokenId] == msg.sender || _tokenApprovals[tokenId] == msg.sender || _operatorApprovals[from][msg.sender],"Vous etes pas le mec attendu pour transferer le NFT" ); 
                _transfer(from,to,tokenId); 
        }

        function _transfer(address from,address to,uint tokenId) internal
        { 
                require(_owners[tokenId] == from, "Le mec ne possede pas ce NFT, donc il ne peut pas le transferer a l autre addresse") ;
                require(to!= address(0));
                _balances[from] = _balances[from]-1; 
                _balances[to] = _balances[to]+1; 
                _owners[tokenId]=to;
                emit Transfer(from,to,_currentTokenId);
        }

        function approve(address to, uint tokenId) public override 
        { 
            require(msg.sender == _owners[tokenId],"Vous n etes pas le owner du NFT pour approuver cela"); 
            _tokenApprovals[tokenId] =  to; 
             emit Approval(msg.sender,to,tokenId); 
        }        

       function getApproved(uint256 tokenID) public override view returns(address) 
        {
                return _tokenApprovals[tokenID];
        }

        function setApprovalForAll(address operator, bool _approved) public override 
        {
            require(operator != msg.sender, " Sa sert de les approuver vous meme, metter quelqun a qui vous voulez les approuver"); 
            _operatorApprovals[msg.sender][operator] = _approved; 
             emit ApprovalForAll(msg.sender, operator, _approved);
        }

        function isApprovedForAll(address owner, address operator) public override view returns(bool){ 
                return _operatorApprovals[owner][operator];
        }

        modifier onlyOwner() {
                require(msg.sender==ownerContract,"Uniquement le createur du contrat intelligent peut minter le nft");
                _;
        }

        function name() view public returns(string memory){ 
                return _name;
        }

        function symbol() view public returns(string memory) 
        {
                return _symbol;
        }
        function URI() view public  returns(string memory){ 
                return _baseURI;
        }

        function renonceOwnerContract() onlyOwner public onlyOwner{
                emit ownerContractTransferred(ownerContract,address(0));
                ownerContract = address(0);
        }

        function tokenURI(uint256 tokenId) public view returns(string memory){
                require(_exist(tokenId), "Le Token n'existe pas ! ");
                return string(abi.encodePacked(_baseURI,_tokenURIs[tokenId]));
        }

 
        function _exist(uint256 tokenId) view internal returns(bool){ 
                require(_owners[tokenId] != address(0));
                return true;
        }

        function setBaseURI(string memory baseURI_) public onlyOwner{
                _baseURI = baseURI_;
        }

        function _isContract(address to) internal view returns (bool) 
        {
         uint256 codeSize;
                assembly {
                                codeSize := extcodesize(to)
                        }
                return codeSize > 0;
        }               
}
//0x88E9bB8bc640546e5Bb29f775AC48A7E8a85076B,ipfs/bafkreibxkhxg4paka5nb2522m7lrkkplqwzgfeamcbeuzwocwv4kjl4mpa

//image :  https://ipfs.io/ipfs/bafybeia4qtdvt4n24jrdzxve3jrloxlbfbddhpgaxjttclaf76r7rtnizm
//JSON :   https://ipfs.io/ipfs/bafkreibxkhxg4paka5nb2522m7lrkkplqwzgfeamcbeuzwocwv4kjl4mpa

// shiba, shib, https://ipfs.io/  from 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,1

//Approve
// {0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB,1}


//setApprovalForAll
// {0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB,true} => Cette utilisateur est approuvé a transferer toutes les NFT


//setApprovalForAll par Attaquant via 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
// {0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB,true} => Cette utilisateur est approuvé a transferer toutes les NFT


//isApprovedForAll (Lecture)
// {0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB} => Cette utilisateur est approuvé a transferer toutes les NFT


//TransferFrom
// {0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2,1} via { 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB } 


//SafeTransferFrom - Le deuxième
// {    0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, 0xf8e81D47203A594245E36C48e151709F0C19fBe8, 1, 0x   } 


