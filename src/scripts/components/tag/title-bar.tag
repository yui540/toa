title-bar
	div.close(onclick="{ onClick }")

	style(scoped).
		:scope {
			display: block;
			width: 100%;
			height: 22px;
			-webkit-user-select: none;
			-webkit-app-region: drag;
		}
		:scope .close {
			position: relative;
			top: 5px;
			left: 5px;
			width: 12px;
			height: 12px;
			border-radius: 50%;
			-webkit-app-region: no-drag;
		}
		:scope .close:before,
		:scope .close:after {
			top: 5.5px;
			position: absolute;
			content: "";
			display: block;
			width: 12px;
			height: 1px;
			background-color: #ccc;
		}
		:scope .close:before {
			transform: rotate(45deg);
		}
		:scope .close:after {
			transform: rotate(-45deg);
		}

	script(type="coffee").
		@onClick = ->
			ipc.send 'close'