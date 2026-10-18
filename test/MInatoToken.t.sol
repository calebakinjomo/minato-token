//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/MinatoToken.sol";

contract MinatoTokenTest is Test {
    MinatoToken token;
    address owner = address(this);
    address ade = address(0x1);
    address bayo = address(0x2);

    uint256 constant INITIAL_SUPPLY = 10_000_000;

    function setUp() public {
        token = new MinatoToken(
            "MinatoToken",
            "MIN",
            INITIAL_SUPPLY
        );
    }
    
    /* Deployment */
    function testInitialSupplyMintedToOwner() public {
        uint256 expectedSupply = INITIAL_SUPPLY * 10 ** token.decimals();
        assertEq(token.totalSupply(), expectedSupply);
        assertEq(token.balanceOf(owner), expectedSupply);
    }

    /* Transfers*/
    function testTransferBetweenWallets() public {
        uint256 amount = 1_000 * 10 ** token.decimals();
        token.transfer(ade, amount);
        assertEq(token.balanceOf(ade), amount);
        assertEq(
            token.balanceOf(owner), token.totalSupply() - amount
        );
    }

    /* Minting */
    function testOwnerCanMint() public {
        uint256 amount = 500 * 10 ** token.decimals();
        token.mint(bayo, amount);
        assertEq(token.balanceOf(bayo), amount);
    }

    function testNonOwnerCannotMint() public {
        vm.prank(ade);
        vm.expectRevert();
        token.mint(ade, 100);
    }

    /* Pausing */
    function testPauseBlocksTransfer() public {
        token.pause();
        vm.expectRevert();
        token.transfer(ade, 100);
    }
    function testUnpauseAllowsTransfers() public {
        token.pause();
        token.unpause();
        token.transfer(ade, 100);
        assertEq(token.balanceOf(ade), 100);
    }

    /* Burning */
    function testBurnReducesTotalSupply() public {
        uint256 burnAmount = 1_000 * 10 ** token.decimals();
        uint256 supplyBefore = token.totalSupply();
        token.burn(burnAmount);
        assertEq(
            token.totalSupply(), supplyBefore - burnAmount
        );
    }
}
