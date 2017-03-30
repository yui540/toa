volume-box
	div.volume-min
	slider(
		width="200"
		mode="volume"
		per="1"
	)
	div.volume-max

	style(scoped).
		:scope {
			display: block;
			width: 280px;
			height: 30px;
			margin: 0 auto;
		}
		:scope .volume-min {
			float: left;
			width: 30px;
			height: 30px;
			background-image: url(../../images/volume_min.png);
			background-size: 60%;
			background-position: center;
			background-repeat: no-repeat;
		}
		:scope slider {
			float: left;
			margin-top: 13.5px;
			margin-left: 10px;
		}
		:scope .volume-max {
			float: left;
			width: 30px;
			height: 30px;
			margin-left: 10px;
			background-image: url(../../images/volume_max.png);
			background-size: 60%;
			background-position: center;
			background-repeat: no-repeat;
		}

	script(type="coffee").