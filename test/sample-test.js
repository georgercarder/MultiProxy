const { expect } = require("chai");

const { TransparentUpgradeableProxy } = require('../artifacts/@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol/TransparentUpgradeableProxy.json')

describe("MultiProxy", function() {
  it("Sets and calls multiple implementations behind proxy.", async function() {

    accounts = await ethers.getSigners()

    const SomeContract = await ethers.getContractFactory("SomeContract")
    someContract = await SomeContract.connect(accounts[0]).deploy()
    await someContract.deployed()

    const SomeContract2 = await ethers.getContractFactory("SomeContract2")
    someContract2 = await SomeContract2.connect(accounts[0]).deploy()
    await someContract2.deployed()

    const StandardProxy = await ethers.getContractFactory("StandardProxy")
    const admin = accounts[0]
    standardProxy = await StandardProxy.connect(admin).deploy(someContract.address, admin.address)
    await standardProxy.deployed()
    
    const MultiProxy = await ethers.getContractFactory("MultiProxy")
    multiProxy = await MultiProxy.connect(admin).deploy(someContract.address, admin.address)
    await multiProxy.deployed()

    await multiProxy.connect(admin).setImplementation(SomeContract.interface.getSighash("test"), someContract.address)
    await multiProxy.connect(admin).setImplementation(SomeContract2.interface.getSighash("test2"), someContract2.address)


    const Harness = await ethers.getContractFactory("Harness")
    harness = await Harness.connect(admin).deploy(standardProxy.address, multiProxy.address)
    await harness.deployed()

    let tx = await harness.connect(accounts[1]).testStandard()
    let receipt = await tx.wait()
    console.log("testStandard")
    console.log("gas used", receipt.gasUsed.toString())

    tx = await harness.connect(accounts[1]).test()
    receipt = await tx.wait()

    console.log("test")
    console.log("gas used", receipt.gasUsed.toString())
    tx = await harness.connect(accounts[1]).test2()
    receipt = await tx.wait()

    console.log("test2")
    console.log("gas used", receipt.gasUsed.toString())
  });
});
