/*
 * @Description:
 * @Version: 1.0
 * @Author: hui
 * @Date: 2022-09-28 20:13:10
 * @LastEditors: hui
 * @LastEditTime: 2022-09-29 14:03:42
 */
package network

import (
	"bufio"
	"fmt"
	"io"
	"net/http"
	"time"
)

/******************************************************
 *
 ******************************************************/

/*
 * context.Context
	context.Context 被用于控制 cancel。 Context 跨 API 边界和协程携带了：deadline、取消信号以及其他请求范围的值。
*/
func cxtAction(w http.ResponseWriter, req *http.Request) {
	fmt.Fprintf(w, "context\n")
	// net/http 机制为每个请求创建了一个 context.Context， 并且可以通过 Context() 方法获取并使用它。
	cxt := req.Context()
	fmt.Println("server: context handler started")
	defer fmt.Println("server: context handler ended")

	select {
	case <-time.After(10 * time.Second):
		fmt.Fprintf(w, "context timeout.\n")
	case <-cxt.Done():
		// 收到 .Done() 通道的信号，表明我们应该取消工作并尽快返回。
		// 该错误说明了 Done 通道关闭的原因。
		err := cxt.Err()
		fmt.Println("server:", err)

		internalError := http.StatusInternalServerError
		http.Error(w, err.Error(), internalError)
	}
}

func hello(w http.ResponseWriter, req *http.Request) {
	fmt.Fprintf(w, "hello\n")
}

func headers(w http.ResponseWriter, req *http.Request) {
	for name, headers := range req.Header {
		for _, h := range headers {
			fmt.Fprintf(w, "%v: %v\n", name, h)
		}
	}
}
func RunHTTPServer() {
	fmt.Println(">>>>>>>>>>>>>>> run http server")
	http.HandleFunc("/hello", hello)
	http.HandleFunc("/context", cxtAction)
	http.HandleFunc("/header", headers)

	// 监听地址，本机地址，端口
	url := ":9090"
	http.ListenAndServe(url, nil)

	// 终端输入：curl localhost:9090/hello
}

/******************************************************
	官网API文档：https://pkg.go.dev/net/http

 	resp, err := http.Get("http://example.com/")
	...
	resp, err := http.Post("http://example.com/upload", "image/jpeg", &buf)
	...
	resp, err := http.PostForm("http://example.com/form", url.Values{"key": {"Value"}, "id": {"123"}})
 ******************************************************/
func RunHTTPClient() {
	fmt.Println(">>>>>>>>>>>>>>> run http client")

	response, err := http.Get("http://www.baidu.com")
	if err != nil {
		fmt.Println("http get err=", err)
	}
	defer response.Body.Close()

	fmt.Println("status=", response.Status)
	// readResponseWithScanner(*response)
	readResponseWithIO(*response)
}

func readResponseWithScanner(resp http.Response) {
	// 打印响应的前面五行
	scanner := bufio.NewScanner(resp.Body)
	for i := 0; scanner.Scan() && i < 5; i++ {
		fmt.Println(scanner.Text())
	}
	if err := scanner.Err(); err != nil {
		panic(err)
	}
}

func readResponseWithIO(resp http.Response) {
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		fmt.Println("err:", err)
	}
	fmt.Println("response:\n", string(body))
}
