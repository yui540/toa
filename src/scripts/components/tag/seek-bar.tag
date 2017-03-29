seek-bar
	div.current.area { current }
	slider.area(
		width="200"
		mode="seek"
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
		@current  = '0:00'
		@duration = '0:00'


