package base

import (
	"fmt"
	"math"
	"time"
)

func TestBase() {
	fmt.Println(" >>>> base test >>>>")
	// values()
	// variable()
	// constant()

	// ifelseswitch()

	// loopFor()
	rangeDemo()

	// pointer()
}

/******************************************************
	指针：通过 引用传递 来传递值和数据结构
******************************************************/
func pointer() {
	fmt.Println(">>>>>>>>>>>>>>>>>>>>>>>>>")

	i := 10
	fmt.Println("原始值", i)

	zeroval(i)
	fmt.Println("zeroval", i)

	zeroptr(&i)
	fmt.Println("zeroptr", i)
	fmt.Println("pointer:", &i)
}
func zeroval(ival int) {
	ival = 0
}
func zeroptr(iptr *int) {
	*iptr = 0
}

/******************************************************
	键值循环forrange 类似于其他语言中的 foreach 语句
		在 Go 语言里面，键值循环可以用来遍历 字符串、数组、切片、map 以及 channel 等。
******************************************************/
func rangeDemo() {
	fmt.Println(">>>>>>>>>>>>>>>>>>>>>>>>>")
	nums := []int{2, 3, 4}
	sum := 0
	for i, v := range nums {
		sum += v
		fmt.Println("index=", i, "value=", v)
	}
	fmt.Println("sum=", sum)

	kvs := map[string]string{"a": "apple", "b": "banana"}
	for k, v := range kvs {
		fmt.Printf("key,value = %s -> %s", k, v)
	}

	for i, c := range "HelloWorld" {
		fmt.Println("index=", i, "value=", c)
	}
}

/******************************************************
	数值
******************************************************/
func values() {
	fmt.Println(">>>>>>>>>>>>>>>>>>>>>>>>>")
	fmt.Println("hello world!")

	fmt.Println("go" + "lang")
	fmt.Println("1+1=", 1+1)
	fmt.Println("7.0/3.0=", 7.0/3.0)
	fmt.Println(true && false)
	fmt.Println(true || false)
	fmt.Println(!true)
}

/******************************************************
	变量
******************************************************/
func variable() {
	fmt.Println(">>>>>>>>>>>>>>>>>>>>>>>>>")
	var a = "你好"
	fmt.Println(a)

	var b, c int = 1, 11
	fmt.Println(b, c)

	var d = true
	fmt.Println(d)

	var e int
	fmt.Println(e)

	f := "short"
	fmt.Println(f)
}

/******************************************************
	常量、常量初始化器itoa
******************************************************/
// Go 支持字符、字符串、布尔和数值 常量 。
const sc string = "constant"

// 批量定义
const (
	e  = 2.7182818
	pi = 3.15169
)

func constant() {
	fmt.Println("\n>>>>>>>>>>>>>>>>>>>>>>>>>")
	fmt.Println(sc)

	const n = 500000000
	const d = 3e20 / n
	fmt.Println(d)
	fmt.Println(int64(d))
	fmt.Println(math.Sin(n))

	fmt.Println("e=", e, " pi=", pi)

	/*
	 * Go 语言常量(iota)生成器用于生成一组以相似规则初始化的常量，但是不用每行都写一遍初始化表达式。
	 */
	type iWeekday int
	const (
		iSunday iWeekday = iota
		iMonday
		iTuesday
		iWednesday
		iThursday
		iFriday
		iSaturday
	)
	fmt.Println("Sunday = ", iSunday, "Monday = ", iMonday, "Friday =", iFriday)
}

/******************************************************
	循环
******************************************************/
func loopFor() {
	fmt.Println(">>>>>>>>>>>>>>>>>>>>>>>>>")
	i := 1
	for i < 6 {
		fmt.Println(i)
		i += 1
	}

	for j := 0; j < 6; j++ {
		fmt.Println(j)
	}

	for {
		fmt.Println("loop forever")
		break
	}

	for n := 0; n < 5; n++ {
		if n%2 == 0 {
			continue
		}

		fmt.Println(n)
	}
}

/******************************************************
	条件控制器
******************************************************/
func ifelseswitch() {
	fmt.Println(">>>>>>>>>>>>>>>>>>>>>>>>>")
	if 7%2 == 0 {
		fmt.Println("7 is even")
	} else {
		fmt.Println("7 is odd")
	}

	if num := 9; num < 0 {
		fmt.Println(num, "is negative")
	} else if num < 10 {
		fmt.Println(num, "is 1 digit")
	} else {
		fmt.Println(num, "is multiple digit")
	}

	i := 2
	fmt.Println("write ", i, "as ")
	switch i {
	case 1:
		fmt.Println("one")
	case 2:
		fmt.Println("two")
	case 3:
		fmt.Println("three")
	}

	var t = time.Now()
	fmt.Println(t)
	// 使用逗号来分隔多个表达式
	switch t.Weekday() {
	case time.Saturday, time.Sunday:
		fmt.Println("It's the weekend")
	default:
		fmt.Println("It's a weekday")
	}

	//不带表达式的 switch 是实现 if/else 逻辑的另一种方式。
	switch {
	case t.Hour() < 12:
		fmt.Println("It's before noon")
	default:
		fmt.Println("It's after noon")
	}

	// 类型开关 (type switch)
	whatAmI := func(i interface{}) {
		switch t := i.(type) {
		case bool:
			fmt.Println("I'am a bool")
		case int:
			fmt.Println("I'am a bool")
		default:
			fmt.Printf("Don't know type %T\n", t)
		}
	}
	whatAmI(true)
	whatAmI(100)
	whatAmI("name")
}
