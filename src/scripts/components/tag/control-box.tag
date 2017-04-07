control-box
	div.open(onclick="{ openDir }")
	div.control
		section.back(onclick="{ musicBack }")
		section.pause(onclick="{ musicPlay }")
		section.forward(onclick="{ musicForward }")
	div.list(onclick="{ openList }")

	style(scoped).
		:scope {
			position: relative;
			display: block;
			width: 280px;
			height: 30px;
			margin: 0 auto;
		}
		:scope .control {
			position: absolute;
			left: 35px;
			width: 210px;
			height: 30px;
		}
		:scope .control:after {
			content: "";
			display: block;
			clear: both;
		}
		:scope .back,
		:scope .play,
		:scope .pause,
		:scope .forward {
			float: left;
			width: 70px;
			height: 30px;
			background-repeat: no-repeat;
			background-position: center;
			transition: all 0.3s ease 0s;
			cursor: pointer;
		}
		:scope .back:hover,
		:scope .play:hover,
		:scope .pause:hover,
		:scope .forward:hover,
		:scope .open:hover,
		:scope .list:hover {
			transform: scale(1.15);
		}
		:scope .back { 
			background-image: url(../../images/back.png); 
			background-size: auto 90%;
		}
		:scope .pause { 
			background-image: url(../../images/play.png);
			background-size: auto 60%; 
		}
		:scope .play { 
			background-image: url(../../images/pause.png); 
			background-size: auto 60%;
		}
		:scope .forward { 
			background-image: url(../../images/forward.png); 
			background-size: auto 90%;
		}
		:scope .list,
		:scope .open {
			position: absolute;
			width: 30px;
			height: 30px;
			background-size: 70%;
			background-position: center;
			background-repeat: no-repeat;
			transition: all 0.3s ease 0s;
			cursor: pointer;
		}
		:scope .open {
			background-image: url(../../images/open.png);
			left: 0;
		}
		:scope .list {
			background-image: url(../../images/list.png);
			right: 0;
		}

	script(type="coffee").

		# back ----------------------------------------------
		@musicBack = (e) ->
			observer.trigger 'back-music'

		# click play ----------------------------------------
		@musicPlay = (e) ->
			state = e.target.className

			# pause
			if state is 'play'
				observer.trigger 'pause'
				e.target.className = 'pause'

			# play
			else
				list = JSON.parse localStorage['playlist']
				if not list.length
					return 
				
				observer.trigger 'play'
				e.target.className = 'play'

		# play ----------------------------------------------
		observer.on 'play', =>
			btn = @root.children[1].children[1]
			btn.className = 'play'

		# pause ---------------------------------------------
		observer.on 'pause', =>
			btn = @root.children[1].children[1]
			btn.className = 'pause'

		# forward -------------------------------------------
		@musicForward = (e) ->
			observer.trigger 'forward-music'

		# open dir ------------------------------------------
		@openDir = (e) ->
			observer.trigger 'open-dir'

		# open list -----------------------------------------
		@openList = (e) ->
			observer.trigger 'open-list'

