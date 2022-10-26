/*
 * @Description:
 * @Version: 1.0
 * @Author: hui
 * @Date: 2022-09-21 16:57:34
 * @LastEditors: hui
 * @LastEditTime: 2022-09-29 11:11:06
 */
package other

import (
	"fmt"
	"sort"
)

func TestSortMain() {
	fmt.Println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	testSort()
	testCustomSort()
}

/******************************************************
 * 排序，sort
	针对内置数据类型
	它是原地排序的，所以他会直接改变给定的切片，而不是返回一个新切片。
 ******************************************************/
func testSort() {
	list := []int{3, 5, 1, 10, 6}
	fmt.Println("未排序：", list)
	sort.Ints(list)
	fmt.Println("已排序：", list, sort.IntsAreSorted(list))

	stringList := []string{"a", "d", "b", "a"}
	fmt.Println("未排序：", stringList)
	sort.Strings(stringList)
	fmt.Println("已排序：", stringList, sort.StringsAreSorted(stringList))
}

/*
 使用函数自定义排序
*/

// 定义新类型
type stringLength []string

// 为 新类型 实现 sort.Interface 接口
// 实现了 sort.Interface 接口的 Len、Less 和 Swap 方法， 这样我们就可以使用 sort 包的通用 Sort 方法了
func (sl stringLength) Len() int {
	return len(sl)
}

// 排序的交换算法
func (sl stringLength) Swap(i, j int) {
	sl[i], sl[j] = sl[j], sl[i]
}

// 按字符串的长度进行排序
func (sl stringLength) Less(i, j int) bool {
	return len(sl[i]) < len(sl[j])
}

func testCustomSort() {
	fruits := []string{"aaaaaaa", "aa", "aaa"}
	fmt.Println(fruits)
	// 强制类型转化为stringLength，以便找到接口
	sort.Sort(stringLength(fruits))
	fmt.Println(fruits)
}
