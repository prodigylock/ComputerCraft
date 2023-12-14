-- Sets the possible floors and peripherals
Floors = {"2","1","S"}
Monitor = peripheral.wrap("top")

function Main()
        
    term.redirect(Monitor)
    term.setBackgroundColour(colors.black)
    term.clear()

    Display()

end


--one block is 7x5px
function Display()
    local top = 15
    local bottom = 20-15
    Monitor.setTextScale(0.5)
    --Creates two windows (top and bottom) for fixed screen
    --table parentTerm, number x, number y, number width, number height [, boolean visible]   
    floorWindow = window.create(Monitor,2,5,13,16,true)
    downWindow = window.create(Monitor,2,22,13,2,true)
    upWindow = window.create(Monitor,2,2,13,2,true)

    floorWindow.setBackgroundColour(colors.red)
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

end

-- touch event handler
function handleTouchEvent()

end

Main()