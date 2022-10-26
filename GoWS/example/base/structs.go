/*
 * @Description:
 * @Version: 1.0
 * @Author: hui
 * @Date: 2022-09-19 19:39:51
 * @LastEditors: hui
 * @LastEditTime: 2022-09-28 13:37:22
 */
package base

import (
	"fmt"
)

/******************************************************
 *
 ******************************************************/
func TestStructMain() {
	// 结构体允许部分初始化
	fmt.Println(Person{name: "Alice", age: 30})
	fmt.Println(Person{name: "Fred"})

	// 简约模式
	fmt.Println(Person{"Bob", 20})

	// 结构体指针
	fmt.Println("结构体指针")
	fmt.Println(&Person{name: "Ann", age: 40})
	fmt.Println("createPerson", createPerson("Tom"))

	s := Person{name: "Sean", age: 50}
	fmt.Println(". 访问结构体成员", s.name)

	// 可以对结构体指针使用. 指针会被自动解引用。
	sp := &s
	fmt.Println(sp.age)

	sp.age = 51
	fmt.Println(sp.age)

	r := Rect{width: 10, height: 15}
	fmt.Println("结构体Rect ：", r)
	fmt.Println("area:", r.area(), " perim:", r.perim())

	rp := &r
	fmt.Println("area:", rp.area(), " perim:", rp.perim())
}

func createPerson(name string) *Person {
	p := Person{name: name}
	p.age = 100
	return &p
}

// 1、结构体是可变(mutable)的
// 2、Go 支持为结构体类型定义方法(methods)
type Person struct {
	name string
	age  int
}

// 结构体定义
type Rect struct {
	width, height int
}

// 结构体方法
func (r *Rect) area() int {
	return r.width * r.height
}
func (r Rect) perim() int {
	return 2*r.width + 2*r.height
}
