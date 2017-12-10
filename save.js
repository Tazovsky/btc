var system = require('system');
var page = require('webpage').create();

page.userAgent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/604.3.5 (KHTML, like Gecko) Version/11.0.1 Safari/604.3.5';

page.open(system.args[1], function(){
  setTimeout(function(){
    console.log(page.evaluate(function(){
      //gets the JSON from the first <pre> element rendered on the page
      return document.getElementsByTagName('pre')[0].textContent;
    }));
    phantom.exit();
  }, 6000); //waits 6 seconds for the page to reload
});
