#!/bin/sh

swaylock \
  --screenshots \
  --clock \
  --indicator-idle-visible \
	--indicator-radius 100 \
	--indicator-thickness 7 \
	--ignore-empty-password \
	--ring-color 455a6499 \
	--key-hl-color be504699 \
	--text-color ffc10799 \
	--line-color 00000000 \
	--inside-color 00000088 \
	--separator-color 00000000 \
	--fade-in 0.1 \
  --effect-scale 0.5 \
  --effect-blur 7x3 \
  --effect-scale 2 \
	--effect-vignette 0.5:0.5 \
	--effect-compose "0,1.5%;-1x10%;$HOME/.config/sway/lock.svg" \
	"$@"

