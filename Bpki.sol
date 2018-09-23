pragma solidity ^0.4.24;

contract B_Pki{

    struct Signature {
        address signer;
        uint CertNo;
        string Certhash;
        bytes32 Issuedto;
        bytes32 IssuedBy;
   }
  struct Revocation {
        uint signatureID;
        uint RevNo;
        string RevCertHash;
        bytes32 to;
        bytes32 By;
    }
    Signature[] public signatures;
    Revocation[] public revocations;
     uint[] SignedCertAccnt;
    uint[] RevokedCertAccnt;
    

 event AttributeSigned(uint indexed signatureID, address indexed signer,
 uint indexed CertNo,string Certhash,bytes32 Issuedto,bytes32 Issuedby);
 
 
 event SignatureRevoked( uint indexed revocationID,uint indexed RevNo,
 string RevCertHash,bytes32 to,bytes32 By);
 
 
 event Hashes(bytes32[] SignedCertAccnt);
 
 
function signAttribute(uint CertNo,string Certhash,bytes32 Issuedto, bytes32 IssuedBy) public returns (uint signatureID) {
    
        
         signatureID = signatures.length++;
         
        Signature storage signature = signatures[signatureID];
        signature.signer = msg.sender;
      signature.CertNo = CertNo;
        signature.Certhash = Certhash;
         signature.Issuedto=Issuedto;
          signature.IssuedBy= IssuedBy;
         
          SignedCertAccnt.push(CertNo) ;
        
        emit AttributeSigned(signatureID, msg.sender, CertNo, Certhash,Issuedto,IssuedBy);
    }
    
    function SignedCertificates() public payable returns(uint[]) {
        return (SignedCertAccnt);
        //emit Hashes(SignedCertAccnt);
    }
    
    function revokeSignature(uint RevNo,string RevCertHash, bytes32 to, bytes32 By) public returns (uint revocationID) {

            revocationID = revocations.length++;
            Revocation storage revocation = revocations[revocationID];
            //revocation.signatureID = signatureID;
            revocation.RevNo = RevNo;
            revocation.RevCertHash = RevCertHash;
            revocation.to = to;
            revocation.By = By;
          
            RevokedCertAccnt.push(RevNo);
            
           emit SignatureRevoked(revocationID,RevNo,RevCertHash,to,By);
    }
    function RevokedCertificates() view public returns(uint[]) {
        return (RevokedCertAccnt);
    }
   
}
}
