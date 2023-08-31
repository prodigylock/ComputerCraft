print("Obtaining peripherals")
local rs1 = peripheral.wrap("redstoneIntegrator_7")
local rs2 = peripheral.wrap("redstoneIntegrator_8")
local rs3 = peripheral.wrap("redstoneIntegrator_9")
local rs4 = peripheral.wrap("redstoneIntegrator_10")

local yawControl = peripheral.wrap("scrollBehaviourEntity_2")
local pitchControl = peripheral.wrap("scrollBehaviourEntity_3")

yawControl.setTargetSpeed(0)
pitchControl.setTargetSpeed(0)

local tick = 1/20

local function loadAction()
    -- move over pulse
    rs2.setOutput("back",true)
    os.sleep(tick)
    rs2.setOutput("back",false)
    os.sleep(4*tick)

    -- load pulse
    rs1.setOutput("top",true)
    os.sleep(tick)
    rs1.setOutput("top",false)
end

local function loadShot()
    for i = 1, 5, 1 do
        loadAction()
        rs1.setOutput("left",true)
        os.sleep(tick)
        rs1.setOutput("left",false)
        os.sleep(1)
    end
    loadAction()

    --reset carriage signal
    rs1.setOutput("right",true)
    os.sleep(tick)
    rs1.setOutput("right",false)

    --reload signal
    rs3.setOutput("back",true)
    os.sleep(tick)
    rs3.setOutput("back",false)





end

local function takeAim()
    --lift weapon
    rs4.setOutput("left",true)
    os.sleep(2)

    --screw
    rs2.setOutput("front",true)
    os.sleep(1)

    --assemble
    rs3.setOutput("top",true)
    os.sleep(tick)
    --take aim
    os.sleep(3)
    --fire
    rs3.setOutput("left",true)
    os.sleep(tick)
    rs3.setOutput("left",false)
    os.sleep(tick)
    --disassemble
    rs3.setOutput("top",false)
    os.sleep(tick)

    --unscrew
    rs2.setOutput("front",false)
    os.sleep(1)

    --lower
    rs4.setOutput("left",false)
    os.sleep(2)
end

for i = 1, 10, 1 do
    print(i)
    os.sleep(1)
end
loadShot()
takeAim()
