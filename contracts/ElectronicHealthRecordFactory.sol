pragma solidity ^0.7.0;

contract ElectronicHealthRecordFactory {
    enum BloodType {A, B, AB, O}
    address owner;
    mapping(address => ElectronicHealthRecord) healthRecords;

    constructor() {
        owner = msg.sender;
    }

    struct Date {
        uint8 month;
        uint8 day;
        uint16 year;
    }

    struct ElectronicHealthRecord {
        Date dob;
        uint16 height;
        uint16 weight;
        BloodType bloodType;
        bool hasInsurance;
    }

    event EhrCreated(
        address patient,
        uint8 month,
        uint8 day,
        uint16 year,
        uint16 height,
        uint16 weight,
        BloodType bloodType,
        bool hasInsurance
    );

    function _createEHR(
        address _patient,
        uint8 _month,
        uint8 _day,
        uint16 _year,
        uint16 _height,
        uint16 _weight,
        BloodType _bloodType,
        bool _hasInsurance
    ) external {
        Date memory dateOfBirth = Date(_month, _day, _year);
        healthRecords[_patient] = ElectronicHealthRecord(
            dateOfBirth,
            _height,
            _weight,
            _bloodType,
            _hasInsurance
        );
        emit EhrCreated(
            _patient,
            dateOfBirth.month,
            dateOfBirth.day,
            dateOfBirth.year,
            _height,
            _weight,
            _bloodType,
            _hasInsurance
        );
    }
}
