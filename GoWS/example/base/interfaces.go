package base

import (
	"fmt"
	"math"
	"reflect"
)

func TestInterfacesMain() {
	fmt.Println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	r := CRect{width: 3, height: 4}
	testInterfaces(r)

	c := CCircle{radius: 6}
	testInterfaces(c)

	testComposition()
}

/******************************************************
 * 接口定义
 ******************************************************/
/*
 * 接口定义
 */
type geometry interface {
	area() float64
	perim() float64
}

/*
 * 结构体定义
 */
type CRect struct {
	width, height float64
}

type CCircle struct {
	radius float64
}

// 结构体方法定义
func (r CRect) area() float64 {
	return r.width * r.height
}
func (r CRect) perim() float64 {
	return 2*r.width + 2*r.height
}

func (c CCircle) area() float64 {
	return math.Pi * c.radius * c.radius
}
func (c CCircle) perim() float64 {
	return 2 * math.Pi * c.radius
}

// 接口测试
func testInterfaces(g geometry) {
	fmt.Println("接口测试：类型=", reflect.TypeOf(g), "变量=", g)
	fmt.Println(g.area())
	fmt.Println(g.perim())
}

/******************************************************
 * 组合composition
 * Go支持对于结构体(struct)和接口(interfaces)的 嵌入(embedding) 以表达一种更加无缝的 组合(composition) 类型
 ******************************************************/
type base struct {
	name string
}

func (p base) describe() {
	fmt.Printf("我的名字 %s \n", p.name)
}

type container struct {
	base
	clsName string
}

type describe interface {
	describe()
}

func testComposition() {
	fmt.Println(">>>>>>>>>>>>>>>>>>>>>>>>>>")
	// 当创建含有嵌入的结构体，必须对嵌入进行显式的初始化；
	t := container{
		base: base{
			name: "Tony",
		},
		clsName: "小学一年级一班",
	}
	fmt.Println(t.clsName)
	fmt.Println(t.name, t.base.name)

	t.base.describe()
	t.describe()

	// 可以使用带有方法的 嵌入结构 来赋予 接口 实现到其他结构上。
	// 因为嵌入了 base ，在这里我们看到 container 也实现了 describer 接口。
	var i = t
	fmt.Println("接口访问：", i.name, i.clsName)
	i.describe()
}
