// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import {ITransactionFilterer} from "../../state-transition/chain-interfaces/ITransactionFilterer.sol";

contract TransactionFiltererFalse is ITransactionFilterer {
    // add this to be excluded from coverage report
    function test() internal virtual {}

    function isTransactionAllowed(address, address, uint256, uint256, bytes memory, address) external view returns (bool) {
        return false;
    }
}
