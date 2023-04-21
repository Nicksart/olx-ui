// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract MyContract {

    uint256 public totalAds;
    address payable public owner;

    constructor() payable {
        owner = payable(msg.sender);


    }

    event newAdd (
        address indexed from,
        uint256 timestamp,
        string message,
        string name,
        string image
    );

    struct Add {
        uint256 timestamp;
        string name;
        string message;
        string image;
        address sender;
    }

    Add[] adds;

    function getAdds() public view returns(Add[] memory) {
        return adds;
    }

    function getTotalAdds() public view returns(uint256) {
        return totalAds;
    }

    function placeAdd(string memory _message, string memory _name, string memory _image) payable public {
        require(msg.value == 0.01 ether, "You have to pay 0.01 ether to place add.");

        totalAds += 1;
        adds.push(Add(block.timestamp, _name, _message, _image, msg.sender));

        (bool success,) = owner.call{value: msg.value}("");
        require(success, "Failed to pay for add.");

        emit newAdd(msg.sender, block.timestamp, _message, _name, _image);

    }
}