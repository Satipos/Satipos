-- Colors and styles mimicking an iOS style
local themes = {
    Background = Color3.fromRGB(240, 240, 240),
    Surface = Color3.fromRGB(255, 255, 255),
    Accent = Color3.fromRGB(0, 122, 255),
    LightContrast = Color3.fromRGB(220, 220, 220),
    DarkContrast = Color3.fromRGB(200, 200, 200),
    TextColor = Color3.fromRGB(0, 0, 0),
    PlaceholderColor = Color3.fromRGB(150, 150, 150),
    ShadowColor = Color3.fromRGB(0, 0, 0), -- for shadows
}

-- Function to create rounded corners
function utility:CreateRounded(size, color)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, size, 0, size)
    frame.BackgroundColor3 = color
    frame.BorderSizePixel = 0
    return frame
end

-- Function to apply shadows
function utility:ApplyShadow(object)
    local shadow = utility:Create("Frame", {
        BackgroundTransparency = 0.5,
        Size = UDim2.new(1.1, 0, 1.1, 0),
        Position = UDim2.new(0, -5, 0, 5),
        BackgroundColor3 = themes.ShadowColor,
        BorderSizePixel = 0,
        ZIndex = 0,
    })

    shadow.Parent = object
end

local library = {}

function library.new(title)
    local container = utility:Create("ScreenGui", {
        Name = title,
        Parent = game.CoreGui
    }, {
        utility:Create("Frame", {
            Name = "Main",
            BackgroundColor3 = themes.Surface,
            Size = UDim2.new(0.5, 0, 0.75, 0),
            Position = UDim2.new(0.25, 0, 0.125, 0),
            ClipsDescendants = true,
            BorderSizePixel = 0,
        }, {
            utility:CreateRounded(25, themes.LightContrast),
            utility:Create("UIListLayout"),
        })
    })

    -- Apply shadow to the main frame
    utility:ApplyShadow(container.Main)
    
    -- Header
    local titleBar = utility:Create("Frame", {
        Name = "TitleBar",
        BackgroundColor3 = themes.Accent,
        Size = UDim2.new(1, 0, 0, 50),
        BorderSizePixel = 0,
    })
    titleBar.Parent = container.Main

    utility:CreateRounded(25, themes.Accent).Parent = titleBar

    utility:Create("TextLabel", {
        Name = "Title",
        Position = UDim2.new(0.05, 0, 0.5, -10),
        Size = UDim2.new(0.9, 0, 1, 0),
        BackgroundTransparency = 1,
        TextColor3 = themes.TextColor,
        Font = Enum.Font.GothamBold,
        TextSize = 24,
        Text = title
    }).Parent = titleBar

    return setmetatable({
        container = container,
    }, { __index = library })
end

-- Additional Widgets with new styles, respect iOS aesthetics
function section:addButton(title, callback)
    local button = utility:Create("TextButton", {
        Name = "Button",
        Parent = self.Container,
        AnchorPoint = Vector2.new(0, 0),
        BackgroundColor3 = themes.Accent,
        Size = UDim2.new(1, 0, 0, 40),
        Text = title,
        TextColor3 = themes.TextColor,
        Font = Enum.Font.Gotham,
        TextSize = 18,
        TextStrokeColor3 = themes.Surface,
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.None,
    })

    -- Rounded corners and shadow
    utility:ApplyShadow(button)
    
    button.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)

    return button
end

function section:addTextbox(title, default, callback)
    local textboxContainer = utility:Create("Frame", {
        Parent = self.Container,
        Size = UDim2.new(1, 0, 0, 50),
        BackgroundTransparency = 1
    })

    local textbox = utility:Create("TextBox", {
        Parent = textboxContainer,
        Size = UDim2.new(1, -10, 0, 30),
        Position = UDim2.new(0, 5, 0, 10),
        PlaceholderText = title,
        BackgroundColor3 = themes.LightContrast,
        TextColor3 = themes.TextColor,
        Font = Enum.Font.Gotham,
        TextSize = 18,
        ClearTextOnFocus = false,
        Text = default or "",
    })

    textbox.Focused:Connect(function()
        textbox.BackgroundColor3 = themes.Accent
        textbox.TextSize = 20
    end)

    textbox.FocusLost:Connect(function()
        textbox.BackgroundColor3 = themes.LightContrast
        textbox.TextSize = 18
        if callback then
            callback(textbox.Text)
        end
    end)

    -- Rounded corners and shadow
    utility:ApplyShadow(textbox)

    return textbox
end

-- Example Usage:
local myLibrary = library.new("My iOS Styled Library")
local mySection = myLibrary:addSection("Sample Section")

mySection:addButton("Click Me!", function()
    print("Button Clicked!")
end)

mySection:addTextbox("Enter Text", "", function(text)
    print("Textbox input: " .. text)
end)

-- Finally, activate your GUI
myLibrary:SelectPage(mySection)
