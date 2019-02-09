#!/bin/bash
# TermChess v1.4
# Coded by @linux_choice
# https://github.com/thelinuxchoice/termchess
trap 'printf "\n";pgn;exit 1' 2

banner() {

printf "\e[1;93m  _____                    ____ _                    \n"
printf " |_   _|__ _ __ _ __ ___  / ___| |__   ___  ___ ___  \n"
printf "   | |/ _ \ '__| '_ \` _ \| |   | '_ \ / _ \/ __/ __| \n"
printf "   | |  __/ |  | | | | | | |___| | | |  __/\__ \__ \ \n"
printf "   |_|\___|_|  |_| |_| |_|\____|_| |_|\___||___/___/ \e[0m\n"
printf "\n"

printf "    \e[1;77mv1.4 by: github.com/thelinuxchoice/termchess\e[0m\n"
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

if [[ $first_move == true ]]; then
node start.js | head -n10 > table
else
head -n10 history.txt > table
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
fi
#B
if [[ $countB > 0 ]]; then #white captures white bishop
Bishop=$(printf "\u2657x%s\n" $countB)
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

if [[ ${#move} > 3 ]]; then
from_char1=$(echo ${move:0:1})
from_char2=$(echo ${move:1:1})
to_char1=$(echo ${move:2:1})
to_char2=$(echo ${move:3:3})
to_char2_middle="char_mid"
from_string1=$(printf "\e[33m%s\e[0m" $from_char1)
from_string2=$(printf "\e[33m%s\e[0m" $from_char2)

to_string1=$(printf "\e[1;93m%s\e[0m" $to_char1)
to_string2=$(printf "\e[1;93m%s\e[0m" $to_char2)



board_letter="     a  b  c  d  e  f  g  h "
sed 's+K+'$K'+g' table | sed 's+k+'$k'+g' | sed 's+Q+'$Q'+g' | sed 's+q+'$q'+g' | sed 's+R+'$R'+g' | sed 's+r+'$r'+g' | sed 's+B+'$B'+g' | sed 's+b+'$b'+g' | sed 's+N+'$N'+g' | sed 's+n+'$n'+g' | sed 's+P+'$P'+g' | sed 's+p+'$p'+g' | sed 's+'$to_char2'+'$to_char2_middle'+g' | sed 's+'$from_char2'+'$from_string2'+g' | sed 's+char_mid+'$to_string2'+g' 
#echo '     a  b  c  d  e  f  g  h '
IFS=$'\n'
board_char=$(echo "$board_letter" | sed 's+'$to_char1'+'$to_string1'+g' | sed 's+'$from_char1'+'$from_string1'+g')
echo $board_char
printf "\n"
else
# Table
sed 's+K+'$K'+g' table | sed 's+k+'$k'+g' | sed 's+Q+'$Q'+g' | sed 's+q+'$q'+g' | sed 's+R+'$R'+g' | sed 's+r+'$r'+g' | sed 's+B+'$B'+g' | sed 's+b+'$b'+g' | sed 's+N+'$N'+g' | sed 's+n+'$n'+g' | sed 's+P+'$P'+g' | sed 's+p+'$p'+g' 
echo '     a  b  c  d  e  f  g  h '
printf "\n"
fi

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

printf "\e[1;93mGenerating PGN...\e[0m\n"
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

if [[ -e history.txt ]]; then
rm -rf history.txt
fi


if [[ -e history_pgn ]]; then
rm -rf history_pgn
fi

if [[ -e move_history ]]; then
rm -rf move_history
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


check_position() {

IFS=$'\n'

in_check=$(sed -n 14p history.txt)
in_stalemate=$(sed -n 16p history.txt)
#in_draw=$(sed -n 3p history.txt)
insufficient=$(sed -n 17p history.txt)
checkmate=$(sed -n 15p history.txt)
repetition=$(sed -n 18p history.txt)

if [[ $checkmate == *'true'* ]]; then
printf "\n\e[1;93mCheckMate!\e[0m "
winner=$(cut -d ' ' -f2 last_fen)
if [[ $winner == *'w'* ]]; then
printf "\e[1;77mBlack Wins!\e[0m\n"
else
printf "\e[1;77mWhite Wins!\e[0m\n"
fi
echo -e '\a'; sleep 0.1 ; echo -e '\a'


pgn
exit 1
fi

if [[ $in_check == *'true'* ]]; then
printf "\n\e[1;93mCheck!\e[0m\n"
echo -e '\a'
fi

if [[ $in_stalemate == *'true'* ]]; then
printf "\n\e[1;93mStalemate!\e[0m\n"
pgn
exit 1
fi

#if [[ $in_draw == *'true'* ]]; then
#printf "\n\e[1;93mDraw!\e[0m\n"
#pgn
#exit 1
#fi

if [[ $insufficient == *'true'* ]]; then
printf "\n\e[1;93mInsufficient Material!\e[0m\n"
pgn
exit 1
fi

if [[ $repetition == *'true'* ]]; then
printf "\n\e[1;93mRepetition, Draw!\e[0m\n"
pgn
exit 1
fi

}

white() {

if [[ $white == false ]]; then

printf "%s \e[1;77mYou Turn: \e[0m" $turn
read move
IFS=$'\n'

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

if [[ $(cut -d ' ' -f2 last_fen) == *'w'* ]]; then
last_turn="White"
else
last_turn="Black"
fi
printf "\n\e[1;77mLast move: \e[0m\e[1;93m%s\e[0m \e[1;77m(%s\e[0m)\n\n" $move $last_turn

echo "var Chess = require('./chessjs/chess').Chess;" > history_pgn
echo "var chess = new Chess();" >> history_pgn

for position in $(cat move_history); do
printf "chess.move('%s', {sloppy: true});\n" $position >> history_pgn
done
echo "console.log(chess.ascii());" >> history_pgn
echo "console.log(chess.fen());" >> history_pgn

##
echo "console.log(chess.in_check());" >> history_pgn
echo "console.log(chess.in_checkmate());" >> history_pgn
echo "console.log(chess.in_stalemate());" >> history_pgn
echo "console.log(chess.insufficient_material());" >> history_pgn
echo "console.log(chess.in_threefold_repetition());" >> history_pgn
#echo "console.log(chess.in_draw());" >> history_pgn



##
node history_pgn > history.txt
table
sed -n 13p history.txt > last_fen
check_position


}

black() {

if [[ $white == true ]]; then

printf "%s \e[1;77mYou Turn: \e[0m" $turn
read move
IFS=$'\n'
echo $move >> move_history


else


fen=$(echo $(cat last_fen | cut -d ' ' -f1-3)" - 0 1")
curl -i -s -k  -X $'POST'     -H $'Host: nextchessmove.com' -H $'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0' -H $'Accept: */*' -H $'Accept-Language: en-US,en;q=0.5' -H $'Accept-Encoding: gzip, deflate' -H $'Content-Type: application/x-www-form-urlencoded; charset=UTF-8'  --data-binary "engine=sf10&fen=$fen&position%5Bfen%5D=$fen&movetime=5&syzygy=false&uuid="     $'https://nextchessmove.com/api/v4/calculate' > next_move

move=$(grep -o '"move":"[a-zA-Z0-9]\{5\}' next_move | cut -d ':' -f2 | tr -d '"')
if [[ $move == "" ]]; then
move=$(grep -o '"move":"[a-zA-Z0-9]\{4\}' next_move | cut -d ':' -f2 | tr -d '"')
fi
if [[ $(cut -d ' ' -f2 last_fen) == *'w'* ]]; then
last_turn="White"
else
last_turn="Black"
fi
printf "\n\e[1;77mLast move: \e[0m\e[1;93m%s\e[0m \e[1;77m(%s\e[0m)\n\n" $move $last_turn

echo $move >> move_history

fi 

echo "var Chess = require('./chessjs/chess').Chess;" > history_pgn
echo "var chess = new Chess();" >> history_pgn

for position in $(cat move_history); do
printf "chess.move('%s', {sloppy: true});\n" $position >> history_pgn
done
echo "console.log(chess.ascii());" >> history_pgn
echo "console.log(chess.fen());" >> history_pgn

##
echo "console.log(chess.in_check());" >> history_pgn
echo "console.log(chess.in_checkmate());" >> history_pgn
echo "console.log(chess.in_stalemate());" >> history_pgn
echo "console.log(chess.insufficient_material());" >> history_pgn
echo "console.log(chess.in_threefold_repetition());" >> history_pgn
#echo "console.log(chess.in_draw());" >> history_pgn

##

node history_pgn > history.txt
table

sed -n 13p history.txt > last_fen
check_position

}

engine_black() {

if [[ $white == true ]]; then

printf "%s \e[1;77mYou Turn: \e[0m" $turn
read move
echo $move >> move_history

else
IFS=$'\n'
fen=$(echo $(cat last_fen ))

sed 's+get_fen+'$fen'+g' alpha.js | sed 's+get_level+'$level'+g' > engine1.js 
move=$(node engine1.js) #>> move_history

if [[ $(cut -d ' ' -f2 last_fen) == *'w'* ]]; then
last_turn="White"
else
last_turn="Black"
fi
printf "\n\e[1;77mLast move: \e[0m\e[1;93m%s\e[0m \e[1;77m(%s\e[0m)\n\n" $move $last_turn

echo $move >> move_history

fi 

echo "var Chess = require('./chessjs/chess').Chess;" > history_pgn
echo "var chess = new Chess();" >> history_pgn

for position in $(cat move_history); do
printf "chess.move('%s', {sloppy: true});\n" $position >> history_pgn
done
echo "console.log(chess.ascii());" >> history_pgn
echo "console.log(chess.fen());" >> history_pgn

##
echo "console.log(chess.in_check());" >> history_pgn
echo "console.log(chess.in_checkmate());" >> history_pgn
echo "console.log(chess.in_stalemate());" >> history_pgn
echo "console.log(chess.insufficient_material());" >> history_pgn
echo "console.log(chess.in_threefold_repetition());" >> history_pgn
#echo "console.log(chess.in_draw());" >> history_pgn



##

node history_pgn > history.txt
table

sed -n 13p history.txt > last_fen
check_position


}


engine_white() {

if [[ $white == false ]]; then

printf "%s \e[1;77mYou Turn: \e[0m" $turn
read move
echo $move >> move_history


else

IFS=$'\n'
fen=$(echo $(cat last_fen ))
sed 's+get_fen+'$fen'+g' alpha.js | sed 's+get_level+'$level'+g' > engine1.js 
move=$(node engine1.js)

if [[ $(cut -d ' ' -f2 last_fen) == *'w'* ]]; then
last_turn="White"
else
last_turn="Black"
fi
printf "\n\e[1;77mLast move: \e[0m\e[1;93m%s\e[0m \e[1;77m(%s\e[0m)\n\n" $move $last_turn

echo $move >> move_history

fi 

echo "var Chess = require('./chessjs/chess').Chess;" > history_pgn
echo "var chess = new Chess();" >> history_pgn

for position in $(cat move_history); do
printf "chess.move('%s', {sloppy: true});\n" $position >> history_pgn
done
echo "console.log(chess.ascii());" >> history_pgn
echo "console.log(chess.fen());" >> history_pgn

##
echo "console.log(chess.in_check());" >> history_pgn
echo "console.log(chess.in_checkmate());" >> history_pgn
echo "console.log(chess.in_stalemate());" >> history_pgn
echo "console.log(chess.insufficient_material());" >> history_pgn
echo "console.log(chess.in_threefold_repetition());" >> history_pgn
#echo "console.log(chess.in_draw());" >> history_pgn

##

node history_pgn > history.txt
table

sed -n 13p history.txt > last_fen
check_position



}

stockfish_white() {

if [[ $white == false ]]; then

printf "%s \e[1;77mYou Turn: \e[0m" $turn
read move
echo $move >> move_history


else

IFS=$'\n'
fen=$(echo $(cat last_fen ))
#depth="20"
#go depth ${depth}
#setoption name Debug Log File value log
move=$((cat <<EOF
setoption name Skill Level value ${white_level}
position fen ${fen}
go 
EOF
sleep 1) | $stockpath | grep 'bestmove' | cut -d ' ' -f2 )

if [[ $(cut -d ' ' -f2 last_fen) == *'w'* ]]; then
last_turn="White"
else
last_turn="Black"
fi
printf "\n\e[1;77mLast move: \e[0m\e[1;93m%s\e[0m \e[1;77m(%s\e[0m)\n\n" $move $last_turn

echo $move >> move_history

fi 

echo "var Chess = require('./chessjs/chess').Chess;" > history_pgn
echo "var chess = new Chess();" >> history_pgn

for position in $(cat move_history); do
printf "chess.move('%s', {sloppy: true});\n" $position >> history_pgn
done
echo "console.log(chess.ascii());" >> history_pgn
echo "console.log(chess.fen());" >> history_pgn

##
echo "console.log(chess.in_check());" >> history_pgn
echo "console.log(chess.in_checkmate());" >> history_pgn
echo "console.log(chess.in_stalemate());" >> history_pgn
echo "console.log(chess.insufficient_material());" >> history_pgn
echo "console.log(chess.in_threefold_repetition());" >> history_pgn
#echo "console.log(chess.in_draw());" >> history_pgn

node history_pgn > history.txt
table
sed -n 13p history.txt > last_fen

check_position

}

stockfish_black() {
if [[ $white == true ]]; then

printf "%s \e[1;77mYou Turn: \e[0m" $turn
read move
echo $move >> move_history

else
IFS=$'\n'
fen=$(echo $(cat last_fen ))
#setoption name Debug Log File value log
move=$((cat <<EOF
setoption name Skill Level value ${black_level}
position fen ${fen}
go
EOF
sleep 1) | $stockpath | grep 'bestmove' | cut -d ' ' -f2 )
#go depth 20 movetime 4000
if [[ $(cut -d ' ' -f2 last_fen) == *'w'* ]]; then
last_turn="White"
else
last_turn="Black"
fi
printf "\n\e[1;77mLast move: \e[0m\e[1;93m%s\e[0m \e[1;77m(%s\e[0m)\n\n" $move $last_turn

echo $move >> move_history

fi 

echo "var Chess = require('./chessjs/chess').Chess;" > history_pgn
echo "var chess = new Chess();" >> history_pgn

for position in $(cat move_history); do
printf "chess.move('%s', {sloppy: true});\n" $position >> history_pgn
done
echo "console.log(chess.ascii());" >> history_pgn
echo "console.log(chess.fen());" >> history_pgn
##
echo "console.log(chess.in_check());" >> history_pgn
echo "console.log(chess.in_checkmate());" >> history_pgn
echo "console.log(chess.in_stalemate());" >> history_pgn
echo "console.log(chess.insufficient_material());" >> history_pgn
echo "console.log(chess.in_threefold_repetition());" >> history_pgn
#echo "console.log(chess.in_draw());" >> history_pgn
##
node history_pgn > history.txt
table
sed -n 13p history.txt > last_fen
check_position


}

stockfish_path() {
chmod +x engine/Linux/*
arch=$(uname -m)

if [[ $arch == *'armv'* ]]; then
chmod +x engine/Android/*
stockpath="engine/Android/stockfish-10-armv7"

elif [[ $arch == *'arm64v8'* ]]; then
chmod +x engine/Android/*
stockpath="engine/Android/stockfish-10-arm64v8"

elif [[ $arch == *'arm64-pgo'* ]]; then
chmod +x engine/Android/*
stockpath="engine/Android/stockfish-10-arm64-pgo"

elif [[ $arch == *'x86_64'* ]]; then
chmod +x engine/Linux/*
stockpath="engine/Linux/stockfish_10_x64"

elif [[ $arch == *'64_bmi2'* ]]; then
chmod +x engine/Linux/*
stockpath="engine/Linux/stockfish_10_x64_bmi2"

elif [[ $arch == *'64_modern'* ]]; then
chmod +x engine/Linux/*
stockpath="engine/Linux/stockfish_10_x64_modern"

elif [[ $arch == *'686'* || $arch == *'386'* ]]; then

printf "\e[1;93mBinaries not found. Compile from source?\e[0m \e[1;77m[Y/n]"
read from_src

if [[ $from_src == "Y" || $from_src == "y" ]]; then

printf "\e[1;77mChecking dependencies\e[0m\n..."
command -v gcc > /dev/null 2>&1 || { echo >&2 "I require gcc Compiler. Aborting."; exit 1; }
printf "\e[1;77mDownloading\e[0m\n..."
git clone https://github.com/official-stockfish/Stockfish
cd Stockfish/src
make build ARCH=x86-32 COMP=gcc
cd ../../

if [[ -e Stockfish/src/stockfish ]]; then
chmod +x Stockfish/src/stockfish
stockpath="Stockfish/src/stockfish"
else
printf "\e[1;93mError, file not found\e[0m\n"
exit 1
fi
else
exit 1
fi

else

printf "\e[1;93mStockFish not Found\n"
exit 1
fi


}

start() {

touch last_fen
rm -rf move_history
printf "\n"
printf "\e[1;93mStockFish Engine (AI Offline)     StockFish 10 (AI Online)\n\n"
printf "\e[1;93m01.\e[0m\e[1;77m White\e[0m \u2654                     \e[1;93m05.\e[0m\e[1;77m White\e[0m \u2654\n"
printf "\e[1;93m02.\e[0m\e[1;77m Black\e[0m \u265A                     \e[1;93m06.\e[0m\e[1;77m Black\e[0m \u265A\n"
printf "\e[1;93m03.\e[0m\e[1;77m Random\e[0m \u2654 \u265A                  \e[1;93m07.\e[0m\e[1;77m Random\e[0m \u2654 \u265A\n"
printf "\e[1;93m04.\e[0m\e[1;77m AI x AI\e[0m                     \e[1;93m08.\e[0m\e[1;77m AI x AI\e[0m\n"

printf "\n\e[1;93mMiniMax Alpha-Beta JavaScript Engine (Offline) \e[0m\n\n"

printf "\e[1;93m09.\e[0m\e[1;77m White\e[0m \u2654\n"
printf "\e[1;93m10.\e[0m\e[1;77m Black\e[0m \u265A\n"
printf "\e[1;93m11.\e[0m\e[1;77m AI x AI\e[0m\n"
printf "\n"
printf "\e[1;93m99. Help\e[0m\n"

printf "\e[1;93m0.\e[0m\e[1;77m Exit\e[0m\n"

printf "\n\e[1;77mChoose: \e[0m"
read color

# WHITE 
if [[ $color -eq 5 ]]; then
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

elif [[ $color -eq 6 ]]; then
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


elif [[ $color -eq 7 ]]; then

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


elif [[ $color -eq 8 ]]; then

echo "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1" > last_fen

while [ true ]; do

white
black
done

elif [[ $color -eq 99 ]]; then

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

#
elif [[ $color -eq 11 ]]; then #minimax ai x ai

default_level="3"
printf "\e[1;93mLevel\e[0m\e[1;77m (1-3): \e[0m"
read level
level="${level:-${default_level}}"
echo "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1" > last_fen

while [ true ]; do

engine_white
engine_black
done

#
elif [[ $color -eq 9 ]]; then #minimax black
default_level="1"
printf "\e[1;93mLevel\e[0m\e[1;77m (1-3): \e[0m"
read level
level="${level:-${default_level}}"
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
engine_black
engine_white
done

#
elif [[ $color -eq 10 ]]; then
default_level="1"
printf "\e[1;93mLevel\e[0m\e[1;77m (1-3): \e[0m"
read level
level="${level:-${default_level}}"
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
engine_white
engine_black
done
#

elif [[ $color -eq 6 ]]; then
default_level="1"
printf "\e[1;93mLevel\e[0m\e[1;77m (1-3): \e[0m"
read level
level="${level:-${default_level}}"

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

#
elif [[ $color -eq 4 ]]; then # stockfish random

printf "\e[1;93mAI White Level (1-20): \e[0m"
read white_level
printf "\e[1;93mAI Black Level (1-20): \e[0m"
read black_level


echo "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1" > last_fen
stockfish_path
while [ true ]; do

stockfish_white
stockfish_black
done
#
elif [[ $color -eq 2 ]]; then # stockfish black
stockfish_path
default_white_level="3"
default_black_level="3"
printf "\e[1;93mAI White Level (1-20): \e[0m"
read white_level
printf "\e[1;93mAI Black Level (1-20): \e[0m"
read black_level


white_level="${white_level:-${default_level}}"
black_level="${black_level:-${default_level}}"

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
stockfish_white
stockfish_black
done


#
elif [[ $color -eq 1 ]]; then
stockfish_path
first_move=true

default_white_level="3"
default_black_level="3"
printf "\e[1;93mAI White Level (1-20): \e[0m"
read white_level
printf "\e[1;93mAI Black Level (1-20): \e[0m"
read black_level

table
white=true

while [ true ]; do
gturn=$(cat last_fen | cut -d ' ' -f2)
if [[ $gturn == *'b'* ]]; then
turn=$(echo -e '\u265A')
else
turn=$(echo -e '\u2654')
fi
stockfish_black
stockfish_white
done

#

elif [[ $color -eq 3 ]]; then

stockfish_path
choice=$((RANDOM%2))

if [[ $choice -eq 0 ]]; then
printf "\e[1;93mYou:\e[0m\e[1;77m White\e[0m\n"
default_white_level="3"
default_black_level="3"
printf "\e[1;93mAI White Level (1-20): \e[0m"
read white_level
printf "\e[1;93mAI Black Level (1-20): \e[0m"
read black_level

white=true
first_move=true
table
first=stockfish_black
second=stockfish_white

else
white=true
printf "\e[1;93mYou:\e[0m\e[1;77m Black\e[0m\n"
default_white_level="3"
default_black_level="3"
printf "\e[1;93mAI White Level (1-20): \e[0m"
read white_level
printf "\e[1;93mAI Black Level (1-20): \e[0m"
read black_level

first=stockfish_white
second=stockfish_black
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


elif [[ $color -eq 0 ]]; then
exit 1
fi

}
banner
dependencies
start
