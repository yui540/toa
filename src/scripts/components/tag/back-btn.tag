back-btn
	div.btn(onclick="{ back }")

	style(scoped).
		:scope {
			display: block;
			width: 300px;
			height: 35px;
			padding: 3.5px 0;
			box-sizing: border-box;
		}
		:scope .btn {
			width: 28px;
			height: 28px;
			border-radius: 50%;
			background-color: #6F8DCF;
			background-image: url(../../images/back_log.png);
			background-position: center;
			background-repeat: no-repeat;
			background-size: auto 60%;
			margin: 0 auto;
			cursor: pointer;
		}

	script(type="coffee").
		@back = ->
			observer.trigger 'move-main'