top.ipc      = require('electron').ipcRenderer
top.riot     = require 'riot'
top.observer = riot.observable()

# component
require '../scripts/components/js/seek-bar'
require '../scripts/components/js/title-bar'
require '../scripts/components/js/content'
require '../scripts/components/js/music-title'
require '../scripts/components/js/slider'
require '../scripts/components/js/control-box'
require '../scripts/components/js/volume-box'
require '../scripts/components/js/playlist'
require '../scripts/components/js/back-btn'

# load -------------------------------------------------
window.addEventListener 'load', ->
	riot.mount '*'

# dir --------------------------------------------------
ipc.on 'dir', (event, data) ->
