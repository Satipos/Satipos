-- Roblox Speed Injector Script
-- Автоматически определяет игрока и добавляет слайдер скорости

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Ожидание загрузки игрока
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Создание интерфейса
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SpeedInjectorUI"
ScreenGui.Parent = player.PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Основной фрейм
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 250)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Скругление углов
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Тень
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(60, 60, 80)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Заголовок с кнопками
local Title = Instance.new("Frame")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
Title.BorderSizePixel = 0
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

-- Текст заголовка
local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(1, -80, 1, 0)
TitleText.Position = UDim2.new(0, 40, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "⚡ SPEED INJECTOR"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 20
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = Title

-- Иконка скорости
local SpeedIcon = Instance.new("ImageLabel")
SpeedIcon.Name = "SpeedIcon"
SpeedIcon.Size = UDim2.new(0, 24, 0, 24)
SpeedIcon.Position = UDim2.new(0, 10, 0, 13)
SpeedIcon.BackgroundTransparency = 1
SpeedIcon.Image = "rbxassetid://3926305904"
SpeedIcon.ImageRectOffset = Vector2.new(124, 364)
SpeedIcon.ImageRectSize = Vector2.new(36, 36)
SpeedIcon.ImageColor3 = Color3.fromRGB(0, 170, 255)
SpeedIcon.Parent = Title

-- Кнопка закрытия
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0.5, -15)
CloseButton.AnchorPoint = Vector2.new(1, 0.5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 20
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = Title

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

-- Кнопка сворачивания
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -70, 0.5, -15)
MinimizeButton.AnchorPoint = Vector2.new(1, 0.5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Text = "_"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 16
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Parent = Title

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 6)
MinimizeCorner.Parent = MinimizeButton

-- Контейнер для настроек
local SettingsFrame = Instance.new("Frame")
SettingsFrame.Name = "SettingsFrame"
SettingsFrame.Size = UDim2.new(1, -30, 0, 180)
SettingsFrame.Position = UDim2.new(0, 15, 0, 60)
SettingsFrame.BackgroundTransparency = 1
SettingsFrame.Parent = MainFrame

-- Метка скорости
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Name = "SpeedLabel"
SpeedLabel.Size = UDim2.new(1, 0, 0, 20)
SpeedLabel.Position = UDim2.new(0, 0, 0, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "SPEED: 16"
SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
SpeedLabel.TextSize = 16
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = SettingsFrame

-- Ползунок скорости
local SliderFrame = Instance.new("Frame")
SliderFrame.Name = "SliderFrame"
SliderFrame.Size = UDim2.new(1, 0, 0, 30)
SliderFrame.Position = UDim2.new(0, 0, 0, 25)
SliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
SliderFrame.BorderSizePixel = 0
SliderFrame.Parent = SettingsFrame

local SliderCorner = Instance.new("UICorner")
SliderCorner.CornerRadius = UDim.new(0, 8)
SliderCorner.Parent = SliderFrame

-- Заполнение слайдера
local SliderFill = Instance.new("Frame")
SliderFill.Name = "SliderFill"
SliderFill.Size = UDim2.new(0, 0, 1, 0)
SliderFill.Position = UDim2.new(0, 0, 0, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
SliderFill.BorderSizePixel = 0
SliderFill.Parent = SliderFrame

local FillCorner = Instance.new("UICorner")
FillCorner.CornerRadius = UDim.new(0, 8)
FillCorner.Parent = SliderFill

-- Кнопка слайдера
local SliderButton = Instance.new("TextButton")
SliderButton.Name = "SliderButton"
SliderButton.Size = UDim2.new(0, 20, 0, 20)
SliderButton.Position = UDim2.new(0, 0, 0.5, -10)
SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SliderButton.BorderSizePixel = 0
SliderButton.Text = ""
SliderButton.Parent = SliderFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 10)
ButtonCorner.Parent = SliderButton

-- Отображение значения
local ValueLabel = Instance.new("TextLabel")
ValueLabel.Name = "ValueLabel"
ValueLabel.Size = UDim2.new(0, 60, 0, 20)
ValueLabel.Position = UDim2.new(1, -60, 0, 60)
ValueLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
ValueLabel.BorderSizePixel = 0
ValueLabel.Text = "16"
ValueLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
ValueLabel.TextSize = 16
ValueLabel.Font = Enum.Font.GothamBold
ValueLabel.Parent = SettingsFrame

local ValueCorner = Instance.new("UICorner")
ValueCorner.CornerRadius = UDim.new(0, 6)
ValueCorner.Parent = ValueLabel

-- Секция спиннера
local SpinSection = Instance.new("Frame")
SpinSection.Name = "SpinSection"
SpinSection.Size = UDim2.new(1, 0, 0, 40)
SpinSection.Position = UDim2.new(0, 0, 0, 100)
SpinSection.BackgroundTransparency = 1
SpinSection.Parent = SettingsFrame

local SpinLabel = Instance.new("TextLabel")
SpinLabel.Name = "SpinLabel"
SpinLabel.Size = UDim2.new(0, 80, 1, 0)
SpinLabel.Position = UDim2.new(0, 0, 0, 0)
SpinLabel.BackgroundTransparency = 1
SpinLabel.Text = "SPIN:"
SpinLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
SpinLabel.TextSize = 16
SpinLabel.Font = Enum.Font.Gotham
SpinLabel.TextXAlignment = Enum.TextXAlignment.Left
SpinLabel.Parent = SpinSection

local SpinButton = Instance.new("TextButton")
SpinButton.Name = "SpinButton"
SpinButton.Size = UDim2.new(0, 80, 1, 0)
SpinButton.Position = UDim2.new(0, 90, 0, 0)
SpinButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
SpinButton.BorderSizePixel = 0
SpinButton.Text = "ENABLE"
SpinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SpinButton.TextSize = 14
SpinButton.Font = Enum.Font.GothamBold
SpinButton.Parent = SpinSection

local SpinCorner = Instance.new("UICorner")
SpinCorner.CornerRadius = UDim.new(0, 6)
SpinCorner.Parent = SpinButton

-- Кнопка применения
local ApplyButton = Instance.new("TextButton")
ApplyButton.Name = "ApplyButton"
ApplyButton.Size = UDim2.new(1, 0, 0, 40)
ApplyButton.Position = UDim2.new(0, 0, 1, -50)
ApplyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
ApplyButton.BorderSizePixel = 0
ApplyButton.Text = "APPLY SPEED"
ApplyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ApplyButton.TextSize = 16
ApplyButton.Font = Enum.Font.GothamBold
ApplyButton.Parent = SettingsFrame

local ApplyCorner = Instance.new("UICorner")
ApplyCorner.CornerRadius = UDim.new(0, 8)
ApplyCorner.Parent = ApplyButton

-- Анимации кнопок
local function setupButtonHover(button, normalColor, hoverColor)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = normalColor}):Play()
    end)
