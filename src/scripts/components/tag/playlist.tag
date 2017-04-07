playlist
	div.music-li(each="{ music_list }")
		div.check(
			data-num="{ num }"
			onclick="{ selectMusic }"
		)
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
		:scope .music-li .check[data-state="true"] {
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
			@setPlayList()

		# change music -----------------------------------
		observer.on 'change-music', =>
			@setPlayList()

		# select music -----------------------------------
		@selectMusic = (e) ->
			num = parseInt e.target.getAttribute 'data-num'

			music.select num

		##
		# プレイリストを設置
		##
		@setPlayList = ->
			num  = parseInt localStorage['current']
			list = JSON.parse localStorage['playlist']
			@music_list = list

			# 更新
			@update()

			# 選択中の曲
			child = @root.children[num].children[0]
			child.setAttribute 'data-state', 'true'
