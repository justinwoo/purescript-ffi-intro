var Main = require("./output/Main");

console.log("Main", Main);

Main.main();

Main.log("Hello from JS")();

Main.__log("Hello from JS 2");

Main.callback(function(int) {
  console.log("Hello from JS in PureScript", int);
});
