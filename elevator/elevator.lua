-- Sets the possible floors and peripherals
Floors = {"2","1","S"}
Monitor = peripheral.wrap("top")

function Main()
        
    term.redirect(monitor)
    term.setBackgroundColour(colors.black)
    term.clear()

    Display()

end


--one block is 7x5px
function Display()
    local top = 15
    local bottom = 20-15
    monitor.setTextScale(0.5)
    --Creates two windows (top and bottom) for fixed screen
    --table parentTerm, number x, number y, number width, number height [, boolean visible]   
    floorWindow = window.create(term,1,1,14,15)
    pageWindow = window.create(term,top+1,1,14,5)

    floorWindow.setBackgroundColour(colors.red)
    pagesWindow.setBackgroundColour(colors.blue)

    --creates a window for every floor

    --creates a window for next/previous page buttons and page counter

end

Main()