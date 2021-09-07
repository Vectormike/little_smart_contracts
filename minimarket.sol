pragma solidity >=0.7.0 <0.9.0;

contract MiniMarket {
    enum StateType {
        itemAvailable,
        itemPlaced,
        accepted
    }

    address owner;
    string description;
    uint256 askingPrice;
    StateType State;
    address buyer;
    uint256 offerPrice;

    constructor(string memory description, uint256 price) {
        owner = msg.sender;
        askingPrice = price;
        description = description;
        State = StateType.itemAvailable;
    }

    modifier hasOfferPrice() {
        require(offerPrice > 0);
        _;
    }

    modifier isItemAvailable() {
        require(State == StateType.itemAvailable);
        _;
    }

    modifier isOwner() {
        require(owner != msg.sender);
        _;
    }

    modifier offerPlaced() {
        require(State == StateType.itemPlaced);
        _;
    }

    modifier isSenderOwner() {
        require(owner == msg.sender);
        _;
    }

    function makeOffer(uint256 price)
        public
        hasOfferPrice
        isItemAvailable
        isOwner
    {
        buyer = msg.sender;
        offerPrice = price;
        State = StateType.itemPlaced;
    }

    function acceptOffer() public isSenderOwner {
        State = StateType.accepted;
    }

    function rejectOffer() public offerPlaced {
        State = StateType.itemAvailable;
    }
}
