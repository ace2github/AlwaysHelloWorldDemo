/*
 * @Descriptio
 * @Version: 1.0
 * @Author: hui
 * @Date: 2022-09-27 15:43:20
 * @LastEditors: hui
 * @LastEditTime: 2022-09-28 13:29:00
 */
package base

import (
	"container/list"
	"fmt"
	"reflect"
	"sync"
)

/******************************************************
 * 容器：数组、切片（slice）、列表(list) 以及 字典（map）
 ******************************************************/
func TestContainerMain() {
	// arrayDemo()
	// sliceDemo()

	// mapDemo()
	// syncMapDemo()
	listDemo()
}

/******************************************************
	数组:
		var varName [count]Type
		var varName = [...]Type{element1, element2, element3} // ... 表示自动类型推导

	Golang 中 数组 与 切片 的区别主要体现在以下几点：
		1、切片是指针类型，数组是值类型
		2、数组的长度是固定的，而切片长度可以任意调整（切片是动态的数组）
		3、数组只有长度一个属性，而切片比数组多了一个容量（cap)属性
		4、切片的底层也是数组实现的
******************************************************/
func arrayDemo() {
	fmt.Println(">>>>>>>>>>>>>>>>>>>>>>>>>")
	var arr [5]int
	fmt.Println(arr)
	fmt.Println("数组长度:", len(arr), "类型：", reflect.TypeOf(arr))

	arr[4] = 100
	fmt.Println("下标获取数组：", arr[4])
	// err：数组越界crash
	// fmt.Println("数组越界：", arr[5])

	// 语法类型2
	b := [5]int{1, 2, 3, 4, 5}
	fmt.Println("int:", b)

	fmt.Println("遍历 - range")
	for index, value := range b {
		fmt.Println(fmt.Sprintf("(%d,%d)", index, value))
	}

	// 定长数组的比较
	fmt.Println("定长数组比较", [3]int{1, 2, 3} == [3]int{2, 3, 1})
	fmt.Println("定长数组比较", [3]int{1, 2, 3} == [3]int{1, 2, 3})

	// 二维数组
	var twoArr [2][3]int
	for i := 0; i < 2; i++ {
		for j := 0; j < 3; j++ {
			twoArr[i][j] = i + j
		}
	}
	fmt.Println("二维数组：", twoArr)
}

/******************************************************
	切片Slice：
		varName := []Type{element1, element2}
		s := make([]type, count)

	在 Go 程序中，相较于数组，用得更多的是 _切片(slice)
	Slice 是 Go 中一个重要的数据类型，它提供了比数组更强大的序列交互方式。

	1、在切片的 index 处添加元素语法：sliceHaiCoder = append(sliceHaiCoder[:index], element)
	2、在切片的开始插入元素：sliceHaiCoder = append([]string{element}, sliceHaiCoder...)
	3、在切片的 index 处添加元素语法：sliceHaiCoder = append(sliceHaiCoder[:index], append([]string{element}, sliceHaiCoder[index:]...)...)
	4、在 index 处插入切片语法：sliceHaiCoder = append(sliceHaiCoder[:index], append(sliceCategory, sliceHaiCoder[index:]...)...)

	1、删除索引 index 处的元素：sliceHaiCoder = append(sliceHaiCoder[:index], sliceHaiCoder[index+1:]...)
	2、删除索引 index 到 index2 处的元素：sliceHaiCoder = append(sliceHaiCoder[:index], sliceHaiCoder[index2:]...)
	3、删除切片的第一个元素语法：sliceHaiCoder = sliceHaiCoder[1:]
	4、删除切片的最后一个元素语法：sliceHaiCoder = sliceHaiCoder[:len(sliceHaiCoder)-1]
	5、删除切片前 N 个元素语法：sliceHaiCoder = sliceHaiCoder[N:]
	6、删除切片后 N 个元素语法：sliceHaiCoder = sliceHaiCoder[:len(sliceHaiCoder)-N]
******************************************************/
func sliceDemo() {
	fmt.Println(">>>>>>>>>>>>>>>>>>>>>>>>>")
	var s0 = make([]string, 0, 2)
	fmt.Printf("Len = %d, Cap = %d\n", len(s0), cap(s0))

	var s = []int{1, 2, 3}
	fmt.Println(s, len(s))

	s[0] = 100
	s[1] = 101
	s[2] = 102
	fmt.Println(s[0])

	// append
	s = append(s, 110)
	s = append(s[:1], 111)
	fmt.Println("append", s)

	fmt.Println("切片：", s[:2])
	fmt.Println("切片：", s[2:])

	// func copy(dst, src []Type) int
	c := make([]int, len(s))
	copy(c, s)
	fmt.Println("copy", c, s)

}

