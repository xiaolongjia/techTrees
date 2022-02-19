// data type
// number 
var todayData = 432;
var yesterdayData = 398;
console.log(todayData);
console.log(yesterdayData);
// string 
var stuName = "Tim";
console.log("hello " + stuName + " " + todayData);
// boolean 
var flag = true;
console.log(flag);
// array
var arr1 = [1, 2];
var arr2 = [1, 2];
console.log(arr1[1]);
console.log(arr2[0]);
// Tuple
var myTuple = [23, 'hello', 'tim'];
console.log('tuple');
console.log(myTuple[1]);
// enum 
var Color;
(function (Color) {
    Color[Color["Red"] = 0] = "Red";
    Color[Color["Green"] = 1] = "Green";
    Color[Color["Blue"] = 2] = "Blue";
})(Color || (Color = {}));
;
var c = Color.Blue;
console.log(c); // 输出 2
// void function 
hello();
function hello() {
    console.log("hello!");
}
// any 
var x = 'string';
x = 2;
x = false;
x = undefined;
console.log(x);
// null undefined 
var y;
y = 309;
y = null;
y = undefined;
console.log(y);
// never 
// let neverStr = (()=>{ throw new Error('exception')})();
// console.log(neverStr)
// Type Assertion 
var str = 21;
var str2 = str;
console.log(str2);
// operator and If ... else ...
// + - * / %(mod)
if (str == str2) {
    console.log("equal");
}
else {
    console.log("not equal");
}
/*
if ... else if ... else if ... else
*/
// for 
for (var i = 1; i <= 10; i++) {
    console.log(i);
}
// for in 
var myList = [32, 98, false, 'Hello'];
for (var myElement in myList) {
    console.log(myElement);
    console.log(myList[myElement]);
}
// for of 
var someArray = [1, "string", false];
for (var _i = 0, someArray_1 = someArray; _i < someArray_1.length; _i++) {
    var entry = someArray_1[_i];
    console.log(entry); // 1, "string", false
}
// forEach 
myList.forEach(function (val, idx, arry) {
    console.log(val);
    console.log(idx);
    console.log(arry);
});
