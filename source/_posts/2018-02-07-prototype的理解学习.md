---
title: js中prototype的理解学习
date: 2018-02-07 09:20:59
tags: JavaScript
categories: 笔记
---
　　好记性不如烂笔头，学习笔记的整理，方面以后回顾和总结。如果文章内有什么理解得不对的地方，欢迎在评论指正，共同学习进步。<!--more--> 

---
### 函数
　　在理解原型之前，我们要先来理解 js 的函数 `function()` , javascript 里面，函数也是一种对象。我们创建函数有三种方法：
```javascript
//function declaration 函数声明
function sum(a+b){
    return a+b;
}

//function expression 函数表达式
var sum = function(a,b){
    return a+b;
}

//Function()构造器，尽量避免使用这种方式
var sum = new Function('a','b','return a+b;');
```
>函数声明和函数表达式的区别在于，用函数声明创建的函数可以在函数定义之前就进行调用，而用函数表达式创建的函数不能在函数被赋值之前进行调用：
```javascript
funDeclaration();   // Declaration
funExpression();    // TypeError: funExpression is not a function

function funDeclaration(){
   console.log("Declaration")
}
var funExpression = function(){
  console.log("Expression")
}

funExpression();    // Expression
```
### 函数对象
　　与其他对象一致，函数对象中也有名为 `constructor` 的属性，其引用的就是 `Function()` 这个构造函数。它是所有函数对象的基础，一个小插曲，Object 是所有对象（包括函数对象）的基础，在 JavaScript 中，任何一个对象都是 Object 的实例，因此，可以修改 Object 这个类型来让所有的对象具有一些通用的属性和方法，修改 Object 类型就可以通过 `prototype` 来完成的:
```javascript
Object.prototype.getType = function(e){ 
  return typeof(e); 
}
var a1 = new Array();
var a2 = [];
var x = 0;
function f1(a,b){ 
  return a+b; 
}
console.log(getType(true));
console.log(a1.getType(a1)); 
//console.log(a2 instanceof Array)//数组的类型要用instanceof来判断，typeof有局限性
console.log(f1.getType(function f2(){})); 
console.log(x.getType("123")); 
```
>prototype 是使用非常广泛的函数属性，当函数作为构造器使用的时候，prototype 就会发挥其作用，由该构造器函数创建的所有对象中都会含有一个该 prototype 属性的引用，并可以当做自身的属性来使用。js 创建对象的时候有一个 `__proto__` 内置属性，用于指向创建它的函数对象。

　　也和其他对象一致，函数也有自己的对象方法。比如，JS 中的每个函数都有 `call()` 和 `apply()` 两个方法，它们可以让一个对象去“借用”另一个对象的方法并为己所用。
```javascript
//我们先创建了一个对象A，它有一个名字和打招呼的方法
var A = {
    name: "A",
    say: function(who){
        return ("Hello " + who + ",I am " + this.name );
    }
}
console.log(A.say("B"));//我们用A调用了say()方法

//现在我们来创建一个对象B
var B = {
    name: "B"
}
//我们发现A的say方法完全可以和B一起用，这里就需要用到call()或者apply();
console.log(A.say.call(B,"A"));
console.log(A.say.apply(B,["A"]));
```
　　`call()` 和 `apply()` 的区别就是后面的参数形式。需要传递多个参数的时候 call 使用逗号隔开，例 `X.fuc.call(Y,"参数1","参数2","参数3")`，apply 则是需要把参数放到一个数组里面，如 `X.fuc.apply(Y,["参数1","参数2","参数3"])` 。这两种写法是等效的。

---
### 原型
　　如前文说的那样，我们知道了在函数被创建的时候就有一些默认的属性，这些属性中就包括 prototype ，它的初始值是一个空的对象。
```javascript
function fx(a,b){
    return a+b;
}
console.log(typeof fx.prototype) //Object
```
　　我们可以为它添加新的属性和方法，它们不会对自己的函数本身造成影响：
```javascript
//方法一：通过改变对象的属性来添加
fx.prototype.type = "Math";
fx.prototype.info = function(){
    return ("My type is "+this.type);
};
//方法二：或者创建一个新的对象赋值
fx.prototype = {
    type : "Math",
    info : function(){
        return ("My type is "+this.type)
    },
}
//测试
console.log(fx.info()) //TypeError: fx.info is not a function
console.log(fx.prototype.info()) //My type is Math
```
　　方法二看起来要简单方便一点，但在使用的时候要注意，赋值的方式其实是改变了 prototype 本身的性质。一个函数在被创建时，它的 prototype 属性也被创建，且该原型对象的 constructor属性指向该函数。当使用一个新的对象改写原型对象时，其 constructor 属性将被置为泛用对象Object。为了避免这一点，需要在改写原型对象的时候手动重置 constructor。
```javascript
fx.prototype = {
    constructor : fx,
    type : "Math",
    info : function(){
        return ("My type is "+this.type)
    },
}
```
### 原型使用
### 原型链