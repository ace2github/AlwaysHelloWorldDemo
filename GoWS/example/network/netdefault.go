/*
 * @Description:
 * @Version: 1.0
 * @Author: hui
 * @Date: 2022-09-29 09:01:22
 * @LastEditors: hui
 * @LastEditTime: 2022-09-29 09:12:45
 */
package network

import (
	"fmt"
	"os"
)

const (
	ServerIp = "127.0.0.1"
	UDPPort  = 8081
	TCPPort  = 8082
)

func CheckErrAndExit(err error) bool {
	if err != nil {
		fmt.Println("err:", err)
		os.Exit(1)
		return true
	}

	return false
}
