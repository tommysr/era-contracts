// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

interface IBridgehubMailbox {
    function finalizeEthWithdrawal(
        uint256 _chainId,
        uint256 _l2BlockNumber,
        uint256 _l2MessageIndex,
        uint16 _l2TxNumberInBlock,
        bytes calldata _message,
        bytes32[] calldata _merkleProof
    ) external;
}
