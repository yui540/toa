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

module.exports = new Music()