end

setupButtonHover(ApplyButton, Color3.fromRGB(0, 170, 255), Color3.fromRGB(20, 150, 230))
setupButtonHover(SpinButton, Color3.fromRGB(0, 170, 255), Color3.fromRGB(20, 150, 230))
setupButtonHover(CloseButton, Color3.fromRGB(200, 60, 60), Color3.fromRGB(220, 80, 80))
setupButtonHover(MinimizeButton, Color3.fromRGB(80, 80, 100), Color3.fromRGB(100, 100, 120))

-- Переменные
local minValue = 0
local maxValue = 5000
local currentValue = 16
local isSliding = false
local spinEnabled = false
local spinConnection = nil

-- Функция обновления слайдера
local function updateSlider(value)
    currentValue = math.clamp(value, minValue, maxValue)
    local percentage = (currentValue - minValue) / (maxValue - minValue)
    
    SliderFill.Size = UDim2.new(percentage, 0, 1, 0)
    SliderButton.Position = UDim2.new(percentage, -10, 0.5, -10)
    
    ValueLabel.Text = tostring(math.floor(currentValue))
    SpeedLabel.Text = "SPEED: " .. math.floor(currentValue)
end

-- Функция спиннера
local function toggleSpin()
    spinEnabled = not spinEnabled
    
    if spinEnabled then
        SpinButton.Text = "DISABLE"
        SpinButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
        
        -- Создаем спиннер
        if spinConnection then
            spinConnection:Disconnect()
        end
        
        spinConnection = RunService.Heartbeat:Connect(function(deltaTime)
            if character and character:FindFirstChild("HumanoidRootPart") then
                local rootPart = character.HumanoidRootPart
                local currentRotation = rootPart.Orientation
                rootPart.Orientation = Vector3.new(
                    currentRotation.X,
                    currentRotation.Y + (deltaTime * 720), -- 2 оборота в секунду
                    currentRotation.Z
                )
            end
        end)
    else
        SpinButton.Text = "ENABLE"
        SpinButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        
        if spinConnection then
            spinConnection:Disconnect()
            spinConnection = nil
        end
    end
end

-- Обработка слайдера
SliderButton.MouseButton1Down:Connect(function()
    isSliding = true
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isSliding = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if isSliding and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = UIS:GetMouseLocation()
        local sliderAbsPos = SliderFrame.AbsolutePosition
        local sliderAbsSize = SliderFrame.AbsoluteSize
        
        local relativeX = math.clamp((mousePos.X - sliderAbsPos.X) / sliderAbsSize.X, 0, 1)
        local newValue = minValue + relativeX * (maxValue - minValue)
        
        updateSlider(newValue)
    end
end)

-- Обработка клика по слайдеру
SliderFrame.MouseButton1Down:Connect(function(x, y)
    local relativeX = (x - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X
    local newValue = minValue + math.clamp(relativeX, 0, 1) * (maxValue - minValue)
    
    updateSlider(newValue)
end)

-- Применение скорости
ApplyButton.MouseButton1Click:Connect(function()
    humanoid.WalkSpeed = currentValue
    
    -- Анимация применения
    local originalColor = ApplyButton.BackgroundColor3
    TweenService:Create(ApplyButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(0, 255, 150)}):Play()
    wait(0.1)
    TweenService:Create(ApplyButton, TweenInfo.new(0.3), {BackgroundColor3 = originalColor}):Play()
end)

-- Переключение спиннера
SpinButton.MouseButton1Click:Connect(function()
    toggleSpin()
end)

-- Закрытие UI
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    if spinConnection then
        spinConnection:Disconnect()
    end
end)

-- Сворачивание UI
local isMinimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    
    if isMinimized then
        TweenService:Create(SettingsFrame, TweenInfo.new(0.3), {Size = UDim2.new(1, -30, 0, 0)}):Play()
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 350, 0, 50)}):Play()
        MinimizeButton.Text = "+"
    else
        TweenService:Create(SettingsFrame, TweenInfo.new(0.3), {Size = UDim2.new(1, -30, 0, 180)}):Play()
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 350, 0, 250)}):Play()
        MinimizeButton.Text = "_"
    end
end)

-- Перетаскивание окна
local dragStart = nil
local startPos = nil

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragStart = nil
            end
        end)
    end
end)

Title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragStart then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, 
                                      startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Инициализация
updateSlider(16)

print("⚡ Speed Injector loaded successfully! Current speed: " .. currentValue)
