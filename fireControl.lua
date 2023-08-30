print("Obtaining peripherals")
local rs1 = peripheral.wrap("redstoneIntegrator_7")
local rs2 = peripheral.wrap("redstoneIntegrator_8")
local rs3 = peripheral.wrap("redstoneIntegrator_9")

local tick = 1/20

local function loadAction()
    -- move over pulse
    rs2.setOutput("back",true)
    os.sleep(tick)
    rs2.setOutput("back",false)
    os.sleep(4*tick)

    -- load pulse
    rs1.setOutput("up",true)
    os.sleep(tick)
    rs1.setOutput("up",false)
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
    rs1.setOutput("right",true)
    os.sleep(tick)
    rs1.setOutput("right",false)
end

for i = 1, 10, 1 do
    print(i)
end
loadShot()