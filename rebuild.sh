#!/usr/bin/env bash

#Initial Cleanup
find ./static/embed/ -name "*.html" -type f delete 2> /dev/null
find ./static/ -name "*.html" -type f delete 2> /dev/null

# Outside Variables
convertVar="./scripts/md2html.sh"
cutVar=$(ls pages -l | tr -s " " | cut -d " " -f9 | grep -v html | cut -d "." -f1)
startVar="./snippets/start.html"
headerVar="./snippets/header.html"
footerVar="./snippets/footer.html"
endVar="./snippets/end.html"

# Front Page Manager
frontFunc() {
sed -i '/-/d' ./pages/home.md
for l in $(ls pages | cut -d "." -f1 | grep -v embed | grep -v home | grep -v about);
do
    d=$(grep "Date" ./pages/$l.md | cut -d " " -f 3)
    echo "   - [$d $l]($l.html)" >> ./pages/home.md
done
}

# The Loop de Loop
loopFunc() {
for i in $cutVar;
do
    #Inside Vars
    pages="./pages/$i.md"
    static="./static/$i.html"
    staticEmbed="./static/embed/$i.html"
    $convertVar $pages $staticEmbed
    cat $startVar $headerVar $staticEmbed $footerVar $endVar > $static
done
}

# Run the Functions
frontFunc
loopFunc
