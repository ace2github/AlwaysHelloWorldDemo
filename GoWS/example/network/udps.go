/*
 * @Description:
 * @Version: 1.0
 * @Author: hui
 * @Date: 2022-09-28 20:13:10
 * @LastEditors: hui
 * @LastEditTime: 2022-09-29 10:02:16
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
func TestNetMain() {
	RunUdpServer()
}

/******************************************************
 *
 ******************************************************/
func RunUdpServer() {
	fmt.Println(">>>>>>>>>>>>>>> run udp server")
	// 1、初始化
	svrAddr := ServerIp + ":" + strconv.Itoa(UDPPort)
	addr, err := net.ResolveUDPAddr("udp", svrAddr)
	if CheckErrAndExit(err) {

	}

	// 2、监听
	conn, err := net.ListenUDP("udp", addr)
	if CheckErrAndExit(err) {

	}
	defer conn.Close()

	for {
		// 数据缓存
		databuffer := make([]byte, 1024)

		// 3、读取数据
		_, handler, err := conn.ReadFromUDP(databuffer)
		if CheckErrAndExit(err) {

		}

		strData := string(databuffer)
		fmt.Println("\nserver recv:", strData)

		// 4、发送数据
		sendStr := strings.ToUpper(strData)
		_, err = conn.WriteToUDP([]byte(sendStr), handler)
		if CheckErrAndExit(err) {

		}
		fmt.Println("server send:", sendStr)
	}
}

func RunUDPClient() {
	fmt.Println(">>>>>>>>>>>>>>> run udp client")

	// 1、初始化
	serverUrl := ServerIp + ":" + strconv.Itoa(UDPPort)
	conn, err := net.Dial("udp", serverUrl)
	if CheckErrAndExit(err) {

	}
	defer conn.Close()

	// 监测输入
	input := bufio.NewScanner(os.Stdin)
	for input.Scan() {
		line := input.Text()
		fmt.Println("\nClient write:", line)

		// 2、与服务器进行读写通信
		if _, err := conn.Write([]byte(line)); err != nil {
			fmt.Println("client write err=", err)
			return
		}

		msg := make([]byte, 1024)
		if _, err := conn.Read(msg); err != nil {
			fmt.Println("client read err=", err)
			return
		}
		fmt.Println("udp response:", string(msg))
		fmt.Println()
	}
}
