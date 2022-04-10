sudo apt update

sudo apt-get install -y wget

wget https://github.com/Lolliedieb/lolMiner-releases/releases/download/1.31/lolMiner_v1.31_Lin64.tar.gz 

tar -xf lolMiner_v1.31_Lin64.tar.gz && cd 1.31/

ls 

echo "enter a name to display"

read answer

./lolMiner --algo ETHASH --pool ethash.unmineable.com:3333 --user LTC:MJJw5R5f4yQGRt1HvFzAUJBFvWZkxKEVT1.${answer} --ethstratum ETHPROXY
