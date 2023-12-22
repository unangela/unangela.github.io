---
title: js中prototype的理解学习
date: 2018-02-10 15:41:59
tags: JavaScript
categories: 编程
---
好记性不如烂笔头，学习笔记的整理，方便以后回顾。如果文章内有什么理解得不对的地方，欢迎在评论指正，共同学习进步。<!--more--> 

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
原型属性使我们共享方法方便了很多，当我们创建构造器的时候，我们将可以共享的属性和方法放到原型属性里面，这样在每次使用这个构造器创建实例的时候，就不会重新去声明这些东西，但我们可以通过引用找到这些东西并调用：
```javascript
//创建构造器函数
function Girl(name,age){
    this.name = name;
    this.age = age;
}
Girl.prototype.sex = "female";
Girl.prototype.sayHi = function(){
    console.log("Hi~");
}
//使用函数创建实例，调用原型属性
var rose = new Girl("rose",5);
console.log(rose.sex); //female
rose.sayHi(); //Hi~
```

由于在实例化的时候，并没有重新声明，所以原型具有“实时性”，我们随时可以修改原型属性，这些修改会影响到由该构造器创建的所有对象，包括会影响在修改之前就已经创建了的对象：
```javascript
//修改 Girl
Girl.prototype.sayHi = function(){
    console.log("Hello~");
}
Girl.prototype.sayBye = function(){
    console.log("Bye~");
}
//使用老的实例调用看看
rose.sayHi(); //Hello~
rose.sayBye(); //Bye~
//创建新的实例再试试
var angela = new Girl("angela",16); 
angela.sayBye(); //Bye~
angela.sayHi(); //Hello~
```

修改原型的时候有一个需要注意的地方，还记得前面说到给原型添加属性有两种方法，那么我们如果在修改原型的时候使用第二种方法，会出现什么呢？
```javascript
//使用赋值的方式，尝试同上面一样去修改sayHi和创建sayBye
Girl.prototype = {
    constructor : Girl,
    sayHi : function(){
        console.log("Hello~");
    },
    sayBye : function(){
        console.log("Bye~");
    },
}
//再来调用一下之前创建的rose
rose.sayHi(); //Hi~
rose.sayBye(); //TypeError: rose.sayBye is not a function
//创建个新的实例试试
var angela = new Girl("angela",16); 
angela.sayBye(); //Bye~
angela.sayHi(); //Hello~
console.log(angela.sex) //undefined
```

如果使用赋值的方式去修改原型，此时构造函数的原型对象所指向的就是另一个内存空间，而在此之前所建立的实例仍旧指向原来的空间。所以就会出现上面的结果了。

### 原型链
　　还是继续使用前文的例子吧，我们回到修改原型之前。使用控制台看下实例的结构：  
　　`console.log(rose);`
　　<img src="https://flower-1254284353.cos.ap-chengdu.myqcloud.com/blog%2F2021-01-13-145408.jpg"/>
　　发现一个长得有点像 prototype 的属性名，在里面看到了定义在构造器原型里面的属性和方法。
　　这个 `__proto__` 是所有**对象**都有的一个属性，指向其构造函数的原型属性 prototype 对象。前文提到**函数**也是一种对象，那么构造器函数也是有 \__proto\__ 的，它指向的是什么呢？就是函数的构造器 Function 的 prototype 了。然而对于 **prototype** 来讲，其本身是一个对象，所以也是有 \__proto\__ 的，还记得最初讲原型的时候说过原型的 typeof 输出是 `Object`，原型的 \__proto\__ 所指向的就是 Object 的 prototype。最终 Object.prototype 的 \__proto\__ 属性指向了 null。
　　这样一层一层走到**Object**，就构成了一条由 `__proto__` 连接起来的原型链。
　　来看一张图片理解消化一下（[图片来源](https://www.zhihu.com/question/34183746/answer/58155878)）：
　　<img src="https://flower-1254284353.cos.ap-chengdu.myqcloud.com/blog%2F2021-01-13-145439.jpg"/>
　　原型链有什么作用呢，当对象在调用某个属性时，如果自身属性里没有找到，JS 就会遍历其原型链，一直往 Object 寻找，最先在哪儿找到，就返回谁（也就是同名情况下的优先级），如果到最后都没有找到，就会返回 undefined。
```javascript
Girl.prototype.attr = "attr"
Object.prototype.attr = "attr1";
Function.prototype.attr = "attr2";

console.log(rose.attr); //attr
console.log(rose.constructor.attr); //attr2
```

---
### 附录
##### 辅助内置方法：
+ *`hasOwnProperty(prop)`* : 判断是否是对象自身的属性（Property），如果是来自原型链的或者不存在，则返回 false
+ *`isPrototypeof(Obj)`* : 判断原型是否是当前对象的原型，如果不在整个原型链上，返回 false
+ *object `instanceof` constructor* : 用来检测 constructor.prototype 是否存在于参数 object 的原型链上

##### 参考文章：
+ [JS中的prototype - 轩脉刃](https://www.cnblogs.com/yjf512/archive/2011/06/03/2071914.html)  
+ [js深入理解构造函数和原型对象 - 快饿死的鱼](https://www.cnblogs.com/thonrt/p/5900510.html)  
+ [instanceof 运算符](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/instanceof)