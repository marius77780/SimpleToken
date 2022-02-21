 pragma solidity >=0.7.0 <0.9.0;

contract Token {
    address public minter;
    mapping(address =>uint) public balance;

    event Sent(address from, address to, uint ammount);

    constructor() {
        minter = msg.sender;

    }

    function mint(address receiver, uint ammount) public{
        require(msg.sender==minter);
        balance[receiver] += ammount;

    }

    error insufficientFund(uint request,uint available);

    function send(address receiver , uint ammount)public {
        if(ammount > balance[msg.sender])
        revert insufficientFund({
            request:ammount,
            available:balance[msg.sender]
        });
        balance[msg.sender] -=ammount;
        balance[receiver] += ammount;
       emit Sent(msg.sender, receiver, ammount);

    }
}