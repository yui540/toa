class Music
	constructor: ->
		@audio = new Audio()

		@timer    = null
		@path     = null
		@current  = 0
		@duration = 0
	
	##
	# 音楽の準備
	# @param m_path : 音楽パス
	# @param fn     : コールバック
	##
	set: (m_path, fn) ->
		@path = m_path

		# loadedmetadata ---------------------------------
		@audio.addEventListener 'loadedmetadata', (e) =>
			@duration = @audio.duration
			localStorage['duration'] = @duration

			# 音量
			@volume parseFloat localStorage['volume']

			# コールバック発火
			fn()
		, false

		@audio.src = m_path

	##
	# 音楽の再生
	##
	play: ->
		@audio.play()

		@timer = setInterval =>
			@current = @audio.currentTime

			# 曲終了
			if @current >= @duration
				@fin()

			# localStorageへの書き込み
			localStorage['time'] = @current

			# イベント発火
			observer.trigger 'seek', @current / @duration
		, 1000

	##
	# 音楽の停止
	##
	pause: ->
		@audio.pause()
		clearInterval @timer

	##
	# 再生位置の移動
	# @param per : 割合
	##
	move: (per) ->
		time     = @duration * per
		@current = time

		localStorage['time'] = @current
		@audio.currentTime   = @current

	##
	# 音量の調整
	# @param per : 割合
	##
	volume: (per) ->
		@audio.volume = per

	##
	# 全曲リピート
	##
	repeatAll: ->
		localStorage['repeat'] = 'repeat'

	##
	# 1曲リピート
	##
	repeatOne: ->
		localStorage['repeat'] = 'repeat-one'

	##
	# 曲の選択
	# @param num : 曲番号
	##
	select: (num) ->
		list  = JSON.parse localStorage['playlist']

		localStorage['current'] = num
		_path = list[num].path

		@set _path, =>
			@move 0
			@play()
			observer.trigger 'seek', 0

			# イベント発火
			observer.trigger 'change-music'

	##
	# 最初の曲
	##
	first: ->
		list  = JSON.parse localStorage['playlist']

		localStorage['current'] = 0
		_path = list[0].path

		@set _path, =>
			@move 0
			@play()
			observer.trigger 'seek', 0

			# イベント発火
			observer.trigger 'change-music'

	##
	# 次の曲
	##
	next: ->
		num   = parseInt localStorage['current']
		list  = JSON.parse localStorage['playlist']

		if num >= list.length - 1
			return false
			
		num += 1

		localStorage['current'] = num
		_path = list[num].path

		@set _path, =>
			@move 0
			@play()
			observer.trigger 'seek', 0

			# イベント発火
			observer.trigger 'change-music'

		return true

	##
	# 前の曲
	##
	back: ->
		num   = parseInt localStorage['current']
		list  = JSON.parse localStorage['playlist']

		if num <= 0
			return false

		num -= 1

		localStorage['current'] = num
		_path = list[num].path

		@set _path, =>
			@move 0
			@play()
			observer.trigger 'seek', 0

			# イベント発火
			observer.trigger 'change-music'

		return true

	##
	# 曲終了時の処理
	##
	fin: ->

		# 全曲リピート
		if localStorage['repeat'] is 'repeat'
			if not @next()
				@first()

		# 1曲リピート
		else
			@move 0
			@play()

module.exports = new Music()