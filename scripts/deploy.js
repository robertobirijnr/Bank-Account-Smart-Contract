const hre = require("hardhat");
const fs = require("fs/promises");

async function main() {
    const BankAccount = await hre.ethers.getContractFactory("BankAccount");
    const bankAccount = await BankAccount.deploy();
    // await bankAccount.deployTransaction.wait(); // Wait for the deployment transaction to be mined
    await writeDeploymentInfo(bankAccount);
}

async function writeDeploymentInfo(bankAccount) {
    const data = {
        contract: {
            address: bankAccount.target,
            signerAddress: bankAccount.runner,
            abi: bankAccount.interface.format()
        }
    };

    const content = JSON.stringify(data, null, 2);
    await fs.writeFile("deployment.json", content, { encoding: "utf-8" });
}

main().catch((err) => {
    console.error(err);
    process.exitCode = 1;
});
