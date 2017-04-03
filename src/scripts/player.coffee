top.ipc      = require('electron').ipcRenderer
top.dialog   = require('electron').remote.dialog
top.path     = require 'path'
top.fs       = require 'fs'
top.riot     = require 'riot'
top.music    = require '../scripts/util/music'
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
	init() # 初期化
	set()  # 起動時の処理

	riot.mount '*'

# play -------------------------------------------------
observer.on 'play', ->
	localStorage['play'] = true
	music.play()

# pause ------------------------------------------------
observer.on 'pause', ->
	localStorage['play'] = false
	music.pause()

# seek -------------------------------------------------
observer.on 'seek', (data) ->

# volume -----------------------------------------------
observer.on 'volume', (volume) ->
	localStorage['volume'] = volume
	music.volume volume

# open dir ---------------------------------------------
observer.on 'open-dir', ->
	opts = { properties: ['openDirectory'] }
	dialog.showOpenDialog opts, (d_path) ->
		d_path = d_path[0]

		# プレイリストを開く
		openPlayList d_path

##
# 初期化
##
init = ->
	if localStorage['current'] is undefined
		localStorage['current']  = 0
		localStorage['playlist'] = '[]'
		localStorage['repeat']   = 'repeat'
		localStorage['volume']   = 1.0
		localStorage['time']     = 0
		localStorage['duration'] = 0
		localStorage['play']     = false

##
# 起動時の処理
##
set = ->
	time     = parseFloat localStorage['time']
	duration = parseFloat localStorage['duration']
	num      = parseInt   localStorage['current']
	list     = JSON.parse localStorage['playlist']
	per      = time / duration

	if list.length
		_path = list[num].path
		music.set _path, ->
			music.move per
			observer.trigger 'seek', per

			# 再生
			if localStorage['play'] is 'true'
				music.play()

			# 停止
			else
				music.pause()

##
# ディレクトリの読み取り
# @param d_path : ディレクトリパス
##
readdir = (d_path) ->
	try
		return fs.readdirSync d_path, 'utf8'
	catch e
		return false

##
# プレイリストを開く
# @param d_path : ディレクトリパス
##
openPlayList = (d_path) ->

	# mp3の抽出
	_dir = readdir d_path
	_dir = _dir.filter (ele, index, array) ->
		if ele.match /^.+\.mp3$/
			return ele
	_dir = _dir.map (ele, index, array) ->
		return path.join d_path, ele

	dir = []
	for val, i in _dir
		title = path.basename val
		title = title.replace /\.mp3$/, ''

		dir.push 
			num   : i
			path  : val
			title : title

	# localStorage書き込み
	dir = JSON.stringify dir
	localStorage['current']  = 0
	localStorage['playlist'] = dir

	# イベント発火
	observer.trigger 'change-playlist'
	
