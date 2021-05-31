pragma solidity ^0.7.3;

import "./ElectronicHealthRecordFactory.sol";

contract ElectronicHealthRecordUpdate is ElectronicHealthRecordFactory {
    event RecordUpdated(address _patient);

    /// @notice Allows users to update the height on EHR.
    /// @param _patientId ID of the patient.
    /// @param _height The new height which the EHR will be updated with.
    /// @dev There needs to be some verifySig(sig, patientPK) function as well where the
    ///      patient provides a signature stating that they approve the update.
    ///      Also needs to have a onlyValidatedDoctor() function modifier.
    function updateHeight(address _patientId, uint16 _height) external {
        ElectronicHealthRecord storage patientRec = healthRecords[_patientId];
        patientRec.height = _height;
        emit RecordUpdated(_patientId);
    }

    /// @notice Allows users to update the weight on EHR.
    /// @param _patientId ID of the patient.
    /// @param _weight The new weight which the EHR will be updated with.
    /// @dev There needs to be some verifySig(sig, patientPK) function as well where the
    ///      patient provides a signature stating that they approve the update.
    ///      Also needs to have a onlyValidatedDoctor() function modifier.
    function updateWeight(address _patientId, uint16 _weight) external {
        ElectronicHealthRecord storage patientRec = healthRecords[_patientId];
        patientRec.weight = _weight;
        emit RecordUpdated(_patientId);
    }

    /// @notice This retrieves all of the _patientId's medical data.
    /// @param _patientId ID of the patient.
    /// @dev In-house getter function for ElectronicHealthRecord. If we were to use
    ///      the getter function that Solidity provides, it'd be returning a
    ///      struct, which apparently it does not like, so we've provided a getter function.
    function getHealthRecord(address _patientId)
        external
        view
        returns (
            uint8 month,
            uint8 day,
            uint16 year,
            uint16 height,
            uint16 weight,
            BloodType bloodType,
            bool hasInsurance
        )
    {
        ElectronicHealthRecord memory patientHealthRecord =
            healthRecords[_patientId];
        return (
            patientHealthRecord.dob.month,
            patientHealthRecord.dob.day,
            patientHealthRecord.dob.year,
            patientHealthRecord.height,
            patientHealthRecord.weight,
            patientHealthRecord.bloodType,
            patientHealthRecord.hasInsurance
        );
    }
}
