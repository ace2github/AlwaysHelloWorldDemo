
void testAsync() {
  Future.delayed(Duration(seconds: 3), (){
    return 'Async: hello';
  }).then((value) => {
    print('then: recv ${value}')
  }).catchError((e){
    print('err: $e');
  }).whenComplete(() => {
    print('finish!')
  });

  Future.wait([
    Future.delayed(Duration(seconds: 3), (){
      return 'Hello';
    }),
    Future.delayed(Duration(seconds: 6), (){
      return ' World';
    })
  ]).then((value) => {
    print('Recv: $value')
  });

  Stream.fromFutures([
    Future.delayed(Duration(seconds: 1), (){
      return 'result 1';
    }),
    Future.delayed(Duration(seconds: 2), (){
      throw AssertionError('sorry!');
    }),
    Future.delayed(Duration(seconds: 3), (){
      return 'result 2';
    })
  ]).listen((event) {
    print('listen: $event');
  }, onError: (e){
    print('err: $e');
  }, onDone: (){
    print('finish!');
  });
}

