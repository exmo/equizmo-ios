
#import "include/tune_up/tuneup.js"

var target = UIATarget.localTarget();
var app = target.frontMostApp();

var name = "Robgol Miserê da Bahia";
var email = "robgol@misere.com";

test("Login", function(target, app) {
  	UIALogger.logMessage("Setting name");
	var nameTextField = app.mainWindow().textFields()[0];
	assertNotNull(nameTextField, "Couldnt find user name textField"); 
	nameTextField.tap();
	nameTextField.setValue(name);

	UIALogger.logMessage("Setting email");
	var emailTextField = app.mainWindow().textFields()[1];
	assertNotNull(emailTextField, "Couldnt find email textField");
	emailTextField.tap();
	emailTextField.setValue(email);

	UIALogger.logMessage("Submitting login data");
	var loginButton = app.mainWindow().buttons()["Entrar"];
	assertNotNull(loginButton, "Couldnt find login button");
	loginButton.tap();

	target.delay(3);

	UIALogger.logMessage("Looking for user name in ranking view");
	app.mainWindow().staticTexts()[name].tapWithOptions({tapOffset:{x:0.56, y:0.74}});

	assertNotNull(app.mainWindow().staticTexts()[name], "Couldnt find user name");
	
});

test("Logout", function(target, app) {
	assertNotNull(app.mainWindow().buttons()["logout"], "Couldnt find logout button");
  	app.mainWindow().buttons()["logout"].tap();
	 
	var loginButton = app.mainWindow().buttons()["Entrar"];
	assertNotNull(loginButton, "Couldnt find login button");
	 
});


UIATarget.onAlert = function onAlert(alert) {
	if (alert.buttons()["Ok"]) {
		alert.buttons()["Ok"].tap();
		return  true;   	
	}
	return  false; 
}



