/*
 * @Description:
 * @Version: 1.0
 * @Author: hui
 * @Date: 2022-09-22 11:35:35
 * @LastEditors: hui
 * @LastEditTime: 2022-09-29 11:11:58
 */
package other

import (
	"crypto/sha256"
	"crypto/sha512"
	"encoding/base64"
	"fmt"
)

func TestCryptoMain() {
	// testSHA()
	testBase64()
}

/******************************************************
	1、SHA256/SHA512 散列（hash） 经常用于生成二进制文件或者文本块的短标识。 例如，TLS/SSL 证书使用 SHA256 来计算一个证书的签名。
******************************************************/
func testSHA() {
	fmt.Println("\n\n>>>>>>>>>>>>>>>>>>>>>>")

	oriStr := "hello world!"
	fmt.Println(oriStr)

	h2 := sha256.New()
	h2.Write([]byte(oriStr))

	// Sum 得到最终的散列值的字符切片。Sum 接收一个参数， 可以用来给现有的字符切片追加额外的字节切片：但是一般都不需要这样做。
	b2s := h2.Sum(nil)
	fmt.Printf("SHA256: %x\n", b2s)

	h5 := sha512.New()
	h5.Write([]byte(oriStr))
	b5s := h5.Sum(nil)
	fmt.Printf("SHA512: %x\n", b5s)
}

/******************************************************
	Go 同时支持标准 base64 以及 URL 兼容 base64。
		标准 base64 编码和 URL base64 编码的 编码字符串存在稍许不同（后缀为 + 和 -）， 但是两者都可以正确解码为原始字符串。
******************************************************/
func testBase64() {
	fmt.Println("\n\n>>>>>>>>>>>>>>>>>>>>>>")
	data := "abc123!?$*&()'-=@~"
	fmt.Println("原始：", data)

	sEnc := base64.StdEncoding.EncodeToString([]byte(data))
	fmt.Println("标准base64-编码：", sEnc)

	sDec, _ := base64.StdEncoding.DecodeString(sEnc)
	fmt.Println("标准base64-解码：", string(sDec))
	fmt.Println()

	uEnc := base64.URLEncoding.EncodeToString([]byte(data))
	fmt.Println("URL base64-编码：", uEnc)
	uDec, _ := base64.URLEncoding.DecodeString(uEnc)
	fmt.Println("URL base64-编码：", string(uDec))

}
