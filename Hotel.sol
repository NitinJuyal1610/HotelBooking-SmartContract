// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

contract Hotel{
    enum Status {Vacant,Occupied}
    Status currentStatus;
    address payable public owner;

    event Occupy(address _occupant, uint _cost);
    constructor(){
        owner = payable(address(msg.sender));
        currentStatus=Status.Vacant;
    }

    modifier OnlyWhileVacant(){
    require(currentStatus==Status.Vacant,"Sorry it is Currently Occupied");
    _;
    }

    modifier Costs(uint _amount){
        require(msg.value>=_amount,"Not Enough Funds ");
        _;
    }

    receive() external payable OnlyWhileVacant Costs(2 ether){
        currentStatus=Status.Occupied;
        owner.transfer(msg.value);
        emit Occupy(msg.sender,msg.value);
    }


}