content
	div.inner(data-state="list-box")
		section.main
			music-title
			seek-bar
			control-box
			volume-box
		section.list-box
			playlist
			back-btn

	style(scoped).
		:scope {
			position: relative;
			left: 0;
			width: 300px;
			height: 128px;
			display: block;
			overflow: hidden;
		}
		:scope .inner {
			position: absolute;
			top: 0;
			left: 0px;
			width: 600px;
			height:  128px;
		}
		:scope .inner[data-state="main"] {
			animation: main 0.4s ease 0s forwards;
		}
		:scope .inner[data-state="list-box"] {
			animation: list_box 0.4s ease 0s forwards;
		}
		:scope .inner:after {
			content: "";
			display: block;
			clear: both;
		}
		:scope .inner .main,
		:scope .inner .list-box {
			float: left;
			width: 300px;
			height: 128px;
		} 

		@keyframes main {
			0%   { left: -300px; }
			100% { left: 0px; }
		}
		@keyframes list_box {
			0%   { left: 0px; }
			100% { left: -300px; }
		}

	script(type="coffee").

		# move main --------------------------------------------------
		observer.on 'move-main', =>
			@root.children[0].setAttribute 'data-state', 'main'

		# open list --------------------------------------------------
		observer.on 'open-list', =>
			@root.children[0].setAttribute 'data-state', 'list-box'
