import 'dart:convert';
import 'dart:io';

void testIODemo() {
  //fileTest();
  //fileStreamHandler();
  //testDirectory();
  
  //testSTD();

  //testProccess();

  testHttp();
}

void fileTest() {
  File file = File('../../resources/test.txt');

  // read all
  file.readAsString().then((value) => {
    print(value)
  });   

  fileLengh(file).then((value) => {
    print('file length: ${value}')
  });
  
  // 文件覆盖写入
  file.writeAsString('new add!!!');
  file.readAsString().then((value) => {
    print(value)
  });
}

void fileStreamHandler(){
  writeLines();

  Future.delayed(Duration(seconds: 5)).then((value) => {
    readLines()
  });  
}

void writeLines() {
  // IOSink
  print('\nStream模式:逐行写入');
  File file = File('../../resources/test.txt');
  var sink = file.openWrite();
  for (int i=1; i< 16; i++) {
    var line = '';
    for (var j = 0; j < i; j++) {
      line += '$j ';
    }
    sink.write('$line \n');
  }
  sink.close();
}


void readLines() {
  print('\nStream模式：逐行读取');
  File file = File('../../resources/test.txt');
  Stream<String> lines = file.openRead().transform(utf8.decoder).transform(LineSplitter());
  try {
    lines.forEach((l) {
      print('$l');
    });

  } catch (e) {
    print('read err: $e');

  } finally {
    print('File is now closed.');
  }
}

Future fileLengh(File file) async {
    return await file.length();
}

void testDirectory() {
  // 创建目录
  Directory('dir/test').create(recursive: true);
  Directory('dir/test').delete(recursive: true);

  var temp = Directory.systemTemp;
  temp.list(recursive: true, followLinks: false).forEach((entity) {
    print(entity.path);
  });
}



///////////////////////////////////////////////////////////////////////////////////////////////////////////////
void testSTD() {
  stdout.write('\nthis is stdout write!');
  stderr.writeAll(['\nthis is ', 'stderr writeall', '!\n']);

  print('\n请输入：');
  var inputText = stdin.readLineSync();
  print(inputText);
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////
void testProccess() async {
  // 执行命令：ls -al
  Process.start('ls', ['-al']).then((process) {
    stdout.addStream(process.stdout);
    stderr.addStream(process.stderr);
    process.exitCode.then(print);
  });

  // 
  var result = await Process.run('grep', ['-i', 'main', 'IODemo.dart']);
  stdout.write(result.stdout);
  stderr.write(result.stderr);
}




///
///
///
///
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
void testHttp(){
  HttpClient client = new HttpClient();
  client.getUrl(Uri.parse("http://www.baidu.com/"))
    .then((HttpClientRequest request) {
      print(request.headers);
      return request.close();
    })
    .then((HttpClientResponse response) {
      response.transform(utf8.decoder).join().then((value) => {
        print('响应数据：\n ${value}')
      });
    });
  client.close();  
}