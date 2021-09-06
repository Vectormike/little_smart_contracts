// import solidity
pragma solidity ^0.8.7;

contract Inheritance {
    address owner;
    bool deceased;
    uint256 money;

    constructor() payable {
        owner = msg.sender;
        money = msg.value;
        deceased = false;
    }

    modifier oneOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier isDeceased() {
        require(deceased == true);
        _;
    }

    address[] wallets;

    mapping(address => uint256) inheritance;

    function setUpWallet(address _wallet, uint256 _inheritance)
        public
        oneOwner
    {
        wallets.push(_wallet);
        inheritance[_wallet] = _inheritance;
    }

    function moneyPaid() private isDeceased {
        for (uint256 index = 0; 1 < wallets.length; index++) {
            wallets[index].transfer(inheritance[wallets[index]]);
        }
    }

    function died() public oneOwner {
        deceased = true;
        moneyPaid();
    }
}
