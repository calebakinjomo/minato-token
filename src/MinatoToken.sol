//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "openzepplin-contracts/contracts/token/ERC20/ERC20.sol";
import "openzepplin-contracts/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "openzepplin-contracts/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "openzepplin-contracts/contracts/access/Ownable.sol";

contract MinatoToken is ERC20, ERC20Burnable, ERC20Pausable, Ownable {
    constructor(
        string memory name_,
        string memory symbol_,
        uint256 initialSupply
    ) ERC20(name_, symbol_) {
        _mint(msg.sender, initialSupply * 10 ** decimals());
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    // In OpenZeppelin v4, you MUST override _beforeTokenTransfer
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal override(ERC20, ERC20Pausable) {
        super._beforeTokenTransfer(from, to, amount);
    }
    
}
