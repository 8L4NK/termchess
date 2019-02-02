var Chess = require('./chessjs/chess').Chess;
var chess = new Chess();

//chess.move('e4');
//chess.move('d6');
//chess.move('d4');
//chess.move('e5');
//chess.move('b1c3', {sloppy: true});
//e2e4 d6 d4 e7e5 b1c3
//chess.ascii();
console.log(chess.ascii());
console.log(chess.fen());

