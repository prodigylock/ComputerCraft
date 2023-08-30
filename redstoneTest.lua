-- local peripheralNames = peripheral.getNames()
-- for i = 1,#peripheralNames do
--     print(peripheralNames[i])
-- end

local sides = rs.getSides()

local red0 = peripheral.find("redstoneIntegrator_0")
 for i = 1, 10, 1 do
    for j = 1, #sides do
        red0.setOutput(sides[j],true)
        os.sleep(1)
        red0.setOutput(sides[j],false)
    end
 end