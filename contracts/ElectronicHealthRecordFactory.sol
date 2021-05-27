pragma solidity ^0.7.0;

contract ElectronicHealthRecordFactory {
    enum BloodType {A, B, AB, O}
    address owner;
    mapping(address => ElectronicHealthRecord) public healthRecords;

    constructor() {
        owner = msg.sender;
    }

    struct ElectronicHealthRecord {
        uint16 dateOfBirth;
        uint16 height;
        uint16 weight;
        BloodType bloodType;
        bool hasInsurance;
    }

    event EhrCreated(
        uint16 dateOfBirth,
        uint16 height,
        uint16 weight,
        BloodType bloodType,
        bool hasInsurance
    );

    function _createEHR(
        address _patient,
        uint16 _dateOfBirth,
        uint16 _height,
        uint16 _weight,
        BloodType _bloodType,
        bool _hasInsurance
    ) public {
        healthRecords[_patient] = ElectronicHealthRecord(
            _dateOfBirth,
            _height,
            _weight,
            _bloodType,
            _hasInsurance
        );
        emit EhrCreated(
            _dateOfBirth,
            _height,
            _weight,
            _bloodType,
            _hasInsurance
        );
    }
}
