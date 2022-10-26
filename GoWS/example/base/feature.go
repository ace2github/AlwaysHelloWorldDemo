/*
 * @Description:
 * @Version: 1.0
 * @Author: hui
 * @Date: 2022-09-21 17:16:37
 * @LastEditors: hui
 * @LastEditTime: 2022-09-29 11:09:29
 */
package base

import (
	"fmt"
	"os"
)

func TestFeatureMain() {
	fmt.Println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	// testPanic()
	// testDefer()
	testRecover()
}

/******************************************************
panic，报错并且程序中断，
	用它来表示程序正常运行中不应该出现的错误， 或者我们不准备优雅处理的错误。

	使用场景：
	1、当函数返回我们不知道如何处理（或不想处理）的错误值时，中止操作。
******************************************************/
func testPanic() {
	// panic("a problem")

	// panic: open tmp/file: no such file or directory
	_, err := os.Create("./tmp/file")
	if err != nil {
		panic(err)
	}

	fmt.Println("main done!")
}

/******************************************************
recover
	Go 通过使用 recover 内置函数，可以从 panic 中 _恢复recover_。 recover 可以阻止 panic 中止程序，并让它继续执行。
******************************************************/
func invokePanic() {
	panic("a problem")
}
func testRecover() {
	defer func() {
		if r := recover(); r != nil {
			fmt.Println("recoverd error:", r)
		}
	}()

	invokePanic()
	fmt.Println("main done!")
}

/******************************************************
	Defer 用于确保程序在执行完成后，会调用某个函数，一般是执行清理工作。 Defer 的用途跟其他语言的 ensure 或 finally 类似。

******************************************************/
func createFile(path string) *os.File {
	fmt.Println("creating file...", path)
	file, err := os.Create(path)
	if err != nil {
		// 更推荐，返回错误信息
		panic("create file err!")
	}

	return file
}

func closeFile(file *os.File) {
	fmt.Println("close file now")
	err := file.Close()
	if err != nil {
		fmt.Printf(os.Stderr.Name(), "error:%v\n", err)
		os.Exit(1)
	}
}

func writeFile(file *os.File, data string) {
	fmt.Println("write file now")
	fmt.Fprintln(file, data)
}

func testDefer() {
	file := createFile("./tmp/defer.txt")
	defer closeFile(file)
	writeFile(file, "123456,helloworld")
	fmt.Println("main done!")
}
