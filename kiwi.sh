#!/usr/bin/env bash

rebuildFunc() {

    #Initial Cleanup
    find ./static/embed/ -name "*.html" -type f -delete
    find ./static/ -name "*.html" -type f -delete
    echo "" > ./static/dates.txt

    # Location Shortcuts
    convertVar="pandoc"
    startVar="./snippets/start.html"
    headerVar="./snippets/header.html"
    footerVar="./snippets/footer.html"
    endVar="./snippets/end.html"

    # Creates the posts page, and populates it with new posts along with their dates
    frontFunc() {
        sed -i '/-/d' ./pages/home.md
        for l in $(find pages | cut -d "/" -f2 | cut -d "." -f1 | grep -v -e 'embed' -e 'home' -e 'about' -e 'pages'); do
            d=$(grep "Date" ./pages/"$l".md | cut -d " " -f 3)
            echo "   - [$d $l]($l.html)" >> ./static/dates.txt
        done
        cat ./static/dates.txt >> ./pages/home.md
    }

    # Transforms markdown files into actual HTML pages with all the core elements needed for the website
    redoFunc() {
        for i in $(find pages | cut -d "/" -f2 | cut -d "." -f1  | grep -v -e 'html' -e 'pages'); do
            #Inside Vars
            pages="./pages/$i.md"
            static="./static/$i.html"
            staticEmbed="./static/embed/$i.html"
            "$convertVar" -f markdown "$pages" -o "$staticEmbed"
            cat "$startVar" "$headerVar" "$staticEmbed" "$footerVar" "$endVar" > "$static"
        done
    }

    linkFunc() {
        for i in $(ls ./static/styles); do
            unlink ./static/styles/$i
        done
        for i in $(ls ./styles); do
            ln ./styles/$i ./static/styles/$i
        done
    }

    # Runs the Functions
    frontFunc
    redoFunc
    linkFunc

}

case $1 in

    --rebuild)
        rebuildFunc;;

    --new)
        touch ./pages/"$2".md;;

    "--edit")
        if [ ! -f "./pages/$2.md" ]; then
            echo "File Doesn't Exist"
        else
            $EDITOR ./pages/$2.md
        fi;;

        *)
            echo -e """
            --rebuild \t\tRebuilds the site
            --new <post-name> \tCreates a new post as ./pages/<post-name>.md
            """;;

esac
