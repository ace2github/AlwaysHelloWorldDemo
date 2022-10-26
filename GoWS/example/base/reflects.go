/*
 * @Description:
 * @Version: 1.0
 * @Author: hui
 * @Date: 2022-09-28 14:05:51
 * @LastEditors: hui
 * @LastEditTime: 2022-09-28 14:48:54
 */
package base

import (
	"fmt"
	"reflect"
)

/******************************************************
 *
 ******************************************************/
func TestReflectMain() {
	fmt.Println("\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	// reflectBase()
	reflectSlice()
}

/******************************************************
 *
 ******************************************************/
type animate struct {
	name string
}

func reflectBase() {
	fmt.Println("\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	var x = 3.4
	var str = "HaiCoder"
	fmt.Println("x type =", reflect.TypeOf(x), "value=", reflect.ValueOf(x), "pointer=", reflect.ValueOf(&x).Elem())
	fmt.Println("str type =", reflect.TypeOf(str), "value=", reflect.ValueOf(str))

	var ani animate
	ani.name = "bird"
	fmt.Println("struct type = ", reflect.TypeOf(ani), "value=", reflect.ValueOf(ani))

	iv := 100
	if reflect.TypeOf(iv).Kind() == reflect.Int {
		fmt.Println("value=", iv, "is Int type")
	} else {
		fmt.Println("not int")
	}
}

func reflectSlice() {
	var intSlice = []int{256, 512, 1024}
	intSliceElemValue := reflect.ValueOf(&intSlice).Elem()
	if intSliceElemValue.CanSet() {
		newSliceValue := []int{2560, 5120, 10240}
		newVale := reflect.ValueOf(newSliceValue)
		intSliceElemValue.Set(newVale)
		fmt.Println("NewSliceVal =", intSlice)
	}

	var intSlice1 = []int{256, 512, 1024}
	intSliceValue1 := reflect.ValueOf(intSlice1)
	e := intSliceValue1.Index(0)
	if e.CanSet() {
		e.SetInt(2560)
		fmt.Println("NewVal =", intSliceValue1)
	}
}
