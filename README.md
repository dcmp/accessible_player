# DCMP Accessible Player#

The DCMP Accessible Player is a simple wrapper for providing additional accessibility to embedded youtube videos. It is based on jQuery and JWPlayer.

#Installation#
 1. Download, uncompress, and place the CSS and JS files in a folder on your web server.

#Usage#

###Requirements###
    <!-- replace the below line with the proper path to your jwplayer library -->
    <script src="/jwplayer/jwplayer.js"></script>

    <!-- Be sure to load jQuery first -->       
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>

    <!-- and finally include the accessible player library -->
    <script src="/lib/accessible_player.jquery.js"></script>

    <!-- Load the necessary CSS -->
    <link rel="stylesheet" type="text/css" href="/lib/accessible_player.jquery.css" />

###Standard Example###

The standard appearance of **accessible_player** is that of a black background with a white caption font. 

    <div id="movie-1"></div>
    <script>    
    $("#movie-1").accessible_player({
    	movie: 'http://www.youtube.com/watch?v=G9YuKs3Jitk',
    	captions: {
    		file: '/example/G9YuKs3Jitk.srt'						
    	}
    });
    </script>    

###Additional Options###

The plugin supports toggling the background on and off as well as setting the font size and font color. An outline will be placed around the caption text in cases where the background is disabled.

    <div id="movie-2"></div>

    <script>    
    $("#movie-2").accessible_player({
    	movie: 'http://www.youtube.com/watch?v=gupNRww6vFc',
    	captions: {
    		file: '/example/gupNRww6vFc.srt',
    		color: '#ff0000'
    	}					
    });
    </script>

> Display captions in red text on a black background

    <div id="movie-3"></div>
        
    <script>    
    $("#movie-3").accessible_player({
    	movie: 'http://www.youtube.com/watch?v=Ys--nYjRQUA',
    	captions: {
    		file: '/example/Ys--nYjRQUA.srt',
    		back: false,
    		color: '#ffff00',
    		fontsize: 23
    	}
    });
    </script>    

>  Display large yellow text without a background

#Contribution#

If you would like to contribute to this plugin, please fork the repository and make your modifications. Afterwards, please send us a pull request.

#License#

The MIT License (MIT)

Copyright (C) 2013 by DCMP <http://dcmp.org>

Contact: Rob Flynn <rflynn@dcmp.org>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

