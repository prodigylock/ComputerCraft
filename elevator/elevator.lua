-- Sets the possible floors and peripherals


function Main()
    local version = 2.104
    print("version: "..version)
    Floors = {"S-1","S","1","2"}
    GroundFloor = 3
    Monitor = peripheral.wrap("top")
        
    term.redirect(Monitor)
    term.setBackgroundColour(colors.black)
    term.clear()
    
    Display()
    --term.redirect(term.native())
    while true do

        event ={os.pullEvent()}--gets event


        if event[1] =="monitor_touch" then
            for key,button in pairs(buttons) do
                if button.clicked(event[3],event[4]) then -- column,row
                    --redstone.setOutput(key,button.toggle())     add elevator functions
                    print("TouchMid")
                    button.draw(Monitor)
                    break -- we found on, so we don't need to keep looking
                end
            end
            if upHandler(event[3],event[4]) then
                print("TouchUp")
                FloorOffset = FloorOffset+1
                print("TouchDown")
            elseif downHandler(event[3],event[4]) then
                FloorOffset = FloorOffset-1
            end

        elseif event[1] =="key" and event[2]==keys.q then
            break
        end
    end
    --while loop event handlers

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

    --drawing top and bottom buttons
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

    -- add logic for 6 or more floors to seperate into two columns
    -- invert layers or make them come from the bottom
    --gray out/make invisible up/down if unavailable
    -- test states saving after moving
    term.redirect(floorWindow)
    FloorOffset = 0
    local size = 3
    local buttonOffset = 0
    --sliding window for floors
    buttons = {}
    for i = GroundFloor+4*FloorOffset,GroundFloor+3 , 1 do
        if i>#Floors then break end
        buttons[i] = Button(13,3,Floors[i],colors.lightBlue,colors.red,colors.yellow,colors.white,false,_,_,2,13-buttonOffset,false)

        --paintutils.drawFilledBox(1,1+buttonOffset,13,3+buttonOffset,colors.lightBlue)
        --add number in centre
        --local centreOffset = (13 - #value)/2
        --term.setCursorPos(centreOffset,2+buttonOffset)
        --term.write(Floors[1])
        buttonOffset = buttonOffset + size + 1
    end

    for key,button in pairs(buttons) do
        button.draw(Monitor)
    end
    
    -- for index, value in ipairs(Floors) do
    --     --draws box 
    --     paintutils.drawFilledBox(1,1+buttonOffset,13,3+buttonOffset,colors.lightBlue)
    --     --add number in centre
    --     local centreOffset = (13 - #value)/2
    --     term.setCursorPos(centreOffset,2+buttonOffset)
    --     term.write(value)
    --     buttonOffset = buttonOffset + size + 1


    -- end

end

function upHandler(x,y)
    return ((x>1 and x<15)and (y<6 and y>2))
end
function downHandler(x,y)
    return ((x>1 and x<15)and (y>16 and y<20))
end

Main()