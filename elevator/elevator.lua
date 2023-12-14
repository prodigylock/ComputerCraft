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
    floorWindow = window.create(Monitor,2,2,14,15,true)
    pageWindow = window.create(Monitor,top+2,2,14,3,true)

    
    term.redirect(pageWindow)
    paintutils.drawFilledBox(1,1,14,5,colors.blue)

    floorWindow.setBackgroundColour(colors.red)
    pageWindow.setBackgroundColour(colors.blue)
    
    floorWindow.clear()
    pageWindow.clear()
    --creates a window for every floor

    --creates a window for next/previous page buttons and page counter

end

Main()