// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DangDangz is ERC1155, ERC1155URIStorage, Ownable {

    uint256 public constant DDZ = 0;

    constructor() ERC1155("") {
        // 👇 댕댕즈 토큰 생성
        _mint(msg.sender, DDZ, 10**18, "");
    }

    // 순차적으로 늘어나는 토큰 아이디
    uint256 public tokenId = 1;

    // 토큰별 메타데이터 매핑 (개발편의상 onlyOwner 제거)
    function setURI(uint256 _tokenId, string memory _tokenURI) public {
        require(keccak256(abi.encodePacked(uri(_tokenId))) == keccak256(abi.encodePacked("")), "You can only set it up once");
        _setURI(_tokenId, _tokenURI);
    }

    // 토큰별 메타데이터 리턴 (오픈씨에서 읽는 주소)
    function uri(uint256 _tokenId) public view override(ERC1155, ERC1155URIStorage) returns (string memory) {
        // ERC1155URIStorage의 uri 함수만을 호출
        string memory tokenUri = ERC1155URIStorage.uri(_tokenId);
        return tokenUri;
    }

    // 강아지 or 아이템 민팅 (DDZ지불 or 이더지불이 필요하지만 구현단계상 프리민팅으로 설정, 개발편의상 onlyOwner 제거)
    function mint(address _to) public {
        _mint(_to, tokenId, 1, "");
        tokenId++;
    }
}