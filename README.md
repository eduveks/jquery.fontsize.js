# jquery.fontsize.js
jQuery plugin to control the font size in all HTML/DOM.

Add 2 buttons to change to big or small the size of the font in all HTML elements.

Easy to customize and saves the current font size state in a cookie to make the navigation in a website always with the font size choosed by the user.

## Usage:

```
$('body').fontsize('init', {
	"protectClass": "fontfixed",
	"attributeClass": "fontsize-class",
	"animate": false,
	"variation": {
		"px": 2,
		"em": 0.2,
		"rem": 0.2,
		"%": 5,
		"vw": 0.5,
		"vh": 0.5,
		"vmax": 0.5,
		"vmin": 0.5
	},
	"max": 2,
	"min": -1
});
```

## Screenshots:

![Alt text](screenshots/controls.png?raw=true "Font Size Controls")

![Alt text](screenshots/mobile.png?raw=true "Mobile View")

![Alt text](screenshots/demo.png?raw=true "Demo")

