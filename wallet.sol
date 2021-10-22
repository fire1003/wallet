pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

/// @title Simple wallet
/// @author Tonlabs
contract Wallet {
    /*
     Exception codes:
      100 - message sender is not a wallet owner.
      101 - invalid transfer value.
     */

    /// @dev Contract constructor.
    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

    modifier checkOwnerAndAccept {

        require(msg.pubkey() == tvm.pubkey(), 100);
		tvm.accept();
		_;
	}

    /// @dev Allows to transfer tons to the destination account.
    /// @param dest Transfer target address.
    /// @param value Nanotons value to transfer.
     function sendTransaction_bezkom(address dest, uint128 value) public pure checkOwnerAndAccept {
        dest.transfer(value, true, 0);
    }

    function sendTransaction_skom(address dest, uint128 value) public pure checkOwnerAndAccept {
        dest.transfer(value, true, 1);
    }

    function sendTransaction_all_delete(address dest) public pure checkOwnerAndAccept {
        dest.transfer(0, true, 160);
    }
}