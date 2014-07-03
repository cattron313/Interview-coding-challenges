function minesweeper(width, height, mines) {
	var board = createBoard(width, height);

	addMinesToBoard(width, height, board, mines);

	fitGameNumbers(board);

	printBoard(board);
}

function createBoard(width, height) {
	var array = [];
	for (var i = 0; i < height; i++) {
		array.push([]);
	}
	return array;
}

function addMinesToBoard(width, height, board, mines) {
	for (var i = 0; i < mines; i++) {
		var x = getRandomInt(width), y = getRandomInt(height);
		board[x][y] = "*";
	}
}

function getRandomInt(max) {
	return Math.floor(Math.random() * max);
}

function fitGameNumbers(board) {
	for (var x = 0; x < board.length; x++) {
		for (var y = 0; y < board[0].length; y++) {
			if (board[x][y] !== "*") {
				calculateNumber(board, x, y);
			}
		}
	}
}

function calculateNumber(board, x, y) {
	if (x - 1 <  
}