# haustothehaus
House music with house sounds. Live coded with [Sonic Pi](https://sonic-pi.net/).

## videos
* [garage (labour day demo)](https://youtu.be/KhOGhzWaOqc)

## logo
haustothehaus logo was designed by [@hydroxymoron](https://github.com/hydroxymoron).

## music
The `songs` directory contains all the code for each song. Generally organized into `sounds.rb`, `patterns.rb` and 'notes.rb`. I load sounds and patterns to play each song:

``` ruby
run_file "<base_dir>/songs/garage/sounds.rb"
run_file "<base_dir>/songs/garage/patterns.rb"
```

The samples I either recorded myself or were modified from unrestricted-license sounds on [freesound.org](www.freesound.org). One day I will try to release a sample pack.

## vizualization

The `viz` directory contains the code for the svg/js animations. They are synchronized to Sonic Pi via OSC. To get started, run the node server from `viz/`:

``` bash
node .
```

Then start Sonic Pi and use the appropriate address/port, e.g.:

``` ruby
use_osc "10.0.0.129", 7400
```

Finally, open the `viz/web/index.html` in a browser.

Now call any of the animations defined in `toolbox.rb` by giving them a css selector and a number of beats (as well as any other parameter). Some examples:

``` ruby
color '.big-haus', 4, 'haus_yellow' # changes color of .big-haus to yellow in 4 beats
rotate '.a.little-haus', 1, 5 # rotates the 'a' of the little haus by 5 degrees in 1 beat
```
