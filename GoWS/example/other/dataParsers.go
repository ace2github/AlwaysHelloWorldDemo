package other

import (
	"bytes"
	"encoding/json"
	"encoding/xml"
	"fmt"
	"math/rand"
	"net"
	"net/url"
	"os"
	"regexp"
	"strconv"
	"time"
)

func TestDataParserMain() {
	fmt.Println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	// testRegexp()
	testJSON()
	// testXML()
	// testNumbers()
	// testConvertNumbersToString()
	// testUrlParser()
}

/******************************************************
 * 数据处理：正则表达式、JSON、XML
 ******************************************************/
func testRegexp() {
	fmt.Println("\n\n>>>>>>>>>>>>>>>>>>>>>>")

	regexpStr := "p([a-z]+)ch"
	match, _ := regexp.MatchString(regexpStr, "peach")
	fmt.Println(match)

	r, _ := regexp.Compile(regexpStr)
	fmt.Println(r.MatchString("peach"))

	// 查找字符串
	fmt.Println("find:", r.FindString("peach punch"))
	fmt.Println("find index:", r.FindStringIndex("peach punch"))

	// Submatch 返回完全匹配和局部匹配的字符串。
	fmt.Println("submatch:", r.FindStringSubmatch("peach punch"))
	fmt.Println("submatch index:", r.FindStringSubmatchIndex("peach punch"))

	// 带 All 的这些函数返回全部的匹配项
	fmt.Println("all -1:", r.FindAllString("peach punch pinch", -1)) // 匹配全部
	fmt.Println("all 2:", r.FindAllString("peach punch pinch", 2))   // 只匹配2次

	fmt.Println("submatch all:", r.FindAllStringSubmatchIndex("peach punch pinch", -1))
	fmt.Println("submatch 2:", r.FindAllStringSubmatchIndex("peach punch pinch", 2))

	// 可以将 String 从函数名中去掉，并提供 []byte 的参数。
	fmt.Println("类型抓换，使用r.Match() ：", r.Match([]byte("peach")))

	// MustCompile 用 panic 代替返回一个错误 ，这样使用全局变量更加安全
	mr := regexp.MustCompile("p([a-z]+)ch")
	fmt.Println("MustCompile():", mr)

	fmt.Println(mr.ReplaceAllString("a peach", "<fruit>"))

	in := []byte("a peach")
	out := mr.ReplaceAllFunc(in, bytes.ToUpper)
	fmt.Println(string(out))

	fmt.Println("main done!")
}

/******************************************************
 * JSON
	解析Json : func Unmarshal(data []byte, v interface{}) error
	结构体转Json : func Marshal(v interface{}) ([]byte, error)
 ******************************************************/
// 注意：只有 可导出 的字段才会被 JSON 编码/解码。必须以大写字母开头的字段才是可导出的。
type jsonData1 struct {
	name   string // 不会被转化为json
	Page   int
	Fruits []string
}

// 自定义json转化后的字段名称
type jsonData2 struct {
	name   string   // 不会被转化为json
	Page   int      `json:"page"`
	Fruits []string `json:"fruits"`
}

