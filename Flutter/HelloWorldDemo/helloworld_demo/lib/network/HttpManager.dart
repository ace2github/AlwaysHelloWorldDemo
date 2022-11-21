import 'package:dio/dio.dart';
import 'package:helloworld_demo/network/NetworkConfig.dart';

class HttpManager {
  static final BaseOptions _baseOptions = BaseOptions(
      baseUrl: HttpConfig.baseUrl, connectTimeout: HttpConfig.timeout);
  static final _dio = Dio(_baseOptions);

  static Future<T> request<T>(String uri,
      {String method = HttpMethods.get,
      Map<String, dynamic>? params,
      Interceptor? inter}) async {
    /*
    * 1、构建请求配置
    */
    final copts = Options(method: method);

    // 地址拼接
    String realUrl = HttpConfig.realUrl(uri);

    /*
    * 2、添加第一个拦截器
    */
    Interceptor defInter = InterceptorsWrapper(
      onRequest: (requestOpts, handler) {
        // 1.在进行任何网络请求的时候, 可以添加一个loading显示

        // 2.很多页面的访问必须要求携带Token,那么就可以在这里判断是有Token

        // 3.对参数进行一些处理,比如序列化处理等
        print("拦截了请求");
        return handler.next(requestOpts);
      },
      onResponse: (response, handler) {
        print("拦截了响应");
        return handler.next(response);
      },
      onError: (e, handler) {
        print("request err! ${e}");
        return handler.next(e);
      },
    );

    // 添加拦截器
    List<Interceptor> interList = [defInter];
    if (inter != null) {
      interList.add(inter);
    }
    _dio.interceptors.addAll(interList);

    // 3、开始请求
    try {
      Response response = await _dio.request<T>(realUrl,
          queryParameters: params, options: copts);
      return response.data;
    } on DioError catch (e) {
      return Future.error(e);
    }
  }
}
