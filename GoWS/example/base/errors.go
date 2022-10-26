/*
 * @Description:
 * @Version: 1.0
 * @Author: hui
 * @Date: 2022-09-20 10:52:07
 * @LastEditors: hui
 * @LastEditTime: 2022-09-29 11:09:00
 */
package base

import (
	"errors"
	"fmt"
	"math"
)

func TestErrorMain() {
	fmt.Println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	if result, err := sqrt(-1); err != nil {
		fmt.Println(err)
	} else {
		fmt.Println("sqrt=", result)
	}

	if result, err := sqrt(3); err != nil {
		fmt.Println(err)
	} else {
		fmt.Println("sqrt=", result)
	}

	for _, v := range []int{-1, 0, 1} {
		if r, e := requestSvrApi(v); e != nil {
			fmt.Println("failed:", e)
		} else {
			fmt.Println("worked:", r)
		}
	}
}

/******************************************************
 * 错误处理
 ******************************************************/
func sqrt(f float64) (float64, error) {
	if f < 0 {
		return 0, errors.New("入参为负数")
	}

	return math.Sqrt(f), nil
}

// 自定义err信息
type serverError struct {
	code    int
	message string
}

// 实现Error() string 的错误协议
func (err serverError) Error() string {
	// 格式化字符串：fmt.Sprintf(...)
	return fmt.Sprintf("错误码：%d，错误信息：%s", err.code, err.message)
}

func requestSvrApi(apiCode int) (string, error) {
	if apiCode < 0 {
		return "", serverError{code: -1, message: "请求编码错误"}
	}

	// ...
	return "response data", nil
}
