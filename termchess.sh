#!/bin/bash
# TermChess v1.1
#Coded by @linux_choice
# https://github.com/thelinuxchoice/termchess
trap 'printf "\n";pgn;exit 1' 2

banner() {

printf "\e[1;93m  _____                    ____ _                    \n"
printf " |_   _|__ _ __ _ __ ___  / ___| |__   ___  ___ ___  \n"
printf "   | |/ _ \ '__| '_ \` _ \| |   | '_ \ / _ \/ __/ __| \n"
printf "   | |  __/ |  | | | | | | |___| | | |  __/\__ \__ \ \n"
printf "   |_|\___|_|  |_| |_| |_|\____|_| |_|\___||___/___/ \e[0m\e[1;77mv1.1\n"
printf "\n"

printf "   \e[1;77mcoded by: github.com/thelinuxchoice\e[0m\n"                                                  
printf "\n"



}

countp=0
countP=0
countb=0
countB=0
countn=0
countN=0
countq=0
countQ=0
countr=0
countR=0


dependencies() {


command -v curl > /dev/null 2>&1 || { echo >&2 "I require curl but it's not installed. Run ./install.sh. Aborting."; exit 1; }


command -v node > /dev/null 2>&1 || { echo >&2 "I require node but it's not installed. Aborting."; exit 1; }
command -v sed > /dev/null 2>&1 || { echo >&2 "I require sed but it's not installed. Aborting."; exit 1; }
command -v cat > /dev/null 2>&1 || { echo >&2 "I require cat but it's not installed. Aborting."; exit 1; }
command -v tr > /dev/null 2>&1 || { echo >&2 "I require tr but it's not installed. Aborting."; exit 1; }
command -v cut > /dev/null 2>&1 || { echo >&2 "I require cut but it's not installed. Aborting."; exit 1; }

}



table() {
#start=true

if [[ $first_move == true ]]; then
node start.js | head -n10 > table
else
node history_pgn | head -n10 > table
fi
first_move=false
#K=$(echo -e '\e[30m\e[107m\u2654\e[0m\e[0m') # King White
#k=$(echo -e '\e[97m\e[40m\u2654\e[0m\e[0m')  # King Black

# captured

if [[ -e last_table ]]; then


count_tp=$(grep -o 'p' table | wc -l)
count_tP=$(grep -o 'P' table | wc -l)

count_tq=$(grep -o 'q' table | wc -l)
count_tQ=$(grep -o 'Q' table | wc -l)

count_tr=$(grep -o 'r' table | wc -l)
count_tR=$(grep -o 'R' table | wc -l)

count_tn=$(grep -o 'n' table | wc -l)
count_tN=$(grep -o 'N' table | wc -l)

count_tb=$(grep -o 'b' table | wc -l)
count_tB=$(grep -o 'B' table | wc -l)


count_p=$(grep -o 'p' last_table | wc -l)
count_P=$(grep -o 'P' last_table | wc -l)

count_q=$(grep -o 'q' last_table | wc -l)
count_Q=$(grep -o 'Q' last_table | wc -l)

count_r=$(grep -o 'r' last_table | wc -l)
count_R=$(grep -o 'R' last_table | wc -l)

count_n=$(grep -o 'n' last_table | wc -l)
count_N=$(grep -o 'N' last_table | wc -l)

count_b=$(grep -o 'b' last_table | wc -l)
count_B=$(grep -o 'B' last_table | wc -l)

#Pawn Black
if [[ $count_tp < $count_p ]]; then
let countp+=1
fi
# Pawn W
if [[ $count_tP < $count_P ]]; then
let countP+=1
fi
# Bishop
if [[ $count_tb < $count_b ]]; then
let countb+=1
fi

if [[ $count_tB < $count_B ]]; then
let countB+=1
fi


# N

if [[ $count_tn < $count_n ]]; then
let countn+=1
fi

if [[ $count_tN < $count_N ]]; then
let countN+=1
fi


# Q

if [[ $count_tq < $count_q ]]; then
let countq+=1
fi

if [[ $count_tQ < $count_Q ]]; then
let countQ+=1
fi

# R

if [[ $count_tr < $count_r ]]; then
let countr+=1
fi

if [[ $count_tR < $count_R ]]; then
let countR+=1
fi

fi

K=$(echo -e '\u2654') # King White
k=$(echo -e '\u265A')  # King Black

Q=$(echo -e '\u2655')
q=$(echo -e '\u265B')

R=$(echo -e '\u2656')
r=$(echo -e '\u265C')

B=$(echo -e '\u2657')
b=$(echo -e '\u265D')

N=$(echo -e '\u2658')
n=$(echo -e '\u265E')

P=$(echo -e '\u2659')
p=$(echo -e '\u265F')

# Black Captures

#P
if [[ $countP > 0 ]]; then #black captures white pawn
Pawn=$(printf "\u2659x%s\n" $countP)
#printf "%s \n" $Pawn
fi
#B
if [[ $countB > 0 ]]; then #white captures white bishop
Bishop=$(printf "\u2657x%s\n" $countB)
#printf "%s \n" $bishop
fi

#N Knight
if [[ $countN > 0 ]]; then 
Nnight=$(printf "\u2658x%s\n" $countN)

fi

#Q
if [[ $countQ > 0 ]]; then 
Queen=$(printf "\u2655x%s\n" $countQ)

fi

#R

if [[ $countR > 0 ]]; then 
Rook=$(printf "\u2656x%s\n" $countR)

fi


printf "    %s %s %s %s %s\n" $Queen $Rook $Nnight $Bishop $Pawn


# Table
sed 's+K+'$K'+g' table | sed 's+k+'$k'+g' | sed 's+Q+'$Q'+g' | sed 's+q+'$q'+g' | sed 's+R+'$R'+g' | sed 's+r+'$r'+g' | sed 's+B+'$B'+g' | sed 's+b+'$b'+g' | sed 's+N+'$N'+g' | sed 's+n+'$n'+g' | sed 's+P+'$P'+g' | sed 's+p+'$p'+g'
echo '     a  b  c  d  e  f  g  h '
printf "\n"


# White Captures


if [[ $countp > 0 ]]; then #white captures black pawn
pawn=$(printf "\u265Fx%s\n" $countp)

fi

#b
if [[ $countb > 0 ]]; then #white captures black pawn
bishop=$(printf "\u265Dx%s\n" $countb)

fi

#n knight
if [[ $countn > 0 ]]; then 
nnight=$(printf "\u265Ex%s\n" $countn)

fi

#q
if [[ $countq > 0 ]]; then 
queen=$(printf "\u265Bx%s\n" $countq)

fi

#r

if [[ $countr > 0 ]]; then 
rook=$(printf "\u265Cx%s\n" $countr)

fi


printf "    %s %s %s %s %s\n" $queen $rook $nnight $bishop $pawn

cat table > last_table
}

