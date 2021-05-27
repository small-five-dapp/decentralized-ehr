pragma solidity ^0.7.3;

import "./ElectronicHealthRecordFactory.sol";

contract ValidatedDoctorMaintenance is ElectronicHealthRecordFactory {
    event DoctorValidated(address _docAddress);
    event DoctorInvalidated(address _docAddress);

    // Mapping from addresses to booleans.
    // validatedDoctors[_address] = true indicates that the doctor
    // who owns _address has been validated.
    mapping(address => bool) validatedDoctors;

    modifier onlyOwner {
        require(msg.sender == owner, "msg.sender is not the owner.");
        _;
    }

    modifier onlyValidatedDoctors {
        require(validatedDoctors[msg.sender], "This doctor is not validated.");
        _;
    }

    /// @notice Marks an address as a validated doctor.
    /// @param _docAddress The address that will be marked as validated.
    /// @dev Ideally, we can set up some form of governance such that
    ///      if > x% of voters vote yes for an address, then the address
    ///      will be marked as a validated doctor.
    function addValidatedDoctor(address _docAddress) external onlyOwner {
        validatedDoctors[_docAddress] = true;
        emit DoctorValidated(_docAddress);
    }

    /// @notice Unmarks an address as a validated doctor.
    /// @param _docAddress The address that will be unmarked as validated.
    /// @dev Ideally, we can set up some form of governance such that
    ///      if > x% of voters vote yes for an address, then the address
    ///      will be unmarked as a validated doctor.
    function removeValidatedDoctor(address _docAddress) external onlyOwner {
        validatedDoctors[_docAddress] = false;
        emit DoctorInvalidated(_docAddress);
    }

    /// @notice Returns a boolean indicating if _docAddress has been marked as
    ///         validated or not.
    /// @param _docAddress The address whose validation status is getting
    ///         looked up.
    function checkValidationState(address _docAddress)
        external
        view
        returns (bool)
    {
        return validatedDoctors[_docAddress];
    }
}
