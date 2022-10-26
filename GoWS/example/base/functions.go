/*
 * @Description:
 * @Version: 1.0
 * @Author: hui
 * @Date: 2022-09-19 16:27:15
 * @LastEditors: hui
 * @LastEditTime: 2022-09-29 11:28:49
 */
package base

import (
	"fmt"
	"time"
)

func TestFuncMain() {
	// fmt.Println(plus(3, 5))
	// fmt.Println(plusThree(2, 3, 1))

	// a, b := vals()
	// fmt.Println("多返回值", a, b)

	// fmt.Println("可变参数，求和=", changeArgs(1, 2, 3))
	// fmt.Println("可变参数，求和=", changeArgs(1, 2, 3, 4, 5, 6))

	// nextInt := initSeq()
	// fmt.Println("匿名函数", nextInt())
	// fmt.Println("匿名函数", nextInt())
	// fmt.Println("匿名函数", nextInt())

	// otherNextInt := initSeq()
	// fmt.Println("匿名函数.新", otherNextInt())

	// fmt.Println("递归函数", fact(7))

	// closureRecursive()

	testFuncRuntimeCounts()
}

/*
 * 关键字 func
 */
func plus(a int, b int) int {
	return a + b
}

// 1、当多个连续的参数为同样类型时， 可以仅声明最后一个参数的类型，忽略之前相同类型参数的类型声明。
func plusThree(a, b, c int) int {
	return a + b + c
}

// 2、多返回值
func vals() (int, int) {
	return 1, 12
}

// 3、可变参数函数
func changeArgs(nums ...int) int {
	fmt.Println("入参：", nums)

	total := 0
	for _, v := range nums {
		total += v
	}
	return total
}

// 4、匿名函数与闭包
func initSeq() func() int {
	i := 0
	return func() int {
		i++
		return i
	}
}

// 5、递归
func fact(n int) int {
	if n == 0 {
		return 1
	}

	return n * fact(n-1)
}

func closureRecursive() {
	var fib func(n int) int

	fib = func(n int) int {
		if n < 2 {
			return 1
		}

		return fib(n-1) + fib(n-2)
	}

	fmt.Println(fib(7))
}

// 测试函数执行时间
func testFuncRuntimeCounts() {
	now := time.Now()
	// do something
	fmt.Println("func run time=", time.Since(now))
}