pgn() {

if [[ -e move_history ]]; then
echo "var Chess = require('./chessjs/chess').Chess;" > pgn_match
echo "var chess = new Chess();" >> pgn_match
for position in $(cat move_history); do
printf "chess.move('%s', {sloppy: true});\n" $position >> pgn_match
done
echo "console.log(chess.pgn());" >> pgn_match
node pgn_match > pgn.pgn
printf "\e[1;77mSaved: pgn.pgn\e[0m\n"
fi

if [[ -e history_pgn ]]; then
rm -rf history_pgn
fi

if [[ -e move_history ]]; then
rm -rf move_history
fi

if [[ -e checkposition.js  ]]; then
rm -rf checkposition.js
fi

if [[ -e gen_fen ]]; then
rm -rf gen_fen
fi

if [[ -e last_fen ]]; then
rm -rf last_fen
fi

if [[ -e pgn_match ]]; then
rm -rf pgn_match
fi

if [[ -e repetition ]]; then
rm -rf repetition
fi

if [[ -e result_check ]]; then
rm -rf result_check
fi

if [[ -e table ]]; then
rm -rf table
fi

if [[ -e last_table ]]; then
rm -rf last_table
fi

if [[ -e next_move ]]; then
rm -rf next_move
fi

}

check_threefold() {

echo "var Chess = require('./chessjs/chess').Chess;" > repetition
echo "var chess = new Chess();" >> repetition

for position in $(cat move_history); do
printf "chess.move('%s', {sloppy: true});\n" $position >> repetition
done
echo "console.log(chess.in_threefold_repetition());" >> repetition

if [[ $(node repetition) == *'true'* ]]; then
printf "\e[1;93mRepetition, Draw!\e[0m\n"
printf "\e[1;77mSaved: pgn.pgn\e[0m\n"
exit 1
fi


}

check_position() {

check_threefold
IFS=$'\n'
last_fen=$(cat last_fen)

echo "var Chess = require('./chessjs/chess').Chess;" > checkposition.js
echo "var chess = new Chess();" >> checkposition.js
IFS=$'\n'
printf "chess.load('%s');\n" $last_fen >> checkposition.js
echo "console.log(chess.in_check());" >> checkposition.js
echo "console.log(chess.in_stalemate());" >> checkposition.js
echo "console.log(chess.in_draw());" >> checkposition.js
echo "console.log(chess.insufficient_material());" >> checkposition.js
echo "console.log(chess.in_checkmate());" >> checkposition.js
node checkposition.js > result_check
in_check=$(sed -n 1p result_check)
in_stalemate=$(sed -n 2p result_check)
in_draw=$(sed -n 3p result_check)
insufficient=$(sed -n 4p result_check)
checkmate=$(sed -n 5p result_check)

if [[ $checkmate == *'true'* ]]; then
printf "\e[1;93mCheckMate!\e[0m\n"
echo -e '\a'; sleep 0.1 ; echo -e '\a'
pgn
exit 1
fi

if [[ $in_check == *'true'* ]]; then
printf "\e[1;93mCheck!\e[0m\n"
echo -e '\a'
fi

if [[ $in_stalemate == *'true'* ]]; then
printf "\e[1;93mStalemate!\e[0m\n"
pgn
exit 1
fi

if [[ $in_draw == *'true'* ]]; then
printf "\e[1;93mDraw!\e[0m\n"
pgn
exit 1
fi

if [[ $insufficient == *'true'* ]]; then
printf "\e[1;93mInsufficient Material!\e[0m\n"
pgn
exit 1
fi


}