func testJSON() {
	fmt.Println("\n\n>>>>>>>>>>>>>>>>>>>>>>")
	/*
	 * JSON编码：json obj -> json string
	 */
	// 基本数据类型到 JSON 字符串的编码过程。
	bolB, _ := json.Marshal(true)
	fmt.Println(string(bolB))

	intB, _ := json.Marshal(100)
	fmt.Println(string(intB))

	fltB, _ := json.Marshal(1.23)
	fmt.Println(string(fltB))

	strB, _ := json.Marshal("gopher")
	fmt.Println(string(strB))

	// 切片和 map 编码成 JSON 数组和对象
	list := []string{"apple", "123", "你好"}
	listB, _ := json.Marshal(list)
	fmt.Println(string(listB))

	dic := map[string]int{"k1": 10, "k2": 3}
	dicB, _ := json.Marshal(dic)
	fmt.Println(string(dicB))

	// JSON 包可以自动的编码你的自定义类型。 编码的输出只包含可导出的字段，并且默认使用字段名作为 JSON 数据的键名。
	res1D := &jsonData1{
		name:   "json_name_1",
		Page:   1,
		Fruits: []string{"apple", "peach", "pear"},
	}
	res1B, _ := json.Marshal(res1D)
	fmt.Println("只有首字母大写才能导出:", string(res1B))

	res2D := &jsonData2{
		name:   "json_name_2",
		Page:   1,
		Fruits: []string{"apple", "peach", "pear"},
	}
	res2B, _ := json.Marshal(res2D)
	fmt.Println("自定义json字段名，首字母小写:", string(res2B))

	/*
	 * JSON解码：json string -> json obj
	 */
	// json格式字符串数据
	jsonStrByt := []byte(`{"num":6.13,"strs":["a","b"]}`)

	// 需要提供一个 JSON 包可以存放解码数据的变量。
	// 这里的 map[string]interface{} 是一个键为 string，值为任意值的 map。
	var dat map[string]interface{}

	if err := json.Unmarshal(jsonStrByt, &dat); err != nil {
		panic(err)
	}
	// 转为字典类型
	fmt.Println("string->字典：", dat)

	// 取值
	fmt.Println(dat["num"].(float64))

	strs := dat["strs"].([]interface{})
	str1 := strs[0].(string)
	fmt.Println(str1)

	/*
	 * 将 JSON 解码为自定义数据类型。
	 */
	stuJsonStr := `{"page":1,"fruits":["apple","peach","pear"]}`
	stuObj := jsonData2{}
	json.Unmarshal([]byte(stuJsonStr), &stuObj)
	fmt.Println("string->自定义结构体jsonData2：", stuObj)
	fmt.Println(stuObj.name, stuObj.Page, stuObj.Fruits)

	/*
	 * 也可以像 os.Stdout 一样直接将 JSON 编码流传输到 os.Writer； 甚至 HTTP 响应体。
	 */
	enc := json.NewEncoder(os.Stdout)
	d := map[string]int{"apple": 5, "lettuce": 7}
	// 转为json，并且输出到stdout中
	enc.Encode(d)
}

/******************************************************
 * XML
 ******************************************************/
// Plant 结构将被映射到 XML 。 与 JSON 示例类似，字段标签包含用于编码器和解码器的指令。
type Plant struct {
	XMLName xml.Name `xml:"plant"`
	Id      int      `xml:"id,attr"`
	Name    string   `xml:"name"`
	Origin  []string `xml:"origin"`
}

func (p Plant) String() string {
	return fmt.Sprintf("Plant id=%v, name=%v, origin=%v", p.Id, p.Name, p.Origin)
}

func testXML() {
	fmt.Println("\n\n>>>>>>>>>>>>>>>>>>>>>>")
	coffee := &Plant{Id: 27, Name: "Coffee"}
	coffee.Origin = []string{"Ethiopia", "Brazil"}

	out, _ := xml.MarshalIndent(coffee, " ", "  ")
	fmt.Println("struct->xml string:\n", string(out))
	// 明确的为输出结果添加一个通用的 XML 头部信息
	fmt.Println(xml.Header + string(out))

	fmt.Println("\n\n>>>>>>>>>>>>>>>>>>>>>>")
	var p Plant
	if err := xml.Unmarshal(out, &p); err != nil {
		panic(err)
	}
	fmt.Println("xml string -> struct:\n", p)

	fmt.Println("\n\n>>>>>>>>>>>>>>>>>>>>>>")
	tomato := &Plant{Id: 81, Name: "Tomato"}
	tomato.Origin = []string{"Mexico", "California"}

	/*
	 * 嵌套
	 */
	// parent>child>plant 字段标签告诉编码器，将 Plants 中的元素嵌套在 <parent><child> 里面。
	type Nesting struct {
		XMLName xml.Name `xml:"nesting"`
		Plants  []*Plant `xml:"parent>child>plant"`
	}

	nesting := &Nesting{}
	nesting.Plants = []*Plant{coffee, tomato}

	out, _ = xml.MarshalIndent(nesting, " ", "  ")
	fmt.Println(string(out))
}

