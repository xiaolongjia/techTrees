

// data type
// number 
let todayData: number = 432
let yesterdayData: number = 398

console.log(todayData)
console.log(yesterdayData)

// string 
let stuName: string = "Tim"
console.log(`hello ${ stuName } ${ todayData }`)

// boolean 
let flag: boolean = true;
console.log(flag)

// array
let arr1: number[] = [1, 2];
let arr2: Array<number> = [1, 2];
console.log(arr1[1])
console.log(arr2[0])

// Tuple
let myTuple: [number, string, string] = [23, 'hello', 'tim']
console.log('tuple')
console.log(myTuple[1])

// enum 
enum Color {Red, Green, Blue};
let c: Color = Color.Blue;
console.log(c);    // 输出 2

// void function 
hello();

function hello(): void {
	console.log("hello!")
}

// any 
let x: any = 'string'
x =  2
x = false 
x = undefined
console.log(x) 

// null undefined 
let y: number | null | undefined 
y = 309
y = null
y = undefined
console.log(y)

// never 
// let neverStr = (()=>{ throw new Error('exception')})();
// console.log(neverStr)

// Type Assertion 

var str:number = 21
var str2:number = <number> <any> str 
console.log(str2) 

// operator and If ... else ...
// + - * / %(mod)

if (str == str2) {
	console.log("equal")
} else {
	console.log("not equal")
}

/* 
if ... else if ... else if ... else 
*/

// for 
for (var i=1; i<=10; i++) {
	console.log(i)
}

// for in 
var myList : any = [32, 98, false, 'Hello' ]
for (var myElement in myList) {
	console.log(myElement)
	console.log(myList[myElement])
}

// for of 
let someArray = [1, "string", false];
for (let entry of someArray) {
    console.log(entry); // 1, "string", false
}

// forEach 
myList.forEach((val, idx, arry) => {
	console.log(val)
	console.log(idx)
	console.log(arry)
}
)









