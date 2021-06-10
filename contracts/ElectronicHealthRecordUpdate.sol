pragma solidity ^0.7.3;

import "./ElectronicHealthRecordFactory.sol";
import "./ValidatedDoctorMaintenance.sol";

contract ElectronicHealthRecordUpdate is
    ElectronicHealthRecordFactory,
    ValidatedDoctorMaintenance
{
    event RecordUpdated(address _patient);
    event DoctorApproved(address _patient, address _doctor);
    event DoctorUnapproved(address _patient, address _doctor);

    // Mapping from addresses to a mapping of addresses to booleans.
    // approvedDoctors[_patient][_doctor] = true indicates that _patient has
    // approved _doctor to make changes to _patient's EHR.
    mapping(address => mapping(address => bool)) private approvedDoctors;

    modifier docIsApproved(address _patient) {
        require(
            approvedDoctors[_patient][msg.sender],
            "This doctor is not approved to adjust _patient's health record."
        );
        _;
    }

    /// @notice Allows users to update the height on EHR.
    /// @param _patientId ID of the patient.
    /// @param _height The new height which the EHR will be updated with.
    /// @dev In order for this function to get executed, msg.sender must be
    ///      validated. Additionally, _patient must have approved msg.sender
    ///      as someone who can make changes to their EHR.
    function updateHeight(address _patientId, uint16 _height)
        external
        onlyValidatedDoctors
        docIsApproved(_patientId)
    {
        ElectronicHealthRecord storage patientRec = healthRecords[_patientId];
        patientRec.height = _height;
        emit RecordUpdated(_patientId);
    }

    /// @notice Allows users to update the weight on EHR.
    /// @param _patientId ID of the patient.
    /// @param _weight The new weight which the EHR will be updated with.
    /// @dev In order for this function to get executed, msg.sender must be
    ///      validated. Additionally, _patient must have approved msg.sender
    ///      as someone who can make changes to their EHR.
    function updateWeight(address _patientId, uint16 _weight)
        external
        onlyValidatedDoctors
        docIsApproved(_patientId)
    {
        ElectronicHealthRecord storage patientRec = healthRecords[_patientId];
        patientRec.weight = _weight;
        emit RecordUpdated(_patientId);
    }

    /// @notice This retrieves all of the _patientId's medical data.
    /// @param _patientId ID of the patient.
    /// @dev In-house getter function for ElectronicHealthRecord. If we were to
    ///      use the getter function that Solidity provides, it'd be returning a
    ///      struct, which apparently it does not like, so we've provided a
    ///      getter function.
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

    /// @notice This allows msg.sender to approve _doctor as someone who can
    ///         modify msg.sender's EHR.
    /// @param _doctor The address of the _doctor who is getting approved.
    function approveDocter(address _doctor) external {
        require(checkValidationState(_doctor), "This doctor is not validated.");
        approvedDoctors[msg.sender][_doctor] = true;
        emit DoctorApproved(msg.sender, _doctor);
    }

    /// @notice This allows msg.sender to unapprove _doctor as someone who can
    ///         modify msg.sender's EHR.
    /// @param _doctor The address of the _doctor who is getting unapproved.
    function unapproveDoctor(address _doctor) external {
        approvedDoctors[msg.sender][_doctor] = false;
        emit DoctorUnapproved(msg.sender, _doctor);
    }
}
