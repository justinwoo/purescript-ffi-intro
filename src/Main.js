// normal function that returns an Effect, which is a thunk
exports._log = function(str) {
  return function() {
    console.log(str);
  };
};

exports._log2 = function(str1) {
  return function(str2) {
    return function() {
      console.log(str1, str2);
    };
  };
};

// uncurried function of 1 argument which runs the effect directly
exports.__log = function(str) {
  console.log(str);
};

exports.__log2 = function(str1, str2) {
  console.log(str1, str2);
  return 123;
};

exports.__log3 = function(foreign) {
  console.log(foreign);
};
