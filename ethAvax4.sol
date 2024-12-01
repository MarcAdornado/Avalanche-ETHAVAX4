//202110010@fit.edu.ph

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract degenToken is ERC20, Ownable {
    mapping(string => uint256) public purchaseItem;
    mapping(address => string[]) public inventory;

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
        purchaseItem["KARAMBIT"] = 20;
        purchaseItem["AK-47"] = 15;
        purchaseItem["M4A1-S"] = 10;
    }

    function decimals() public view virtual override returns (uint8) {
        return 0;
    }

    function mint(address destination, uint256 amount) external onlyOwner {
        _mint(destination, amount);
    }

    function transferToken(address destination, uint256 amount) public {
        _transfer(msg.sender, destination, amount);
    }

    function redeemItem(string memory item) external  {
        uint256 cost = purchaseItem[item];
        require(cost > 0, "Invalid item");
        _burn(msg.sender, cost);
        inventory[msg.sender].push(item);
    }

    function checkToken() public view returns (uint256) {
        return balanceOf(msg.sender);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }
    
}
