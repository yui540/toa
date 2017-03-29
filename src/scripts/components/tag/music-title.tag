music-title
	section.img
	h1.title 茅野愛衣
	div.art
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
			background-image: url(../../images/music.png);
			background-size: 60%;
			background-position: center;
			background-repeat: no-repeat;
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
			height: 30px;
			background-color: #6F8DCF;
		}
		:scope div .line-1 { left: 0; }
		:scope div .line-2 { left: 12px; }
		:scope div .line-3 { right: 0; }
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
		@title = opts.title