const { expect } = require("chai");

describe("Electronic Health Record Factory Test", function() {

    let electronicHealthRecordFactory;
    let count = 0;
    let record = [9611, 56, 132, 1, "medications", "allergies", "illnesses", "medicalHistory", "obstetricHistory", "immunizations", true];

    beforeEach(async() => {
        const ElectronicHealthRecordFactory = await ethers.getContractFactory("ElectronicHealthRecordFactory");
        electronicHealthRecordFactory = await ElectronicHealthRecordFactory.deploy();
        await electronicHealthRecordFactory.deployed();
    });

    it("Creating a health records", async function() {
        whenCreateEHRIsCalled(record);
        thenRecordMatchesExpected();
    });

    async function whenCreateEHRIsCalled(record) {
        await expect(electronicHealthRecordFactory._createEHR(...record))
            .to.emit(electronicHealthRecordFactory, "EhrCreated")
            .withArgs(++count, record[0], record[1], record[2], record[3], record[4], record[5], record[6], record[7], record[8], record[9], record[10]);
    }

    async function thenRecordMatchesExpected() {
        record.unshift(count);
        var output = record;

        expect(JSON.stringify(await electronicHealthRecordFactory.getRecord(count)))
            .to.equal(JSON.stringify(output));
        expect(await electronicHealthRecordFactory.getDateOfBirthFromRecord(count)).to.equal(record[1]);
        expect(await electronicHealthRecordFactory.getDateOfBirthFromRecord(count + 1)).to.equal(0);
    }
});