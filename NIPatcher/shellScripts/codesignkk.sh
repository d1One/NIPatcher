#!/bin/sh

#  codesignkk.sh
#  NIPatcher
#
#  Created by Diego Sousa on 29/03/2023.
#
echo "Codesigning"
echo "Please wait..."
echo ""

if [ -d ~/Desktop/NIPatcher/Komplete\ Kontrol.app ]; then
codesign --verbose --force --deep --sign - ~/Desktop/NIPatcher/Komplete\ Kontrol.app
echo "✅ KK App"
else
    echo "❌ App"
fi

if [ -d ~/Desktop/NIPatcher/Komplete\ Kontrol.vst ]; then
codesign --verbose --force --deep --sign - ~/Desktop/NIPatcher/VST/Maschine\ 2.vst
echo "✅ KK VST"
else
    echo "❌ VST"
fi

if [ -d ~/Desktop/NIPatcher/Komplete\ Kontrol.vst3 ]; then
codesign --verbose --force --deep --sign - ~/Desktop/NIPatcher/Komplete\ Kontrol.vst3
echo "✅ KK VST3"
else
    echo "❌ VST3"
fi


if [ -d ~/Desktop/NIPatcher/Komplete\ Kontrol.component ]; then
codesign --verbose --force --deep --sign - ~/Desktop/NIPatcher/Komplete\ Kontrol.component
echo "✅ KK AU"
else
    echo " ❌ AU"
fi


if [ -d ~/Desktop/NIPatcher/Komplete\ Kontrol.aaxplugin ]; then
codesign --verbose --force --deep --sign - ~/Desktop/NIPatcher/Komplete\ Kontrol.aaxplugin
echo "✅ KK AAX"
else
    echo "❌ AAX."
fi

echo ""
echo " Done! 👍"
