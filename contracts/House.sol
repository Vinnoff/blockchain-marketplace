pragma solidity ^0.5.0;

contract MyCM {

    struct House {
        string name;
        uint price;
    }

    House[] public houses;

    mapping (uint => address) housesOwner;
    mapping (uint => address) housesBuyer;

    function buy(uint id) public {
        housesBuyer[id] = msg.sender;
    }

    function _sell(string memory _name, uint _price) internal {
        uint houseid = houses.push(House(_name, _price));
        housesOwner[houseid] = msg.sender;
    }
}