
function Main()
    monitor1 = peripheral.wrap("top")

    buttons = {}
    --buttons(sizex,sizey,lable,color
    buttons.left= Button(10,3,"Left",colors.lime,colors.red,colors.white,colors.yellow,true,colors.green,colors.pink,1,1,false,nil,nil)
    --buttons.right = Button(10,3,"Right",colors.lime,colors.red,colors.white,colors.yellow,true,colors.green,colors.pink,1,4,false,nil,nil)
    --buttons.bottom = Button(10,3,"Bottom",colors.lime,colors.red,colors.white,colors.yellow,true,colors.green,colors.pink,1,7,false,nil,nil)

    local quit = Button(8,1,"Quit",colors.gray,colors.black,colors.black,colors.white,false,nil,nil,4,10,false,nil,nil)

    -- Display buttons on monitor1
    monitor1.clear()
    monitor1.setTextScale(0.5)

    for key,button in pairs(buttons) do
    button.draw(monitor1)
    end
    quit.draw(monitor1)
    -- this is our event loop
    while true do

        event ={os.pullEvent()}--gets event


        if event[1] =="monitor_touch" then
            for key,button in pairs(buttons) do
                if button.clicked(event[3],event[4]) then -- column,row
                    --redstone.setOutput(key,button.toggle())     add elevator functions
                    button.draw(monitor1)
                    break -- we found on, so we don't need to keep looking
                end
            end
            if quit.clicked(event[3],event[4]) == true then
                os.queueEvent("key",keys.q)
                end
            elseif event[1] =="key" and event[2]==keys.q then
                break
        end
    end
end

local function Button(
        width,
        height,
        label,
        backgroundColorNormal,                                
        backgroundColorPressed,
        textColorNormal,
        textColorPressed,
        hasBorder,
        borderColorNormal,
        borderColorPressed,
        startColumn,
        startRow,
        isPressed,
        defaultBackgroundColor,
        defaultTextColor
    )
    local button = {}
    button.height=height or 1
    button.width=width or 1
    button.label=label or ""
    button.backgroundColorNormal=backgroundColorNormal or colors.black
    button.backgroundColorPressed=backgroundColorPressed or colors.white
    button.textColorNormal=textColorNormal or colors.white
    button.textColorPressed=textColorPressed or colors.black
    button.hasBorder = hasBorder or false
    button.borderColorNormal = borderColorNormal or backGroundColorNormal
    button.borderColorPressed = borderColorPressed or backGroundColorPressed
    button.defaultBackgroundColor = defaultBackgroundColor or colors.black
    button.defaultTextColor = defaultTextColor or colors.white
    button.startColumn = startColumn or 1
    button.startRow = startRow or 1
    button.isPressed=isPressed or false
    function button.press()
        button.isPressed = not button.isPressed
    end

    function button.clicked(column,row) --returns whether or not the button is clicked with the coordinates
        return (column >= button.startColumn and column < button.startColumn + button.width and row >= button.startRow and row < button.startRow + button.height)
    end

    function button.draw(display,isPressed,startColumn,startRow)

        button.startColumn = startColumn or button.startColumn
        button.startRow = startRow or button.startRow
        display = display or term
        if isPressed == false or isPressed then
            button.isPressed = isPressed
        else 
            isPressed = button.isPressed
        end
        local width = button.width
        local height = button.height
        startRow = button.startRow
        startColumn = button.startColumn

        local label = button.label
        local labelPad = 2

        -- set border params and draw border if hasBorder
        if button.hasBorder == true then
        -- button must be at least 3x3, if not, make it so
        if width < 3 then
            width = 3
        end
        if height < 3 then
            height = 3
        end

        -- set border colors
        if not isPressed then
        if not display.isColor() then
        display.setBackgroundColor(colors.white)
        else
        display.setBackgroundColor(button.borderColorNormal)
        end
        else
        if not display.isColor() then
        display.setBackgroundColor(colors.white)
        else
        display.setBackgroundColor(button.borderColorPressed)
        end
        end

        -- draw button border (inset)
        display.setCursorPos(startColumn,startRow)
        display.write(string.rep(" ",width))
        for row = 2,height-1 do
        display.setCursorPos(startColumn,button.startRow+row -1)
        display.write(" ")
        display.setCursorPos(startColumn+width -1 ,startRow + row-1)
        display.write(" ")
        end
        display.setCursorPos(startColumn,startRow+height-1)
        display.write(string.rep(" ",width))

        -- reset startColumn,startRow,width,column to inset button and label
        startColumn=startColumn+1
        startRow = startRow +1
        width = width - 2
        height = height - 2
        end

        --set button background and text colors
        if not isPressed then
            if not display.isColor() then
                display.setBackgroundColor(colors.black)
                display.setTextColor(colors.white)
            else
                display.setBackgroundColor(button.backgroundColorNormal)
                display.setTextColor(button.textColorNormal)
            end
        else
        if not display.isColor() then
            display.setBackgroundColor(colors.white)
            display.setTextColor(colors.black)
        else
            display.setBackgroundColor(button.backgroundColorPressed)
            display.setTextColor(button.textColorPressed)
        end
    end

    -- draw button background (will be inside border if there is one)
    for row = 1,height do
    --print(tostring(startColumn)..","..tostring(startRow-row))
    display.setCursorPos(startColumn,startRow + row -1)
    display.write(string.rep(" ",width))
    end

    -- prepare label, truncate label if necessary

    -- prepare label, truncate label if necessary
    if width < 3 then
    labelPad = 0
    end
    if #label > width - labelPad then
    label = label:sub(1,width - labelPad)
    end

    -- draw label
    display.setCursorPos(startColumn + math.floor((width - #label)/2),startRow + math.floor((height-1)/2))
    display.write(label)
    display.setBackgroundColor(button.defaultBackgroundColor)
    display.setTextColor(button.defaultTextColor)
    end
    button.toggle = function ()
    button.isPressed = not button.isPressed
    return button.isPressed
    end             
    return button
end

Main()