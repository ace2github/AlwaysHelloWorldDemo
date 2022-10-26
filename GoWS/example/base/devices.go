/*
 * @Description:
 * @Version: 1.0
 * @Author: hui
 * @Date: 2022-09-26 17:41:46
 * @LastEditors: hui
 * @LastEditTime: 2022-09-26 17:52:19
 */
package base

import "fmt"

func TestDeviceMain() {
	fmt.Println("\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	testScan()
}

/******************************************************
 * 在 Golang 中，获取用户输入的数据使用 fmt.Scanf() 或者 fmt.Scanln()。
 ******************************************************/
func testScan() {
	fmt.Println("\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	var (
		name  string
		age   byte
		score float32
	)
	fmt.Println("请输入姓名、年龄、成绩")
	fmt.Scanf("%s, %d, %f", &name, &age, &score)

	// Scanln
	// fmt.Scanln(&name)
	// fmt.Scanln(&age)
	// fmt.Scanln(&score)

	// print
	fmt.Println("Scanf:", name, age, score)
}
