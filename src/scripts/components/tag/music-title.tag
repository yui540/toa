music-title
	section.img(
		data-state="repeat"
		onclick="{ onRepeat }"
	)
	h1.title { title }
	div
		section.line.line-1
		section.line.line-2
		section.line.line-3

	style(scoped).
		:scope {
			display: block;
			width: 280px;
			height: 30px;
			margin: 0 auto;
		}
		:scope .img {
			float: left;
			display: block;
			width: 30px;
			height: 30px;
			background-size: 80%;
			background-position: center;
			background-repeat: no-repeat;
			cursor: pointer;
			transition: all 0.3s ease 0s;
		}
		:scope .img:hover {
			transform: scale(1.1);
		}
		:scope .img[data-state="repeat"] {
			background-image: url(../../images/repeat.png);
		}
		:scope .img[data-state="repeat-one"] {
			background-image: url(../../images/repeat_one.png);
		}
		:scope .title {
			float: left;
			width: 200px;
			height: 30px;
			font-size: 12px;
			color: #ccc;
			text-align: center;
			line-height: 30px;
			overflow: hidden;
			border-radius: 3px;
			background-color: #333;
			margin-left: 10px;
		}
		:scope div {
			position: relative;
			float: right;
			width: 30px;
			height: 30px;
		}
		:scope div .line {
			position: absolute;
			bottom: 0;
			width: 6px;
			background-color: #6F8DCF;
		}
		:scope div .line-1 { 
			height: 10px;
			left: 0; 
		}
		:scope div .line-2 { 
			height: 20px;
			left: 12px; 
		}
		:scope div .line-3 { 
			height: 30px;
			right: 0; 
		}
		:scope .art .line-1 {
			animation: line 1s ease 0s infinite;
		}
		:scope .art .line-2 {
			animation: line 1.5s ease 0s infinite;
		}
		:scope .art .line-3 {
			animation: line 2s ease 0s infinite;
		}
		@keyframes line {
			0%   { height: 10px; }
			50%  { height: 30px; }
			100% { height: 10px; }
		}

	script(type="coffee").
		@on 'mount', ->
			num  = parseInt localStorage['current']
			list = JSON.parse localStorage['playlist']

			if not list.length
				@title = 'no_music'
			else
				@title = list[num].title

			@update()

		# repeat ---------------------------------------------------
		@onRepeat = (e) ->
			state = e.target.getAttribute 'data-state'

			# repeat one
			if state is 'repeat'
				observer.trigger 'repeat-one'
				e.target.setAttribute 'data-state', 'repeat-one'

			# repeat
			else
				observer.trigger 'repeat'
				e.target.setAttribute 'data-state', 'repeat'

		# play -----------------------------------------------------
		observer.on 'play', =>
			@root.children[2].className = 'art'

		# pause ----------------------------------------------------
		observer.on 'pause', =>
			@root.children[2].className = ''

