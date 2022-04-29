void class_demo_test() {
    class_demo_2();

  // Point p = new Point(16, 18);
  // print('TEST：${p.runtimeType} ${p.x} ${p.y} ${p.desc}');
  // print('\n');

  // Point p1 = new Point.SomeInfo('hello');
  // print('TEST：${p1.runtimeType} ${p1.x} ${p1.y} ${p1.desc}');
  // print('\n');

  // Person user = Person();
  // user.name = "CCH";
  // print(user.name);
  // print(user.runtimeType);

  // modifyName('test', user);
  // print(user.name);

  // modifyName('hui', user);
  // print(user.name);

  checkVersion();
}

class Pet {
  String? name;
  int weight = 0;
  void saySomething() {
    print('name is $name; weight = $weight');
  }
}
void class_demo_1() {
  var pet = Pet();
  pet.name = "gigi";
  // 1、访问实例属性
  print(pet.name);
  // 2、调用实例方法
  pet.saySomething();
  // 3、对象的类型是：Pet
  print('对象的类型是：${pet.runtimeType}');

  var p2;
  // 3、null，p2为空则返回null
  print(p2?.name);
}


class Point {
  double? x;
  double? y;
  
  Point(this.x, this.y);

  Point.fromJson({x=0, y=0}) {
    this.x = x;
    this.y = y;
  }

  Point.fromMap(Map data) : x=data['x'], y=data['y'] {

  }
}
class Rect extends Point {
  Rect(double x, double y) : super(x, y);

  Rect.fromMap(Map data) : super.fromMap(data) {

  }
}

void class_demo_2() {

  var p3 = Rect(10, 10);
  print("${p3.x}, ${p3.y}");

  var p5 = Rect.fromMap({'x':20.0, 'y':20.0});
  print("${p5.x}, ${p5.y}");

  // var p4 = new Point();
  // print("${p4.x}, ${p4.y}");

  // var p1 = new Point(6, 8);
  // print("${p1.x}, ${p1.y}");

  // var p2 = new Point.fromJson(x:10.0, y: 10.0);
  // print("${p2.x}, ${p2.y}");
  
}



class HelloClass extends Object {
  String? name;
  int age = 0;
}


// class HelloPoint extends Point {
//   double z = 0;

//   HelloPoint(double x, double y) : super(x, y);
// }

void modifyName(String name, Person info) {
  info.name = name;
}

void printString(String name) {
  print(name);
}

void printArray(List arr) {
  for (int i = 0; i < arr.length; i++) {
    print(arr[i]);
  }
}

class Person extends Object {
  String name = '';
}

String lookUpVersion() {
  return '0.0.1';
}
void checkVersion() async {
  var version = await lookUpVersion();
  print(version);
}

Future<int> sumStream(Stream<int> stream) async {
  var sum = 0;
  await for (final value in stream) {
    sum += value;
  }
  return sum;
}

Stream<int> countStream(int to) async* {
  for (int i = 1; i <= to; i++) {
    yield i;
  }
}

Future<void> main() async {
  var stream = countStream(10);
  var sum = await sumStream(stream);
  print(sum); // 55
}

class Todo {
  final String who;
  final String what;

  const Todo(this.who, this.what);
}

@Todo('seth', 'make this do something')
void doSomething() {
  print('do something');
}