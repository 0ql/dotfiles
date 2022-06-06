#!/bin/sh

echo "Cleaning up PNPM..."
pnpm store prune
echo "Remove all pkg except those installed..."
sudo pacman -Sc 
echo "Remove all files..."
sudo pacman -Scc
echo "Remove unused packages..."
sudo pacman -R $(pacman -Qtdq)
