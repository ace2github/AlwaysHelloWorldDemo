import 'FunctionDemo.dart';
import 'ClassDemo.dart';

// void sayHello(String name) {
//   print('$name say hello!');
// }

void sayHello(String name) => print('$name say hello!');

void testMapTypeDemo() {

}


void main(List<String> args) {
  testMapTypeDemo();
  // testListTypeDemo();

  // sayHello('Tom'); // Tom say hello!

  // String slogan = 'hello haha';
  // var dataList = <String>[slogan];
  // dataList.insert(0, '123456');
  // print(dataList);

  // int? age;
  // print(age);

  // // Error: Can't assign to the final variable 'name'.
  // const String name = 'hello';
  // name = 'new hello';



  // // Error: Can't assign to the const variable 'list'.
  // const list = [1, 2, 3];
  // list = [11, 12];

  // // Unsupported operation: Cannot modify an unmodifiable list
  // list[0] = 10;
  // print(list);

  // var list = const [];
  // list = [1, 2, 3];
  // print(list);

  // list[0] = 10;
  // print(list);

  // // number类型  
  // num val = 1;
  // print(val); // 1

  // val += 0.5;
  // print(val); // 1.5

  // // 布尔值
  // bool flag = false;
  // print(flag);
  // flag = true;
  // print(flag);

  // final constantSet = const {
  //   'fluorine',
  //   'chlorine',
  //   'bromine',
  //   'iodine',
  //   'astatine',
  // };
  

  // var name;
  // print(name);

  // String nickName;
  // print(nickName); // 报错，不可为空变量，使用前必须初始化

  // String? nickName1;
  // print(nickName1); // 不会报错，null

  // int num = 1;
  // print("%x", num);

  // var list = [1, 2, 3];
  // printArray(list);
  // sayHelloworld('cch');
  
  // class_demo_test();

  // testFunctionHandler();

  // var foo = const [];
  // foo = [1, 2, 3];
  // print(foo);
  // foo[0] = 0;
  // print(foo);

  // foo = [2, 3, 4];
  // print(foo);

  // var list = [1, 2, 3];
  // var list2 = [0, ...list];
  // print(list2); // [0, 1, 2, 3]

  // var null_list;
  // var list3 = [0, ...?null_list];
  // print(list3); // [0]

  // bool promoActive = true;
  // var nav = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];
  // print(nav); // [Home, Furniture, Plants, Outlet]

  // var listOfInts = [1, 2, 3];
  // var listOfStrings = ['#0', for (var i in listOfInts) '#$i'];
  // print(listOfStrings); // [#0, #1, #2, #3]
  
}

void testListTypeDemo() {
  var fruits = [];
  print('isEmpty:${fruits.isEmpty}');

  fruits.add('apples');
  fruits.addAll(['pear', 'banana']);
  print('原数组：$fruits');
  print('first:${fruits.first}, last:${fruits.last}');
  print('length:${fruits.length}');
  print('indexOf: ${fruits.indexOf('banana')}');
  print("contain:${fruits.contains('apples')}");
  print("join:${fruits.join('、 ')}");

  fruits.insert(0, 'watermalon');
  print('原数组：$fruits');

  print('range:${fruits.getRange(0, 2)}');

  fruits.remove('apples');
  fruits.removeAt(0);
  print(fruits);

  fruits.clear();
  print(fruits);

  var list = List.filled(8, 'name');
  print(list);

  var numbers = [1, 2, 3, 4, 5, 6, 7, 8];
  print('原数组：$numbers');
  numbers.sort((a, b) => a>b?a:b);
  print('倒叙：$numbers');
}
