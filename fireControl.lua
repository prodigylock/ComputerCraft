print("Obtaining peripherals")
local yaw = 45
local pitch = 45

local aimingRPM = 13

local rs1w = peripheral.wrap("redstoneIntegrator_7")
local rs2 = peripheral.wrap("redstoneIntegrator_8")
local rs3 = peripheral.wrap("redstoneIntegrator_9")
local rs4 = peripheral.wrap("redstoneIntegrator_10")
local rs5 = peripheral.wrap("redstoneIntegrator_11")

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
    rs1.setOutput("right",true)
    os.sleep(tick)
    rs1.setOutput("right",false)
end

local function loadShot()
    for i = 1, 5, 1 do
        loadAction()
        rs1.setOutput("left",true) --carriage signal
        os.sleep(tick)
        rs1.setOutput("left",false)
        os.sleep(1)
    end
    loadAction()
    os.sleep(0.5)
    --reset carriage signal
    rs1.setOutput("front",true)
    os.sleep(tick)
    rs1.setOutput("front",false)

    --reload signal
    rs3.setOutput("back",true)
    os.sleep(tick)
    rs3.setOutput("back",false)





end

local function armCannon()

    --screw
    --new screw sequence
        --move out ram
        rs5.setOutput("bottom",true)
        os.sleep(tick)
        rs5.setOutput("bottom",false)
        os.sleep(0.5)
        --move in screw
        rs5.setOutput("top",true)
        os.sleep(tick)
        rs5.setOutput("top",false)
        os.sleep(0.5)

        --screw
        rs5.setOutput("back",true)
        os.sleep(tick)
        rs5.setOutput("back",false)
        os.sleep(0.5)


    --lift weapon
    rs4.setOutput("left",true)
    os.sleep(2)


    --assemble
    rs3.setOutput("top",true)
    os.sleep(tick)
    --take aim
    os.sleep(3)

    
end

local function unarmCannon()
    --disassemble
    rs3.setOutput("top",false)
    os.sleep(tick)

    --lower
    rs4.setOutput("left",false)
    os.sleep(2)

    --unscrew
        --unscrew
        rs5.setOutput("back",true)
        os.sleep(tick)
        rs5.setOutput("back",false)
        os.sleep(0.5)

        --move out screw
        rs5.setOutput("top",true)
        os.sleep(tick)
        rs5.setOutput("top",false)
        os.sleep(0.5)

        --move in ram
        rs5.setOutput("bottom",true)
        os.sleep(tick)
        rs5.setOutput("bottom",false)
        os.sleep(0.5)
end

local function unfold()
    --open bay doors

    --unfold screw
    rs5.setOutput("top",true)
    os.sleep(tick)
    rs5.setOutput("top",false)
    os.sleep(0.5)

    -- move in loader
    rs5.setOutput("bottom",true)
    os.sleep(tick)
    rs5.setOutput("bottom",false)
    os.sleep(0.5)
end

local function fold()
    -- move out ram
    rs5.setOutput("bottom",true)
    os.sleep(tick)
    rs5.setOutput("bottom",false)
    os.sleep(0.5)

    --fold in screw
    rs5.setOutput("top",true)
    os.sleep(tick)
    rs5.setOutput("top",false)
    os.sleep(0.5)

    -- close bay doors

end



for i = 1, 3, 1 do
    print(i)
    os.sleep(1)
end

local function fire()
        --fire
        rs3.setOutput("left",true)
        os.sleep(tick)
        rs3.setOutput("left",false)
        os.sleep(tick)
end

local function aim(yaw,pith)
    local anglePerTick = aimingRPM/27

    --calculating yawing time
    local yawTicks = yaw/anglePerTick
    yawControl.setTargetSpeed(-rpm)
    os.sleep(yawTicks*tick)

    --calculating pitching time
    local pitchTicks = pitch/anglePerTick
    pitchControl.setTargetSpeed(-rpm)
    os.sleep(pitchTicks*tick)

end



unfold()
loadShot()
armCannon()
aim(yaw,pitch)
fire()
unarmCannon()
fold()