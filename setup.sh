chmod +rwx main.sh

if [ -f ~/.bashrc ]; then
  echo "alias vidlengthcalc='~/Developer/videoLengthCalculator/main.sh'" >> ~/.bashrc
elif [ -f ~/.zshrc ]; then
  echo "alias vidlengthcalc='~/Developer/videoLengthCalculator/main.sh'" >> ~/.zshrc
fi
