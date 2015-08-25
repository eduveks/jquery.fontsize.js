# CoffeeScript

(((factory) ->
	if typeof define == 'function' and define.amd
		## AMD. Register as an anonymous module.
		define(['jquery'], factory)
	else
		## Browser globals
		factory(jQuery)
)(($) ->
	config = {
		"protectClass": "fontfixed",
		"attributeClass": "fontsize-class",
		"animate": false,
		"variation": {
			"px": 2
			"em": 0.2
			"rem": 0.2
			"%": 5
			"vw": 0.5
			"vh": 0.5
			"vmax": 0.5
			"vmin": 0.5
		},
		"max": 2,
		"min": -1
	}
	init = ()->
		container = $('#fontsize')
		if container.length == 0
			$('body').append("""
<div id="fontsize" class="#{ config.protectClass }">
	<div id="fontsize-bigger">A<sup>+</sup></div>
	<div id="fontsize-smaller">A<sup>-</sup></div>
</div>
""")

		$('#fontsize-bigger').on 'click', ->
			times = parseInt($.cookie('fontsize')) + 1
			if times > config.max
				return
			$.cookie('fontsize', times, { expires: 10000, path: '/' })
			window.location.reload()

		$('#fontsize-smaller').on 'click', ->
			times = parseInt($.cookie('fontsize')) - 1
			if times < config.min
				return
			$.cookie('fontsize', times, { expires: 10000, path: '/' })
			window.location.reload()

		if $.cookie('fontsize')
			$('body').fontsize()
		else
			$.cookie('fontsize', 0, { expires: 10000, path: '/' })

	$.fn.fontsize = ()->
		args = null
		if arguments.length > 1
			if arguments[0] in ["config", "init"]
				config = $.extend({}, config, arguments[1])
			if arguments[0] == "init"
				init()
			return this
		else if arguments.length == 1
			if arguments[0] == "init"
				init()
				return this
		args = $.extend({}, config, args)
		times = parseInt($.cookie('fontsize'))
		if times == config.min
			$('#fontsize-smaller').addClass('fontsize-disabled')
		if times == config.max
			$('#fontsize-bigger').addClass('fontsize-disabled')
		if times == 0
			return this
		blocked = (elem)->
			if elem.length > 0 && (elem.hasClass(config.protectClass) || elem.attr(config.attributeClass))
				return true
			if elem.length == 0
				return false
			blocked(elem.parent())
		process = (container)->
			container.children().each ->
				that = $(this)
				if that.attr(config.attributeClass)
					that.addClass("#{ that.attr(config.attributeClass) }#{ times }")
					return
				if blocked(that)
					return
				process(that)
				currSize = that.css('font-size').toLowerCase().split(' ')[0].split('!')[0]
				unit = ''
				variation = 0
				for key of args.variation
					if currSize.indexOf(key) > 0
						unit = key
						currSize = currSize.substring 0, currSize.length - key.length
						variation = args.variation[key]
				newSize = parseFloat(currSize)
				if times < 0
					for i in [times..0]
						newSize -= variation
				else if times > 0
					for i in [0..times]
						newSize += variation
				if args && args.animate
					that.animate({ fontSize: newSize + unit }, 250);
				else
					that.css({ fontSize: newSize + unit })
		process(this)
		return this
))
