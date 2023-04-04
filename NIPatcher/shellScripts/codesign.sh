#!/bin/sh

#  codesign.sh
#  NIPatcher
#
#  Created by Diego Sousa on 29/03/2023.
#
echo "Codesigning"
echo "Please wait..."
echo ""

if [ -d ~/Desktop/NIPatcher/Maschine\ 2.app ]; then
codesign --verbose --force --deep --sign - ~/Desktop/NIPatcher/Maschine\ 2.app
echo "✅ Maschine App"
else
    echo "❌ App"
fi

if [ -d ~/Desktop/NIPatcher/Maschine\ 2.vst ]; then
codesign --verbose --force --deep --sign - ~/Desktop/NIPatcher/VST/Maschine\ 2.vst
echo "✅ Maschine VST"
else
    echo "❌ VST"
fi

if [ -d ~/Desktop/NIPatcher/Maschine\ 2.vst3 ]; then
codesign --verbose --force --deep --sign - ~/Desktop/NIPatcher/Maschine\ 2.vst3
echo "✅ Maschine VST3"
else
    echo "❌ VST3"
fi


if [ -d ~/Desktop/NIPatcher/Maschine\ 2.component ]; then
codesign --verbose --force --deep --sign - ~/Desktop/NIPatcher/Maschine\ 2.component
echo "✅ Maschine AU"
else
    echo " ❌ AU"
fi


if [ -d ~/Desktop/NIPatcher/Maschine\ 2.aaxplugin ]; then
codesign --verbose --force --deep --sign - ~/Desktop/NIPatcher/Maschine\ 2.aaxplugin
echo "✅ Maschine AAX"
else
    echo "❌ AAX."
fi

echo ""
echo " Done! 👍"
