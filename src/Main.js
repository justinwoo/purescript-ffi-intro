// normal function that returns an Effect, which is a thunk
exports._log = function(str) {
  return function() {
    console.log(str);
  };
};

// uncurried function of 1 argument which runs the effect directly
exports.__log = function(str) {
  console.log(str);
};
