/*
 * @Description:
 * @Version: 1.0
 * @Author: hui
 * @Date: 2022-09-23 10:33:35
 * @LastEditors: hui
 * @LastEditTime: 2022-09-29 11:34:02
 */
package main

import (
	"cdemo"
	"example/base"
	"example/goes"
	"example/ossys"
	"fmt"
)

func main() {
	fmt.Println("start running .... ")

	// cdemo
	cdemo.TestCDemo()

	// base
	// base.TestBase()
	// base.TestStringsMain()
	// base.TestDeviceMain()
	// base.TestFuncMain()
	// base.TestContainerMain()
	// base.TestStructMain()
	// base.TestInterfacesMain()
	base.TestReflectMain()

	// other.TestTimerMain()
	// other.TestDataParserMain()
	goes.TestProgressMain()

	ossys.TestCommandMain()
}
