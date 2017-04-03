slider(
	style="width:{ opts.width }px"
	onclick="{ mouseClick }"
)
	div.load
	div.pic(
		data-mode="{ opts.mode }"
		onmousedown="{ mouseDown }"
	)

	style(scoped).
		:scope {
			position: relative;
			display: block;
			height: 3px;
			background-color: #4c4c4c;
			cursor: pointer;
		}
		:scope .pic {
			position: absolute;
			height: 15px;
			cursor: pointer;
		}
		:scope .pic:hover {
			transform: scale(1.5);
		}
		:scope .mode-seek {
			width: 6px;
			top: -5.5px;
			border-radius: 2px;
			background-color: #6F8DCF;
		}
		:scope .mode-volume {
			width: 15px;
			top: -6.5px;
			border-radius: 50%;
			background-color: #ccc;
		}
		:scope .load {
			position: absolute;
			top: 0;
			height: 3px;
			background-color: #6F8DCF;
		}

	script(type="coffee").
		down  = false

		##
		# 移動
		# @param per : 割合
		##
		@move = (per) ->
			@root.children[0].style.width = per * 100 + '%'
			@root.children[1].style.left  = @width * per + 'px'

			# seek
			if opts.mode is 'seek'
				observer.trigger 'seek', per

			# volume
			else
				observer.trigger 'volume', per

		# mount ----------------------------------------------
		@on 'mount', ->

			# seek
			if opts.mode is 'seek'
				@root.children[1].className += ' mode-seek'
				@width = parseInt(opts.width) - 6

			# volume
			else
				@root.children[1].className += ' mode-volume'
				@width = parseInt(opts.width) - 15

			@move parseInt opts.per

		# mouse click ----------------------------------------
		@mouseClick = (e) ->
			left = @root.getBoundingClientRect().left
			x    = parseInt(e.clientX - left)
			per  = x / parseInt(opts.width)

			# 移動
			@move per

		# mouse down -----------------------------------------
		@mouseDown = (e) ->
			down = true

		# mouse move -----------------------------------------
		window.addEventListener 'mousemove', (e) =>
			if not down
				return

			left = @root.getBoundingClientRect().left
			x    = parseInt(e.clientX - left)
			per  = x / @width

			if per > 1
				per = 1
			else if per < 0
				per = 0

			# 移動
			@move per

		# mouse up -------------------------------------------
		window.addEventListener 'mouseup', (e) =>
			down = false
