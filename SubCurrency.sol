pragma solidity ^0.8.0;

contract SubCurrency {

    address public owner;

    // First we have to declare the owner of the contract
    constructor() {
        owner = msg.sender;
    }

    // This struct basically contain peoples balances
    struct Wallet {
        uint balance;
    }
    mapping (address => Wallet) public person;

    // This modifier created for clean and understandable syntax
    // Which is allows to only owner can manage the functions
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    // This function allows the owner can mint some money to the other people
    function Mint(uint amount, address receiver) public onlyOwner {
        person[receiver].balance += amount;
    }

    // This function allows to other people can make transactions
    function Send(uint amount, address receiver) public {
        address sender = msg.sender;
        require(msg.sender == sender);
        require(person[msg.sender].balance >= amount);

        person[sender].balance -= amount;
        person[receiver].balance += amount;
    }
}
