seek-bar
	div.current.area { current }
	slider.area(
		width="200"
		mode="seek"
		per="{ per }"
	)
	div.area.duration { duration }

	style(scoped).
		:scope {
			display: block;
			width: 280px;
			height: 30px;
			margin: 0 auto;
		}
		:scope:after {
			content: "";
			display: block;
			clear: both;
		}
		:scope .area {
			float: left;
		}
		:scope .current,
		:scope .duration {
			width: 40px;
			height: 30px;
			font-size: 10px;
			color: #ccc;
			text-align: center;
			line-height: 30px;
		}
		:scope slider {
			margin-top: 12.5px;
		}

	script(type="coffee").

		##
		# 時間の設置
		##
		@setTime = ->
			list     = JSON.parse localStorage['playlist']
			time     = parseFloat localStorage['time']
			duration = parseFloat localStorage['duration']

			if not list.length
				@current  = '0:00'
				@duration = '0:00'
				@per      = 0
			else
				@current  = castTime time
				@duration = castTime duration
				@per      = time / duration

			# 更新
			@update()

		##
		# 時間を文字列に変換
		# @param  time : 時間
		# @return 時間文字列
		##
		castTime = (time) ->
			if time >= 60
				minu = parseInt(time / 60)
				sec  = parseInt(time % 60)
			else
				minu = 0
				sec  = parseInt time

			if sec < 10
				sec = '0' + sec

			return minu + ':' + sec

		# mount ------------------------------------------------
		@on 'mount', ->
			@setTime()

		# seek ---------------------------------------------
		observer.on 'seek', =>
			@setTime()