/*****************************************************
 * 内建类型：字典 map
	varName := map[Type1]Type2{}
 	mapName = make(map[keyType]valueType, len)

	在并发读的情况下是线程安全的，如果是在并发写的情况下，则是线程不安全的。
	go提供一个 sync.Map 是并发写安全的。
		var mapName sync.Map
 *****************************************************/
func mapDemo() {
	fmt.Println(">>>>>>>>>>>>>>>>>>>>>>>>>")
	m := make(map[string]int)
	m["k1"] = 1
	m["k2"] = 2
	fmt.Println(m, len(m), reflect.TypeOf(m))

	m["err"] = -1
	fmt.Println(m)
	delete(m, "err")
	fmt.Println("delete", m)

	// 空白标识符_: 可以用来消除 键不存在 和 键的值为零值 产生的歧义
	_, prs := m["k2"]
	fmt.Println(prs)

	val1, prs1 := m["k2"]
	fmt.Println(val1, "是否存在？ ", prs1)

	val2, prs2 := m["k3"]
	fmt.Println(val2, "是否存在？ ", prs2)

	// 直接赋值初始化
	mo := map[string]string{"name": "tom", "sex": "female", "city": "xm", "address": "err"}
	fmt.Println(mo)

	for key, value := range mo {
		fmt.Println("for遍历：", key, "=", value)
	}

	delete(mo, "address")
	fmt.Println(mo)
}

// var mapName sync.Map
func syncMapDemo() {
	fmt.Println(">>>>>>>>>>>>>>>>>>>>>>>>>")
	// 创建
	var smap sync.Map
	smap.Store("name", "tom")
	smap.Store("sex", "male")
	smap.Store("score", 100)
	smap.Store("addr", "err")
	fmt.Println(smap)

	key, value := smap.Load("score")
	fmt.Println("get", key, value)

	smap.Delete("addr")
	k1, v1 := smap.Load("addr")
	fmt.Println("get", k1, v1)
	// printSyncMap(smap)

	// 如果我们获取的 key 存在，那么就返回 key 对应的元素，如果获取的 key 不存在，那么就返回我们设置的值，并且将我们设置的值，存入 map。
	v2, load2 := smap.LoadOrStore("addr", "xm.street.123")
	fmt.Println("LoadOrStore:", v2, load2)
	printSyncMap(smap)

	v3, load3 := smap.LoadAndDelete("addr")
	fmt.Println("LoadAndDelete:", v3, load3)
	printSyncMap(smap)
}
func printSyncMap(sm sync.Map) {
	sm.Range(func(key, value interface{}) bool {
		fmt.Println("range:", key, value)

		// 返回的 bool 结果，true=遍历继续，false=遍历停止。
		return true
	})
}

/******************************************************
	list列表：
	在 Go 语言 中，列表使用 container/list 包来实现，内部的实现原理是”双链表“，列表能够高效地进行任意位置的元素插入和删除操作。
	可以存储任意 数据类型 的值。

	初始化：
		var listName = list.List
		listName := list.New()
******************************************************/
func listDemo() {
	// 初始化
	ll := list.New()

	// push
	ll.PushBack("a")
	ll.PushBack("b")
	ll.PushFront("1")
	el := ll.PushFront("2")
	travelList(*ll, false)
	fmt.Println("len=", ll.Len())

	fmt.Println("val=", el.Value)
	ll.InsertBefore(0, el)
	ll.InsertAfter(3, el)
	travelList(*ll, false)

	l1 := list.New()
	l1.PushBack("c")
	l1.PushBack("d")

	ll.PushBackList(l1)
	ll.PushFrontList(l1)
	travelList(*ll, false)

	ll.Remove(el)
	travelList(*ll, false)

	//
	var l2 list.List
	el1 := l2.PushBack(1)
	el2 := l2.PushBack(2)
	el3 := l2.PushBack(3)
	l2.MoveBefore(el1, el2)
	l2.MoveAfter(el2, el3)
	travelList(l2, false)

	l2.MoveToBack(el3)
	l2.MoveToFront(el1)
	travelList(l2, false)

	// 获取列表头结点语法：Front() *Element
	// 获取列表尾结点语法：Back () *Element
	// 获取上一个结点语法：Prev() *Element
	// 获取下一个结点语法：Next() *Element
}

func travelList(l list.List, reversal bool) {
	fmt.Println()
	if reversal {
		for i := l.Back(); i != nil; i = i.Prev() {
			fmt.Println(i.Value)
		}
	} else {
		for i := l.Front(); i != nil; i = i.Next() {
			fmt.Println(i.Value)
		}
	}
}
