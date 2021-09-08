void testFunctionHandler() {
  const list = ['apples', 'bananas', 'oranges'];
  list.forEach((item) {
    print('${list.indexOf(item)}: $item');
  });

  print(say1('xxx', '123456')); //xxx says 123456

  print(say('Bob', 'Howdy')); //Bob says Howdy
  print(say(
      'Bob', 'Howdy', 'smoke signal')); // Bob says Howdy with a smoke signal

  introduce();
  introduce(name: 'john', age: 30);

  introduce_1(); // null null
  introduce_1(name: 'tom', age: 30); // tom 30

  introduce_2(name: 'name');

  var add2 = makeAdder(2, 'aaa');
  var add4 = makeAdder(4, 'bbb');
  print(add2(3)); // 5 aaa
  print(add4(3)); // 7 bbb
}

Function makeAdder(int addBy, String name) {
  return (int i) => '${addBy + i} $name';
}

String say1(String from, String msg) {
  var result = '$from says $msg';
  return result;
}

void say2(String from, String msg) {
  print('$from says $msg');
}

String say(String from, String msg, [String? device]) {
  var result = '$from says $msg';
  if (device != null) {
    result = '$result with a $device';
  }
  return result;
}

void sayHelloworld(String name) {
  print("$name say hello!");
}

void introduce({name: '', age: 0}) {
  print("$name $age");
}

void introduce_1({String? name = 'default', int? age}) {
  print("$name $age");
}

void introduce_2({required String? name, int? age}) {
  print("$name $age");
}
