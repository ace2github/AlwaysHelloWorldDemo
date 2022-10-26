/*
 * @Description:
 * @Version: 1.0
 * @Author: hui
 * @Date: 2022-09-20 09:51:55
 * @LastEditors: hui
 * @LastEditTime: 2022-09-29 11:24:51
 */
package base

import "fmt"

func TestGenericMain() {
	fmt.Println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
}

/******************************************************
 * 泛型
 * 从1.18版本开始，Go添加了对泛型的支持，也即类型参数。
 * https://segmentfault.com/a/1190000041634906
 ******************************************************/

/*
 * T，占位符，类型形参(Type parameter)
 * 类型约束，int|float32|float64
 * 类型形参列表(type parameter list)， [T int|float32|float64 ]
 */
func testGenerics() {
	// // MyMap类型定义了两个类型形参 KEY 和 VALUE。分别为两个形参指定了不同的类型约束
	// // 这个泛型类型的名字叫： MyMap[KEY, VALUE]
	// type MyMap[KEY int | string, VALUE float32 | float64] map[KEY]VALUE

	// // 用类型实参 string 和 flaot64 替换了类型形参 KEY 、 VALUE，泛型类型被实例化为具体的类型：MyMap[string, float64]
	// var a MyMap[string, float64] = map[string]float64{
	// 	"jack_score": 9.6,
	// 	"bob_score":  8.4,
	// }

	// type CSlice[T int|float32|float64] []T
	// var a CSlice[int] = []int{1, 2, 3}
	// fmt.Prin
}
