/*
 * @Description:
 * @Version: 1.0
 * @Author: hui
 * @Date: 2022-09-28 20:13:10
 * @LastEditors: hui
 * @LastEditTime: 2022-09-29 10:19:03
 */
package network

import (
	"bufio"
	"fmt"
	"net"
	"os"
	"strconv"
	"strings"
)

/******************************************************
 *
 ******************************************************/
func RunTCPServer() {
	fmt.Println(">>>>>>>>>>>>>>> run tcp server")
	// 1、监听
	svrAddr := ServerIp + ":" + strconv.Itoa(TCPPort)
	listener, err := net.Listen("tcp", svrAddr)
	if CheckErrAndExit(err) {

	}

	for {
		// 数据缓存
		conn, err := listener.Accept()
		if err != nil {
			fmt.Println("server accept err=", err)
			continue
		}
		go tcpSvrTask(conn)
	}
}
func tcpSvrTask(conn net.Conn) {
	defer conn.Close()

	for {
		var buf [1024]byte

		dataLength, err := conn.Read(buf[:])
		if err != nil {
			fmt.Printf("tcp server read err: %v\n", err)
			break
		}
		fmt.Println("tcp server recv:", string(buf[:]), dataLength)

		if _, err := conn.Write([]byte("tcp server proccess success")); err != nil {
			fmt.Println("tcp server write err:", err)
			break
		}
	}
}

func RunTCPClient() {
	fmt.Println(">>>>>>>>>>>>>>> run tcp client")

	// 1、初始化
	serverUrl := ServerIp + ":" + strconv.Itoa(TCPPort)
	conn, err := net.Dial("tcp", serverUrl)
	if CheckErrAndExit(err) {

	}
	defer conn.Close()

	// 监测输入
	input := bufio.NewReader(os.Stdin)
	for {
		line, err := input.ReadString('\n')
		if err != nil {
			fmt.Println("read console err=", err)
			break
		}
		fmt.Println("\nClient write:", line)

		// 如果输入Q，则关闭连接
		trimmInput := strings.TrimSpace(line)
		if trimmInput == "Q" {
			break
		}

		// 2、与服务器进行读写通信
		if _, err := conn.Write([]byte(trimmInput)); err != nil {
			fmt.Println("client write err=", err)
			return
		}

		msg := make([]byte, 1024)
		if _, err := conn.Read(msg); err != nil {
			fmt.Println("client read err=", err)
			return
		}
		fmt.Println("response:", string(msg))
		fmt.Println()
	}
}
