---
title: js中prototype的理解学习
date: 2018-02-07 09:20:59
tags: JavaScript
categories: 笔记
---
　　好记性不如烂笔头，学习笔记的整理，方面以后回顾和总结。如果文章内有什么理解得不对的地方，欢迎在评论指正，共同学习进步。<!--more--> 

---
#### 函数
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
　　函数声明和函数表达式的区别在于，用函数声明创建的函数可以在函数定义之前就进行调用，而用函数表达式创建的函数不能在函数被赋值之前进行调用：
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
#### 函数对象
　　与其他对象一致，函数对象中也有名为 `constructor` 的属性，其引用的就是 `Function()` 这个构造函数。它是所有函数对象的基础，一个小插曲，`Object` 是所有对象（包括函数对象）的基础，在 JavaScript 中，任何一个对象都是 Object 的实例，因此，可以修改 Object 这个类型来让所有的对象具有一些通用的属性和方法，修改 Object 类型是通过 **`prototype`** 来完成的:
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
　　prototype 属性是

