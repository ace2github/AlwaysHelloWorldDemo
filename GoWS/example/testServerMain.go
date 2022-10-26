/*
 * @Description:
 * @Version: 1.0
 * @Author: hui
 * @Date: 2022-09-29 09:36:00
 * @LastEditors: hui
 * @LastEditTime: 2022-09-29 10:38:39
 */
package main

import (
	"example/network"
)

func main() {
	// network.RunUdpServer()
	// network.RunTCPServer()
	network.RunHTTPServer()
}
