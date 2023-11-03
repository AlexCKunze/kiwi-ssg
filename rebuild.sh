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

# The Loop de Loop
loopFunc() {
for i in $cutVar;
do
    #Inside Vars
    pages="./pages/$i.md"
    static="./static/$i.html"
    staticEmbed="./static/embed/$i.html"
    cat $startVar $headerVar $staticEmbed $footerVar $endVar > $static
    $convertVar $pages $staticEmbed

done
}
loopFunc
loopFunc

# Front Page
sed -i '/-/d' ./pages/home.md
for l in $(ls pages | cut -d "." -f1 | grep -v embed | grep -v home | grep -v about);
do
    echo "   - [$l]($l.html)" >> ./pages/home.md
done
