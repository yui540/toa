path     = require 'path'
electron = require 'electron'
app      = electron.app
ipc      = electron.ipcMain
dialog   = electron.dialog
Browser  = electron.BrowserWindow

# config
window_path   = 'file://' + path.join(__dirname, '../../views/html/player.html')
window_config = require '../../config/window.json'

# window
player = null

# make single instance --------------------------------------
shouldQuit = app.makeSingleInstance ->
  if player
    if player.isMinimized()
      player.restore()
    player.focus()

if shouldQuit
  app.quit()

# ready -----------------------------------------------------
app.on 'ready', ->
	player = new Browser window_config
	player.loadURL window_path

  #player.webContents.toggleDevTools()

	# closed --------------------------------------------------
	player.on 'closed', ->
		player = null

# window all closed -----------------------------------------
app.on 'window-all-closed', ->
	app.quit()

# close ------------------------------------------------------
ipc.on 'close', ->
	console.log 1
	player.close()
