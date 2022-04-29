void testFunctionHandler() {
  // const list = ['apples', 'bananas', 'oranges'];
  // list.forEach((item) {
  //   print('${list.indexOf(item)}: $item');
  // });

  // print(say1('xxx', '123456')); //xxx says 123456

  // print(say('Bob', 'Howdy')); //Bob says Howdy
  // print(say(
  //     'Bob', 'Howdy', 'smoke signal')); // Bob says Howdy with a smoke signal
 
  // introduce_10(name: 'cch', age: 10);

  // introduce_2();
  // introduce_2(age: 30);
  // introduce_2(name: 'tom', age: 30);

  // introduce_1();
  // introduce_1(age: 30);
  // introduce_1(name: 'tom', age: 30);

  // introduce_1_1();
  // introduce_1_1(age: 20);
  // introduce_1_1(name: 'tom', age: 30);
  // Error: Required named parameter 'name' must be provided.
  // introduce_1_2(age: 30);  
  // tom and null
  // introduce_1_2(name: 'tom');


  // introduce_2(name: 'name');

  // var add2 = makeAdder(2, 'aaa');
  // var add4 = makeAdder(4, 'bbb');
  // print(add2(3)); // 5 aaa
  // print(add4(3)); // 7 bbb

  // sayHelloworld_1('cch', age: 30);
  // sayHelloworld_1('cch-1');

  // say_1('tom', 'hello world!');
  // say1('tom');

  // sayHelloworld_1('tom');
  // sayHelloworld_1('tom', age: 30);

  print(say_1_2('Bob', 'Howdy', 'smoke signal'));
  print(say_1_2('Bob', 'Howdy'));
}

Function makeAdder(int addBy, String name) {
  return (int i) => '${addBy + i} $name';
}

String say1(String from, String msg) {
  var result = '$from says $msg';
  return result;
}

void say_1(String from, String msg) {
  print('$from says $msg');
}

String say_1_1(String from, String msg, [String? device]) {
  var result = '$from says $msg';
  if (device != null) {
    result = '$result with a $device';
  }
  return result;
}
String say_1_2(String from, String msg, [String? device = 'iphone']) {
  var result = '$from says $msg';
  if (device != null) {
    result = '$result with a $device';
  }
  return result;
}
void sayHelloworld(String name) {
  print("$name say hello!");
}

void sayHelloworld_1(String name, {int? age}) {
  print("$name say hello! and age is $age!");
}


void introduce_2({name: 'err', age: 0}) {
  print("$name and $age");
}


// void introduce_10({String name, int age}) {
//   print("$name and $age"); 
// }

void introduce_1({String? name, int? age}) {
  print("$name and $age");
}
void introduce_1_1({String? name='def', int? age}) {
  print("$name and $age");
}

void introduce_1_2({required String? name, int? age}) {
  print("$name and $age"); 
}