white() {

if [[ $white == false ]]; then

printf "%s \e[1;77mYou Turn: \e[0m" $turn
read move
IFS=$'\n'
fen=$(echo $(cat last_fen | cut -d ' ' -f1-3)" - 0 1")
#curl -i -s -k  -X $'POST'     -H $'Host: nextchessmove.com' -H $'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0' -H $'Accept: */*' -H $'Accept-Language: en-US,en;q=0.5' -H $'Accept-Encoding: gzip, deflate' -H $'Content-Type: application/x-www-form-urlencoded; charset=UTF-8'  --data-binary "engine=sf10&fen=$fen&position%5Bfen%5D=$fen&movetime=5&syzygy=false&uuid="     $'https://nextchessmove.com/api/v4/calculate' > next_move
echo $move >> move_history


else
IFS=$'\n'
fen=$(echo $(cat last_fen | cut -d ' ' -f1-3)" - 0 1")
curl -i -s -k  -X $'POST'     -H $'Host: nextchessmove.com' -H $'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0' -H $'Accept: */*' -H $'Accept-Language: en-US,en;q=0.5' -H $'Accept-Encoding: gzip, deflate' -H $'Content-Type: application/x-www-form-urlencoded; charset=UTF-8'  --data-binary "engine=sf10&fen=$fen&position%5Bfen%5D=$fen&movetime=5&syzygy=false&uuid="     $'https://nextchessmove.com/api/v4/calculate' > next_move


move=$(grep -o '"move":"[a-zA-Z0-9]\{5\}' next_move | cut -d ':' -f2 | tr -d '"')
if [[ $move == "" ]]; then
move=$(grep -o '"move":"[a-zA-Z0-9]\{4\}' next_move | cut -d ':' -f2 | tr -d '"')
fi

echo $move >> move_history
fi


printf "\e[1;77mLast move: \e[0m\e[1;93m%s\e[0m\n" $move

echo "var Chess = require('./chessjs/chess').Chess;" > history_pgn
echo "var chess = new Chess();" >> history_pgn

for position in $(cat move_history); do
printf "chess.move('%s', {sloppy: true});\n" $position >> history_pgn
done
echo "console.log(chess.ascii());" >> history_pgn
echo "console.log(chess.fen());" >> history_pgn

table

echo "var Chess = require('./chessjs/chess').Chess;" > gen_fen
echo "var chess = new Chess();" >> gen_fen

for position in $(cat move_history); do
printf "chess.move('%s', {sloppy: true});\n" $position >> gen_fen
done
echo "console.log(chess.fen());" >> gen_fen
node gen_fen > last_fen

check_position


}

black() {

if [[ $white == true ]]; then

printf "%s \e[1;77mYou Turn: \e[0m" $turn
read move
IFS=$'\n'
fen=$(echo $(cat last_fen | cut -d ' ' -f1-3)" - 0 1")
#curl -i -s -k  -X $'POST'     -H $'Host: nextchessmove.com' -H $'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0' -H $'Accept: */*' -H $'Accept-Language: en-US,en;q=0.5' -H $'Accept-Encoding: gzip, deflate' -H $'Content-Type: application/x-www-form-urlencoded; charset=UTF-8'  --data-binary "engine=sf10&fen=$fen&position%5Bfen%5D=$fen&movetime=5&syzygy=false&uuid="     $'https://nextchessmove.com/api/v4/calculate' > next_move
echo $move >> move_history


else


fen=$(echo $(cat last_fen | cut -d ' ' -f1-3)" - 0 1")
curl -i -s -k  -X $'POST'     -H $'Host: nextchessmove.com' -H $'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0' -H $'Accept: */*' -H $'Accept-Language: en-US,en;q=0.5' -H $'Accept-Encoding: gzip, deflate' -H $'Content-Type: application/x-www-form-urlencoded; charset=UTF-8'  --data-binary "engine=sf10&fen=$fen&position%5Bfen%5D=$fen&movetime=5&syzygy=false&uuid="     $'https://nextchessmove.com/api/v4/calculate' > next_move

move=$(grep -o '"move":"[a-zA-Z0-9]\{5\}' next_move | cut -d ':' -f2 | tr -d '"')
if [[ $move == "" ]]; then
move=$(grep -o '"move":"[a-zA-Z0-9]\{4\}' next_move | cut -d ':' -f2 | tr -d '"')
fi
printf "\e[1;77mLast move: \e[0m\e[1;93m%s\e[0m\n" $move
echo $move >> move_history

fi 

echo "var Chess = require('./chessjs/chess').Chess;" > history_pgn
echo "var chess = new Chess();" >> history_pgn

for position in $(cat move_history); do
printf "chess.move('%s', {sloppy: true});\n" $position >> history_pgn
done
echo "console.log(chess.ascii());" >> history_pgn
echo "console.log(chess.fen());" >> history_pgn

table

echo "var Chess = require('./chessjs/chess').Chess;" > gen_fen
echo "var chess = new Chess();" >> gen_fen

for position in $(cat move_history); do
printf "chess.move('%s', {sloppy: true});\n" $position >> gen_fen
done
echo "console.log(chess.fen());" >> gen_fen
node gen_fen > last_fen

check_position

}

