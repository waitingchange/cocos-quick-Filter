
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    cc.ui.UILabel.new({
            UILabelType = 2, text = "Hello, World", size = 64})
        :align(display.CENTER, display.cx, display.cy)
        :addTo(self)



    local cx = display.cx;
    local cy = display.cy;



    display.newSprite("bg.jpg")
    	:pos(display.cx,display.cy)
        :addTo(self)


    local parentNode = self
    local childTag = 1000
    local winSize = cc.Director:getInstance():getWinSize()
    local fileName = "CaptureScreen.png"
    local firstSpr
    cc.Director:getInstance():getTextureCache():removeTextureForKey(fileName)
    cc.utils:captureScreen(function( succeed, outputFile )
       if succeed then
            firstSpr = cc.Sprite:create(outputFile)
            parentNode:addChild(firstSpr, -1, childTag)
            local spSize = firstSpr:getContentSize()
           
            -- fileName = outputFile

            local texure = firstSpr:getTexture()
            local   __curFilter ={ {"GAUSSIAN_VBLUR", "GAUSSIAN_HBLUR"}, {{2}, {2}}}
   
            local __filters, __params = unpack(__curFilter)
            if __params and #__params == 0 then
                __params = nil
            end
            local _fSprite = display.newFilteredSprite(texure, __filters, __params)
            _fSprite:setScaleX(winSize.width / spSize.width)
            _fSprite:setScaleY(winSize.height / spSize.height)

            parentNode:addChild(_fSprite)
            parentNode:removeChildByTag(childTag)

            print("fuck render ")
        else
            cclog("Capture screen failed.")
        end
    end, fileName)


end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
