pragma solidity ^0.7.3;

import "./ElectronicHealthRecordFactory.sol";

contract ElectronicHealthRecordUpdate is ElectronicHealthRecordFactory {
    /// @notice Allows users to update the height on EHR.
    /// @param _patientId ID of the patient. (fixme: I believe this should be an address
    ///      instead though).
    /// @param _height The new height which the EHR will be updated with.
    /// @dev There needs to be some verifySig(sig, patientPK) function as well where the
    ///      patient provides a signature stating that they approve the update.
    ///      Also needs to have a onlyValidatedDoctor() function modifier.
    function updateHeight(uint16 _patientId, uint16 _height) external {
        ElectronicHealthRecord storage patientRec = healthRecords[_patientId];
        patientRec.height = _height;
    }

    /// @notice Allows users to update the weight on EHR.
    /// @param _patientId ID of the patient. (fixme: I believe this should be an address
    ///      instead though).
    /// @param _weight The new weight which the EHR will be updated with.
    /// @dev There needs to be some verifySig(sig, patientPK) function as well where the
    ///      patient provides a signature stating that they approve the update.
    ///      Also needs to have a onlyValidatedDoctor() function modifier.
    function updateWeight(uint16 _patientId, uint16 _weight) external {
        ElectronicHealthRecord storage patientRec = healthRecords[_patientId];
        patientRec.weight = _weight;
    }

}
