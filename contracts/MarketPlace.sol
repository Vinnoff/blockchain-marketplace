pragma solidity ^0.4.4;

contract MarketPlaceContract {
    address public client;
    address public tasker;

    uint256 public payAmount;
    HouseInterface houseContract;

    function setHouseContractAddress(address _address) external {
        houseContract = HouseInterface(_address);
    }

    function() public payable {
        require(client == msg.sender);
        payAmount += msg.value;
    }

    function buyHouse(address _client, address _tasker, uint _house) public {
        require(_client == msg.sender);
        (,,,payAmount,) = houseContract.getHouse(_house);
        require(msg.value == payAmount);
        _tasker.transfer(payAmount);
        houseContract.setOwner(msg.sender, _house);
    }

    function createHouse(address _owner, string place, string name, uint price) public {
        require(_owner == msg.sender);
        houseContract.createHouse(msg.sender, place, name, price);
    }
}

contract HouseInterface {
    mapping (uint => address) public houseToOwner;
    uint houseCount;

    House[] storage houses;

    struct House {
        string place;
        string name;
        bool isSold;
        uint price;
        address _seller;
    }

    function getHouse(uint256 _id) external view returns (
        houses[_id];
    );

    function setOwner(address _buyer, uint _houseId) private {
        House storage house = houses[_houseId];
        house._owner = _buyer;
    }

    function createHouse(address _owner, string place, string name, uint price) private {
        uint id = houses.push(House(place, name, false, price, _owner)) -1;
        houseToOwner[id] = _owner;
        houseCount++;
    }
}