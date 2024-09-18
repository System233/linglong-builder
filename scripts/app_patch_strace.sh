echo -e '\nstrace' >>deps.list
echo 'export SHELL_EXEC="strace -o /dev/null -fqe none"' >>env.sh
