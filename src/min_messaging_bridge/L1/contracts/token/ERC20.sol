// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract NadaiToken is ERC20{

    address public bridgeContract;

    modifier onlyOwner {
        require(msg.sender == bridgeContract);
        _;
    }

    constructor(address bridge_contract) ERC20("Nadai Token", "WNAI"){
        bridgeContract = bridge_contract;
    }

    function mint(address receiver, uint256 amount) public onlyOwner {
        _mint(receiver, amount);
    }

    function burn(address account, uint256 amount) public onlyOwner {
        _burn(account, amount);
    }
}