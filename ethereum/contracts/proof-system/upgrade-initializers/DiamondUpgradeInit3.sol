// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "../../common/libraries/Diamond.sol";
import "../chain-deps/facets/Base.sol";
// import "../interfaces/IVerifier.sol";

interface IOldDiamondCut {
    function proposeDiamondCut(Diamond.FacetCut[] calldata _facetCuts, address _initAddress) external;

    function cancelDiamondCutProposal() external;

    function executeDiamondCutProposal(Diamond.DiamondCutData calldata _diamondCut) external;

    function emergencyFreezeDiamond() external;

    function unfreezeDiamond() external;

    function approveEmergencyDiamondCutAsSecurityCouncilMember(bytes32 _diamondCutHash) external;

    // FIXME: token holders should have the ability to cancel the upgrade

    event DiamondCutProposal(Diamond.FacetCut[] _facetCuts, address _initAddress);

    event DiamondCutProposalCancelation(uint256 currentProposalId, bytes32 indexed proposedDiamondCutHash);

    event DiamondCutProposalExecution(Diamond.DiamondCutData _diamondCut);

    event EmergencyFreeze();

    event Unfreeze(uint256 lastDiamondFreezeTimestamp);

    event EmergencyDiamondCutApproved(
        address indexed _address,
        uint256 currentProposalId,
        uint256 securityCouncilEmergencyApprovals,
        bytes32 indexed proposedDiamondCutHash
    );
}

/// @author Matter Labs
contract DiamondUpgradeInit3 is ProofChainBase {
    function upgrade(
        uint256 _priorityTxMaxGasLimit,
        IAllowList _allowList,
        IVerifier _verifier
    ) external payable returns (bytes32) {
        // Zero out the deprecated storage slots
        delete chainStorage.__DEPRECATED_diamondCutStorage;

        chainStorage.priorityTxMaxGasLimit = _priorityTxMaxGasLimit;
        chainStorage.allowList = _allowList;
        chainStorage.verifier = _verifier;

        return Diamond.DIAMOND_INIT_SUCCESS_RETURN_VALUE;
    }
}
