
local composer = require("composer")
local widget = require( "widget" )

local scene = composer.newScene()

--https://www.java.com/pt_BR/download/

local page
local bg
--local title

function scene:create( event )

  local sceneGroup = self.view

  bg = display.newRect(sceneGroup, 0, 0, display.contentWidth, display.contentHeight)
  bg.anchorX = 0
  bg.anchorY = 0
  bg:setFillColor(1,0,0) 

  function networkListener( event )

    if ( event.isError ) then
      print( "Network error: ", event.response )
    else
      local dados = event.response

      local pageLimited = string.match(dados,"<h4 class=\"sub\">......................")

      local pageLimited2 = string.sub(pageLimited,18,38)

      local pageLimited3 = string.gsub(pageLimited2,"\n","")
      local dataFormatted = "Java: " ..  pageLimited3 
      --local title = display.newText(sceneGroup, dataFormatted, display.contentCenterX, display.contentCenterY, native.systemFont, 14 )    

      local path = system.pathForFile( "versions.txt", system.DocumentsDirectory )
      local file, errorString = io.open( path, "w" )

      if not file then
        print( "File error: " .. errorString )
      else
        file:write( dataFormatted)
        io.close( file )
      end

      file = nil 
      
    end
  end  

  network.request( "https://www.java.com/pt_BR/download/", "GET", networkListener )

end

function scene:show( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then

  elseif ( phase == "did" ) then

    local path = system.pathForFile( "versions.txt", system.DocumentsDirectory )

    local file, errorString = io.open( path, "r" )

    if not file then
     
      print( "File error: " .. errorString )
      
    else
      
      contents = file:read( "*a" )
     
      io.close( file )
      
    end

    file = nil

    local function onRowRender( event )

      local row = event.row

      local rowHeight = row.contentHeight
      local rowWidth = row.contentWidth

      local rowTitle = display.newText( row, contents, 0, 0, nil, 14 )
      rowTitle:setFillColor( 0 )

      rowTitle.anchorX = 0
      rowTitle.x = 8
      rowTitle.y = rowHeight * 0.5
      
    end 

    local tableView = widget.newTableView(
      {
        left = 0,
        top = display.contentCenterY + 20,
        height = display.contentHeight - display.contentCenterY + 12,
        width = display.contentWidth,
        onRowRender = onRowRender,
        onRowTouch = onRowTouch,
        listener = scrollListener
      }
    )

    for i = 1, 1 do

      tableView:insertRow{}

    end

  end

end 

function scene:hide( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then

  elseif ( phase == "did" ) then

  end
end 

-- destroy()
function scene:destroy( event )

  local sceneGroup = self.view

end 

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene