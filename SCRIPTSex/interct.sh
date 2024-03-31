


#Determine whether the shell is interactive or not.

#This can be checked by the presence of a variable PS1(it sets the command input function):


if [ "${PS1-}" ]; then
  echo interactive
else
  echo non-interactive
fi
