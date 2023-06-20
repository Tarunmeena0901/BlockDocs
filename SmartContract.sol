// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;


interface IPFS {
    function add(bytes memory data) external returns (bytes32);
    function cat(bytes32 hash) external view returns (bytes memory data);

}


contract HomePage {
    IPFS ipfs;
    mapping(bytes32 => address) pdfOwners;
    mapping(address => bytes32) PdfHash;
    event PdfStored(address _from , bytes32 _Filehash);
    
    constructor(IPFS _ipfs) {
        ipfs = _ipfs;
    }
function uploadFile(bytes memory pdf) external returns (bytes32) {
        bytes32 ipfsHash = ipfs.add(pdf);
        return ipfsHash;
    }

     function storePDFHash(bytes32 ipfsHash) public { 
    PdfHash[msg.sender] = ipfsHash;
    emit PdfStored(msg.sender, ipfsHash);
}
    
    
    
    function getFileOwner(bytes32 ipfsHash) external view returns (address) {
        return pdfOwners[ipfsHash];
    }

     function downloadFile(bytes32 ipfsHash) external view returns (bytes memory) {
        require(pdfOwners[ipfsHash] == msg.sender, "Only file owner can download the file");
        return ipfs.cat(ipfsHash);
    }

}





