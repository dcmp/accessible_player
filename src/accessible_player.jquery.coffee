# The MIT License (MIT)
# Copyright (C) 2013 by DCMP <http://dcmp.org>
#
# Contact: Rob Flynn <rflynn@dcmp.org>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

$ = jQuery

# An abstract class that provide jQuery plugin setup functionalities.
class jQueryPlugIn
  
  # Redefine this dictionary to specify default options
  @defaultOptions: {}
  
  # The default constructor calls the initialize method and set the jQuery element.
  # Remember to call super in subclasses if you want to maintain this behaviour.
  constructor: (@element, options) ->
    @initialize options
  
  # Method to initialize the plugin instance with the given options
  # This method could be called 
  initialize: (@options) ->
  	# 

  execute_method: (method, args...) ->
  
  # Install a class as a jQuery plugin. Assuming that myClass extends jQueryPlugIn it can than be installed with:
  # myClass.installAsjQueryPlugIn()
  @installAsjQueryPlugIn: (pluginName = @name) ->
    pluginClass = @

    $.fn[pluginName] = (options, args...) ->
      options = $.extend pluginClass.defaultOptions, options or {} if $.type(options) is "object"
      return @each () ->
        $this = $(this)
        instance = $this.data pluginName
        if instance?
          # console.log "We already have an instance, we're trying to execute a method on it."
          if $.type(options) is "string"
            # Execute the method with the supplied arguments
            # instance[options].apply instance, args
            instance.execute_method(options, args...)
          else if instance.initialize?
            instance.initialize.apply instance, [options].concat args
        else
          plugin = new pluginClass $this, options, args...
          $this.data pluginName, plugin
          $this.addClass pluginName
          $this.bind "destroyed.#{pluginName}", () -> 
            $this.removeData pluginName
            $this.removeClass pluginName
            $this.unbind pluginName
            plugin.destructor()
          return plugin


window.__DCMP_EMBED_COUNTER = 0

class AccessiblePlayer extends jQueryPlugIn

	@defaultOptions:
		movie: null
		captions:
			file: null
			back: true
			fontsize: 14
			color: "#fffff"
		buttons:
			play_class: "ap-play-button"
			stop_class: "ap-stop-button"
			volume_up_class: "ap-volume-up-button"
			volume_down_class: "ap-volume-down-button"
			mute_class: "ap-mute-button"
			skip_ahead_class: "ap-skip-ahead-button"
			skip_back_class: "ap-skip-back-button"
			caption_class: "ap-caption-button"
		width: 650

	constructor: (@element, options) ->		

		@methods =
			# No methods present

		@player_id = 0

		# Clear out any existing HTML that may be found within the div
		@element.html("");		

		super @element, options				


	initialize: (@options) ->
		super @options

		@player_id = window.__DCMP_EMBED_COUNTER++;
		@player_element = "__dcmp_ap_#{@player_id}"

		@render_ui_elements()
		@render_player()
		@setup_event_listeners()

	render_ui_elements: =>
		template = """
		<div class="ap-video-wrapper">
			<div class="ap-video-controls">
				<ul>
					<li><a aria-role="button" class="ap-control-button #{@options.buttons.play_class}">Play/Pause</a></li>
					<li><a aria-role="button" class="ap-control-button #{@options.buttons.stop_class}">Stop and Rewind</a></li>
					<li><a aria-role="button" class="ap-control-button #{@options.buttons.volume_up_class}">Volume Up</a></li>
					<li><a aria-role="button" class="ap-control-button #{@options.buttons.volume_down_class}">Volume Down</a></li>
					<li><a aria-role="button" class="ap-control-button #{@options.buttons.mute_class}">Mute</a></li>
					<li><a aria-role="button" class="ap-control-button #{@options.buttons.skip_ahead_class}">Ahead 5 Seconds</a></li>
					<li><a aria-role="button" class="ap-control-button #{@options.buttons.skip_back_class}">Back 5 Seconds</a></li>							
					<li><a aria-role="button" class="ap-control-button #{@options.buttons.caption_class}">Toggle Captions</a></li>							
				</ul>
			</div>
			<div class="ap-video-player" aria-hidden="true">
				<div class="ap-media-item" id="#{@player_element}">Loading....</div>
			</div>
		</div>
		"""

		console.log(@element)

		@element.html(template)

	render_player: =>
		wrapper = @element.find(".ap-video-player")
		player_options =
			file: @options.movie,
			tracks: [
				file: @options.captions.file
				kind: "captions"
				default: true
			],
			captions:
				back: @options.captions.back,
				color: @options.captions.color
				fontsize: @options.captions.fontsize

		console.log @options
		if @options.width and @options.width != "auto"
			player_options.width = @options.width
		else
			player_options.height = @element.find(".ap-video-controls").height() - 4			

		console.log("player options: ", player_options)

		jwplayer(@player_element).setup player_options

	setup_event_listeners: =>
		player = @player_element		

		$("##{@element.prop("id")} .#{@options.buttons.play_class}").click (evt) =>
			if jwplayer(player).getState() == "PLAYING" then jwplayer(player).pause() else jwplayer(player).play()

		$("##{@element.prop("id")} .#{@options.buttons.stop_class}").click (evt) =>
			jwplayer(player).stop()

		$("##{@element.prop("id")} .#{@options.buttons.volume_up_class}").click (evt) =>
			jwplayer(player).setVolume(jwplayer(player).getVolume() + 10)

		$("##{@element.prop("id")} .#{@options.buttons.volume_down_class}").click (evt) =>
			jwplayer(player).setVolume(jwplayer(player).getVolume() - 10)

		$("##{@element.prop("id")} .#{@options.buttons.mute_class}").click (evt) =>
			jwplayer(player).setMute(!jwplayer(player).getMute())

		$("##{@element.prop("id")} .#{@options.buttons.skip_ahead_class}").click (evt) =>
			jwplayer(player).seek(jwplayer(player).getPosition() + 5)

		$("##{@element.prop("id")} .#{@options.buttons.skip_back_class}").click (evt) =>
			jwplayer(player).seek(jwplayer(player).getPosition() - 5)

		$("##{@element.prop("id")} .#{@options.buttons.caption_class}").click (evt) =>
			current_track = jwplayer(player).getCurrentCaptions()

			if current_track == 0 then jwplayer(player).setCurrentCaptions(1) else jwplayer(player).setCurrentCaptions(0)


AccessiblePlayer.installAsjQueryPlugIn("accessible_player")