start() {

touch last_fen
rm -rf move_history
printf "\n"
printf "\e[1;93m1.\e[0m\e[1;77m White\e[0m \u2654\n"
printf "\e[1;93m2.\e[0m\e[1;77m Black\e[0m \u265A\n"
printf "\e[1;93m3.\e[0m\e[1;77m Random\e[0m \u2654 \u265A\n"
printf "\e[1;93m4.\e[0m\e[1;77m AI x AI (StockFish)\e[0m\n"
printf "\e[1;93m5. Help\e[0m\n"
printf "\e[1;93m6.\e[0m\e[1;77m Exit\e[0m\n"

printf "\n\e[1;77mChoose: \e[0m"
read color

# WHITE 
if [[ $color -eq 1 ]]; then
first_move=true

table
white=true

while [ true ]; do
gturn=$(cat last_fen | cut -d ' ' -f2)
if [[ $gturn == *'b'* ]]; then
turn=$(echo -e '\u265A')
else
turn=$(echo -e '\u2654')
fi
black
white
done

# BLACK

elif [[ $color -eq 2 ]]; then
printf "\n\u2654 \e[1;93mWhite begins, please wait...\e[0m\n"
white=true

echo "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1" > last_fen

while [ true ]; do

gturn=$(cat last_fen | cut -d ' ' -f2)

if [[ $gturn == *'w'* ]]; then
turn=$(echo -e '\u265A')
else
turn=$(echo -e '\u2654')
fi
white
black
done


elif [[ $color -eq 3 ]]; then

choice=$((RANDOM%2))

if [[ $choice -eq 0 ]]; then
white=true
first_move=true
table
first=black
second=white

else
white=true

first=white
second=black
echo "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1" > last_fen
fi


while [ true ]; do

gturn=$(cat last_fen | cut -d ' ' -f2)

if [[ $gturn == *'b'* ]]; then
turn=$(echo -e '\u265A')
else
turn=$(echo -e '\u2654')
fi

$first
if [[ $gturn == *'w'* ]]; then
turn=$(echo -e '\u265A')
else
turn=$(echo -e '\u2654')
fi
$second
done


elif [[ $color -eq 4 ]]; then

echo "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1" > last_fen

while [ true ]; do

white
black
done

elif [[ $color -eq 5 ]]; then

printf "\n\n\e[1;93mMoves:\n\n\e[0m"

printf "\e[1;93m1. You can use Algebraic Notation (AN) or Standard Algebraic Notation (SAN)\e[0m\n"

printf "\e[1;77ma. Algebric Notation (AN), e.g: from g1 to f3: g1f3\e[0m\n"
printf "\e[1;77mb. Standard Algebric Notation (SAN), e.g: Nf3\e[0m\n"
printf "\e[1;93m2. Pawn Promotion:\e[0m\n"
printf "\e[1;77ma. a7a8q or b8Q (promoting to Queen)\e[0m\n"
printf "\e[1;93m3. Performing AI move in your turn:\e[0m\n"
printf "\e[1;77ma. Leave in Blank or Invalid move (your pieces will change)\e[0m\n"

printf "\n\n\e[1;93mInfo:\n\e[0m"

printf "\e[1;77mStockEngine 10 (5 secs) through nextchessmove.com\e[0m\n"
printf "\e[1;77mchess.js: github.com/jhlywa/chess.js/\e[0m\n"
printf "\n\e[1;77mBack (Hit Enter)"
read back
start

elif [[ $color -eq 6 ]]; then
exit 1
fi

}
banner
dependencies
start
