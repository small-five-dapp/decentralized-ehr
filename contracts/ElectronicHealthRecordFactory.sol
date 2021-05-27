pragma solidity ^0.7.0;

contract ElectronicHealthRecordFactory {
    enum BloodType {A, B, AB, O}
    uint16 public ehrCount = 0;
    address owner;
    mapping(uint256 => ElectronicHealthRecord) public healthRecords;

    constructor() {
        owner = msg.sender;
    }

    struct ElectronicHealthRecord {
        uint16 id;
        uint16 dateOfBirth;
        uint16 height;
        uint16 weight;
        BloodType bloodType;
        bool hasInsurance;
    }

    event EhrCreated(
        uint256 id,
        uint16 dateOfBirth,
        uint16 height,
        uint16 weight,
        BloodType bloodType,
        bool hasInsurance
    );

    function _createEHR(
        uint16 _dateOfBirth,
        uint16 _height,
        uint16 _weight,
        BloodType _bloodType,
        bool _hasInsurance
    ) public {
        ehrCount++;
        healthRecords[ehrCount] = ElectronicHealthRecord(
            ehrCount,
            _dateOfBirth,
            _height,
            _weight,
            _bloodType,
            _hasInsurance
        );
        emit EhrCreated(
            ehrCount,
            _dateOfBirth,
            _height,
            _weight,
            _bloodType,
            _hasInsurance
        );
    }

}
