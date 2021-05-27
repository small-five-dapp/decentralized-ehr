const { expect } = require("chai");

describe("Maintenance of validated doctors list test", function () {
    async function setup() {
        const [owner, addr1] = await ethers.getSigners();
        const ValidatedDoctors = await ethers.getContractFactory(
            "ValidatedDoctorMaintenance"
        );
        const contractInst = await ValidatedDoctors.deploy();
        return { owner, addr1, contractInst };
    }

    it("Cannot call addValidatedDoctor successfully if not owner.", async function () {
        const { owner, addr1, contractInst } = await setup();
        await expect(
            contractInst.connect(addr1).addValidatedDoctor(addr1.address)
        ).to.be.revertedWith("msg.sender is not the owner.");
    });

    it("Owner can call addValidatedDoctor successfully.", async function () {
        const { owner, addr1, contractInst } = await setup();
        await expect(contractInst.addValidatedDoctor(addr1.address))
            .to.emit(contractInst, "DoctorValidated")
            .withArgs(addr1.address);
    });

    it("Owner can call removeValidatedDoctor successfully.", async function () {
        const { owner, addr1, contractInst } = await setup();
        await expect(contractInst.removeValidatedDoctor(addr1.address))
            .to.emit(contractInst, "DoctorInvalidated")
            .withArgs(addr1.address);
    });

    it("Verify the correctness of the validation status of doctors.", async function () {
        const { owner, addr1, contractInst } = await setup();
        await contractInst.addValidatedDoctor(addr1.address);
        const addr1DocState = await contractInst.checkValidationState(
            addr1.address
        );
        console.log("async result is: ", addr1DocState);
        await expect(contractInst.checkValidationState(addr1.address)).to.equal(
            true
        );
        await contractInst.removeValidatedDoctor(addr1.address);
        await expect(contractInst.checkValidationState(addr1.address)).to.equal(
            false
        );
    });
});
