playlist
	div.music-li(
		each="{ music_list }"
		onclick="{ selectMusic }"
		data-state="{ check }"
	)
		div.check
		div.title { title }

	style(scoped).
		:scope {
			display: block;
			width: 300px;
			height: 88px;
			overflow: auto;
		}
		:scope .music-li {
			position: relative;
			width: 280px;
			height: 20px;
			background-color: #444;
			margin: 5px auto;
		}
		:scope .music-li .check {
			position: absolute;
			top: 2.5px;
			left: 2.5px;
			width: 15px;
			height: 15px;
			background-color: #222;
			border-radius: 3px;
		}
		:scope .music-li[data-state="true"] .check {
			background-image: url(../../images/check.png);
			background-size: 90%;
			background-position: center;
			background-repeat: no-repeat;
		}
		:scope .music-li .title {
			position: absolute;
			top: 2.5px;
			left: 20px;
			width: 260px;
			height: 15px;
			font-size: 10px;
			padding: 0 5px;
			color: #ccc;
			box-sizing: border-box;
			line-height: 15px;
		}

	script(type="coffee").

		# mount ------------------------------------------
		@on 'mount', ->
			@music_list = [
				{ 
					check: true
					title: '鳴海兎亜' 
				}
			]
			@update()