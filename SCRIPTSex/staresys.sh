#!/bin/bash

# Starea sistemului
echo "Memoria volatila:"
/usr/bin/free -h
echo "HDD utilizare:"
/usr/bin/df -h
echo "Timpul de functionare de la ultimul start/restart:"
uptime

exit
