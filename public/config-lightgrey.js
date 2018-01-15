"use strict";
// Wiresphere config file
// Do not delete anything from this file!

var WiresphereConfig = {
	Background: {
		SolidBg: {							
			Color: '#fff'					// Solid background color
		},
		
		Picture: {
			Enabled: false,					// Background picture true/false
			Opacity: '0.07'					// Background picture opacity
		},
		
		Gradient: {
			Enabled: true,					// Background animated gradient true/false	
			StopAColor : '0,0,0',			// Background animated gradient Stop A
			StopBColor : '0,0,0',			// Background animated gradient Stop B
			Opacity : 0.4					// Background animated gradient opacity
		},
		
		
		Sphere3D: {
			lineColor: 0x000000,			// Color of sphere outline
			lineOpacity: 0.5,				// Opacity of front face of sphere
			backlineOpacity: 0.05,			// Opacity of backface of sphere
			particleColor: 0x000000,		// Color of particles
			particleOpacity: 0.5,			// Opacity of particles
			particleSize: 5,				// Size of particles
			particlesAmmount: 750,			// Ammount of particles
			moveSpeed: 0.07,				// Speed of particles
			cameraXMoveMax: 1.5,			// Mouse movement max rotation
			cameraYMoveMax: 0.75,			// Mouse movement max rotation
			cameraXMoveElastic: 0.02,		// Mouse movement smoothness
			cameraYMoveElastic: 0.02		// Mouse movement smoothness
		},
		
		Noise: {
			Enabled: true,					// Background noise true/false
			Opacity: '0.05'					// Background noise opacity
		}
		
	},
	
	Colors: {
		JSOverride: true,					// Set to false if you want to tweak CSS
		
		Tagline: {							// Tagline
			FirstLine: '#FFF',				// Color of first line of tagline
			SecondLine: '#000'				// Color of second line of tagline
		},
		
		Buttons: {							// Buttons
			Outline: '#FFF',				// Color of buttons outline
			Text: '#000',					// Color of buttons text
			TextHover: '#000'				// Color of buttons text on hover
		},
		
		SideContent: {						// Side content 
			Background: '#FFF',				// Background of side content 
			Text: '#000',					// Text color of side content 
			ContactIcons: '#DDD',			// Color of contact icons
		}
		
	},
	
	Map: {
		Longtitude: -73.946,				// X Map location 
		Latitude: 40.674,					// X Map location
		Style: [							// X Map style - refer to Google Maps for more details
		  {
			"stylers": [
			  { "saturation": -100 },
			  { "lightness": 62 },
			  { "gamma": 0.47 }
			]
		  },{
			"elementType": "labels.text",
			"stylers": [
			  { "color": "#ffffff" },
			  { "visibility": "simplified" }
			]
		  },{
			"elementType": "labels.icon",
			"stylers": [
			  { "gamma": 2.17 }
			]
		  }
		]
	}
	
}