-- Sets the possible floors and peripherals
Floors = {"2","1","S","S-1"}
Monitor = peripheral.wrap("top")

function Main()
        
    term.redirect(Monitor)
    term.setBackgroundColour(colors.black)
    term.clear()

    Display()

    --while loop event handlers

end


--one block is 7x5px
function Display()
    local top = 15
    local bottom = 20-15
    Monitor.setTextScale(0.5)
    --Creates two windows (top and bottom) for fixed screen
    --table parentTerm, number x, number y, number width, number height [, boolean visible]   
    floorWindow = window.create(Monitor,2,6,13,16,true)
    downWindow = window.create(Monitor,2,22,13,2,true)
    upWindow = window.create(Monitor,2,3,13,2,true)

    floorWindow.setBackgroundColour(colors.black)
    upWindow.setBackgroundColour(colors.lime)
    downWindow.setBackgroundColour(colors.lime)

    floorWindow.clear()
    upWindow.clear()
    downWindow.clear()

    term.redirect(upWindow)
    term.setCursorPos(6,1)
    term.write("/ \\")
    term.setCursorPos(5,2)
    term.write("// \\\\")

    term.redirect(downWindow)
    term.setCursorPos(5,1)
    term.write("\\\\ //")
    term.setCursorPos(6,2)
    term.write("\\ /")

    --creates a window for every floor
    --creates a window for next/previous page buttons and page counter

    -- add logic for 6 or more floors to seperate into two columns
    -- invert layers or make them come from the bottom
    --gray out/make invisible up/down if unavailable
    -- test states saving after moving
    term.redirect(floorWindow)
    local size = 3
    local offset = 0
    for index, value in ipairs(Floors) do
        --draws box 
        paintutils.drawFilledBox(1,1+offset,13,3+offset,colors.lightBlue)
        --add number in centre
        local centreOffset = (13 - #value)/2
        term.setCursorPos(centreOffset,2+offset)
        term.write(value)
        offset = offset + size + 1


    end

end

-- touch event handler
function HandleTouchEvent(event)

end

Main()