/******************************************************
 * 数字处理
	伪随机数生成器
 ******************************************************/
func testNumbers() {
	/*
	 * 伪随机数生成器
	 */
	fmt.Println("\n\n>>>>>>>>>>>>>>>>>>>>>>")
	// rand.Intn 返回一个随机的整数 n
	fmt.Println("整数随机数：", rand.Intn(100))
	fmt.Println("整数随机数：", rand.Intn(100))
	// 范围：0.0 <= f < 1.0
	fmt.Println("浮点随机数：", rand.Float64())
	// 5.0 <= f < 10.0
	fmt.Println("浮点随机数，范围：5.0 <= f < 10.0")
	fmt.Print((rand.Float64()*5)+5, ",")
	fmt.Print((rand.Float64() * 5) + 5)

	fmt.Println("\n\n>>>>>>>>>>>>>>>>>>>>>>")
	// 默认情况下，给定的种子是确定的，每次都会产生相同的随机数数字序列; 要产生不同的数字序列，需要给定一个不同的种子。
	// 注意，对于想要加密的随机数，使用此方法并不安全， 应该使用 crypto/rand。
	s1 := rand.NewSource(time.Now().UnixNano())
	r1 := rand.New(s1)
	fmt.Println("整数随机数(变化种子)：", r1.Intn(100))
	fmt.Println("整数随机数(变化种子)：", r1.Intn(100))

	// 如果使用相同种子生成的随机数生成器，会生成相同的随机数序列。
	fmt.Println("\n如果使用相同种子生成的随机数生成器，会生成相同的随机数序列。")
	s2 := rand.NewSource(42)
	r2 := rand.New(s2)
	fmt.Println("整数随机数(变化种子)：", r2.Intn(100))
	fmt.Println("整数随机数(变化种子)：", r2.Intn(100))
	fmt.Println()

	s3 := rand.NewSource(42)
	r3 := rand.New(s3)
	fmt.Println("整数随机数(变化种子)：", r3.Intn(100))
	fmt.Println("整数随机数(变化种子)：", r3.Intn(100))
}

/******************************************************
 * 数字 转 字符串
 ******************************************************/
func testConvertNumbersToString() {
	f, _ := strconv.ParseFloat("1.234", 64)
	fmt.Println(f)

	i, _ := strconv.ParseInt("123", 0, 64)
	fmt.Println(i)

	d, _ := strconv.ParseInt("0x1c8", 0, 64)
	fmt.Println(d)

	u, _ := strconv.ParseUint("789", 0, 64)
	fmt.Println(u)

	// Atoi 是一个基础的 10 进制整型数转换函数。
	k, _ := strconv.Atoi("135")
	fmt.Println(k)

	_, e := strconv.Atoi("wat")
	fmt.Println(e)
}

/******************************************************
 * URL解析
 ******************************************************/
func testUrlParser() {
	urlStr := "postgres://user:pass@host.com:5432/path?id=123&k=v#fragmenttest"
	fmt.Println("URL：", urlStr)

	up, err := url.Parse(urlStr)
	if err != nil {
		fmt.Println(err)
	}

	fmt.Println(up.Scheme)

	fmt.Println(up.User)
	fmt.Println(up.User.Password())
	fmt.Println(up.User.Username())

	fmt.Println(up.Host)
	host, port, _ := net.SplitHostPort(up.Host)
	fmt.Println(host, port)

	fmt.Println(up.Fragment)
	fmt.Println(up.Path)

	fmt.Println(up.RawQuery)
	m, _ := url.ParseQuery(up.RawQuery)
	fmt.Println(m)
	fmt.Println(m["k"][0])
}
