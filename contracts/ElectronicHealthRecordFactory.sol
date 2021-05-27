pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

contract ElectronicHealthRecordFactory {

    enum BloodType {A, B, AB, O}
    uint16 public ehrCount = 0;
    address owner;
    mapping(uint => ElectronicHealthRecord) public healthRecords;

    constructor() {
        owner = msg.sender;
    }

    struct ElectronicHealthRecord {
        uint16 id;
        uint16 dateOfBirth;
        uint16 height;
        uint16 weight;
        BloodType bloodType;
        string medications;
        string allergies;
        string illnesses;
        string medicalHistory;
        string obstetricHistory;
        string immunizations;
        bool hasInsurance;
    }

    event EhrCreated(uint id,
        uint16 dateOfBirth,
        uint16 height,
        uint16 weight,
        BloodType bloodType,
        string medications,
        string allergies,
        string illnesses,
        string medicalHistory,
        string obstetricHistory,
        string immunizations,
        bool hasInsurance
    );

    function _createEHR(uint16 _dateOfBirth,
        uint16 _height,
        uint16 _weight,
        BloodType _bloodType,
        string memory _medications,
        string memory _allergies,
        string memory _illnesses,
        string memory _medicalHistory,
        string memory _obstetricHistory,
        string memory _immunizations,
        bool _hasInsurance
    ) public {
        ehrCount++;
        healthRecords[ehrCount] = 
            ElectronicHealthRecord(ehrCount,
                _dateOfBirth,
                _height,
                _weight,
                _bloodType,
                _medications,
                _allergies,
                _illnesses,
                _medicalHistory,
                _obstetricHistory,
                _immunizations,
                _hasInsurance);
        emit EhrCreated(
            ehrCount,
            _dateOfBirth,
            _height,
            _weight,
            _bloodType,
            _medications,
            _allergies,
            _illnesses,
            _medicalHistory,
            _obstetricHistory,
            _immunizations,
            _hasInsurance
        );
    }

    function getRecord(uint16 _id) public view returns(ElectronicHealthRecord memory) {
        return healthRecords[_id];
    }

    function getDateOfBirthFromRecord(uint16 _id) public view returns(uint16) {
        return healthRecords[_id].dateOfBirth;
    }
}