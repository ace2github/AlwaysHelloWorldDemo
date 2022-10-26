package base

import (
	"bytes"
	"fmt"
	"os"
	"strconv"
	s "strings"
	"text/template"
	"unicode/utf8"
)

func TestStringsMain() {
	fmt.Println("\n>>>>>>>>>>>>>>>>>>>>>>>>>")
	// testStrings()
	testStringsApis()
	// testFormatterStr()
	// testStringTemplate()
	// testConverts()
}

/******************************************************
	字符串 转 整形、浮点数
******************************************************/
func testConverts() {
	fmt.Println("int->string", strconv.Itoa(100))
	fmt.Println("int->string fmt", fmt.Sprintf("%d", 999))
	fmt.Println("int->string fmt 十六进制", fmt.Sprintf("%x", 999))

	fmt.Println("int->string 十进制", strconv.FormatInt(20, 10))
	fmt.Println("int->string 十六进制", strconv.FormatInt(20, 16))
	fmt.Println("int->string 二进制", strconv.FormatInt(20, 2))

	fmt.Println("float->string fmt", fmt.Sprintf("%f", 99.9))
	fmt.Println("float->string float32", strconv.FormatFloat(float64(99.9), 'f', 10, 32))
	fmt.Println("float->string float64", strconv.FormatFloat(float64(99.9), 'f', 10, 64))

	if val, err := strconv.Atoi("99"); err != nil {
		fmt.Println(err)
	} else {
		fmt.Println("string->int", val)
	}

	if val, err := strconv.ParseInt("99", 10, 64); err != nil {
		fmt.Println(err)
	} else {
		fmt.Println("string->int 十进制", val)
	}

	if val, err := strconv.ParseInt("101", 2, 64); err != nil {
		fmt.Println(err)
	} else {
		fmt.Println("string->int 二进制", val)
	}

	if val, err := strconv.ParseFloat("16.8", 64); err != nil {
		fmt.Println(err)
	} else {
		fmt.Println("string->float", val)
	}
}

/******************************************************
	字节：
	在Go语言当中，字符的概念被称为 rune - 它是一个表示 Unicode 编码的整数。
******************************************************/
func testStrings() {
	fmt.Println("字符串>>>>>>>>>>>>>>>>>>>>>>>")
	s := "สวัสดี"
	fmt.Println("字符串长度", len(s))

	for i := 0; i < len(s); i++ {
		fmt.Printf("%x ", s[i])
	}

	fmt.Println("\n", "Rune count:", utf8.RuneCountInString(s))

	for idx, runeValue := range s {
		fmt.Printf("%#U starts at %d\n", runeValue, idx)
	}

	fmt.Println("\nUsing DecodeRuneInString")
	for i, w := 0, 0; i < len(s); i += w {
		runeValue, width := utf8.DecodeRuneInString(s[i:])
		fmt.Printf("%#U starts at %d\n", runeValue, i)
		w = width

		examineRune(runeValue)
	}
}

func examineRune(r rune) {
	if r == 't' {
		fmt.Println("found tee")
	} else if r == 'ส' {
		fmt.Println("found so sua")
	}
}

/******************************************************
 * string常用apis
 ******************************************************/
var p = fmt.Println

func testStringsApis() {
	fmt.Println("\n\n字符串>>>>>>>>>>>>>>>>>>>>>>>")
	p("Contains:  ", s.Contains("test", "es"))

	// 在 Go 语言 中要想获取 字符串 长度有四种方法，分别为：使用 bytes.Count() 获取、使用 strings.Count() 获取、使用 len() 获取和使用 utf8.RuneCountInString() 获取。
	p()
	p("字符串出现的个数:", s.Count("test", "t"))
	p("len:", len("test"))
	p("len:", utf8.RuneCountInString("test"))
	p("字符个数:", bytes.Count([]byte("test"), nil))

	p()
	p("HasPrefix: ", s.HasPrefix("test", "te"))
	p("HasSuffix: ", s.HasSuffix("test", "st"))

	p()
	// 不存在，找不到 则返回-1
	p("Index:     ", s.Index("test", "e"))
	p("LaseIndex:", s.LastIndex("test", "e"))
	str := "I love Golang and I study Golang"
	p("IndexAny", s.IndexAny(str, "o"))
	p("LastIndexAny", s.LastIndexAny(str, "o"))

	p("Join:      ", s.Join([]string{"a", "b"}, "-"))
	p("Join:", "hello "+"world")
	p("Join:", fmt.Sprintf("%s%d%s", "a", 1, "b"))
	// buffer.WriteString 拼接字符串的性能远远低于以上，不推荐
	var buffer bytes.Buffer
	buffer.WriteString("i`am")
	buffer.WriteString(" hui!")
	p("Join:", buffer.String())

	p()
	p("Repeat:    ", s.Repeat("a", 5))
	p("Replace:   ", s.Replace("fooox", "o", "0", 1))

	p("ReplaceAll:   ", s.ReplaceAll("fooox", "o", "0"))
	p("Replace:   ", s.Replace("fooox", "o", "0", -1))

	p()
	p("Fields(按空格分割):", s.Fields("hello world"))
	p("Split(按字符串分割):     ", s.Split("a-b-c-d-e", "-"))
	valus := s.FieldsFunc("hello world", func(r rune) bool {
		if r > 'h' {
			return true
		} else {
			return false
		}
	})
	p("FieldsFunc(按字符遍历分割):     ", valus, len(valus))

	p("ToLower:   ", s.ToLower("TEST"))
	p("ToUpper:   ", s.ToUpper("test"))
	p("Title:首字母大写", s.ToTitle("hello world"))
	p("TrimSpace 去除左右两边的空格:", s.TrimSpace(" h ll o w o rd "))
	p("Trim 去除左右两边指定字符串:", s.Trim(" h ll o w o rd ", " "))
	p()

	p("Len: ", len("hello"))

	// string[index]
	p("Char:", "hello"[1])

	// string[start : end]
	p("sub:", "hello world"[5:])

	mapStr := s.Map(func(r rune) rune {
		return r + 1
	}, "helloworld")
	p("Map 字符串遍历处理:", mapStr)

	p()
	p("a==a", "a" == "b")
	p("Compare:", s.Compare("a", "b"))
	// 该函数比较字符串大小是忽略大小写的。
	p("EqualFold:", s.EqualFold("a", "A"))
}

/******************************************************
 * 格式化字符串
 ******************************************************/
type point struct {
	x, y int
}

func testFormatterStr() {
	fmt.Println("\n\n字符串>>>>>>>>>>>>>>>>>>>>>>>")

	//  Printf， 它通过 os.Stdout 输出格式化的字符串
	p := point{1, 2}

	fmt.Printf("struct1: %v\n", p)
	// 如果值是一个结构体，%+v 的格式化输出内容将包括结构体的字段名。
	fmt.Printf("struct2: %+v\n", p)
	// %#v 根据 Go 语法输出值，即会产生该值的源码片段。
	fmt.Printf("struct3: %#v\n", p)

	// 需要打印值的类型，使用 %T。
	fmt.Printf("type: %T\n", p)
	// 格式化布尔值
	fmt.Printf("bool: %t\n", true)

	fmt.Printf("int: %d\n", 123)

	// 输出二进制表示形式。
	fmt.Printf("bin: %b\n", 14)

	// 输出给定整数的对应字符。
	fmt.Printf("char: %c\n", 33)

	// %x 提供了十六进制编码。
	fmt.Printf("hex: %x\n", 456)

	fmt.Printf("float1: %f\n", 78.9)

	// %e 和 %E 将浮点型格式化为（稍微有一点不同的）科学记数法表示形式。
	fmt.Printf("float2: %e\n", 123400000.0)
	fmt.Printf("float3: %E\n", 123400000.0)

	// %s 进行基本的字符串输出。
	fmt.Printf("str1: %s\n", "\"string\"")

	// 像 Go 源代码中那样带有双引号的输出，使用 %q。
	fmt.Printf("str2: %q\n", "\"string\"")

	fmt.Printf("str3: %x\n", "hex this")
	fmt.Printf("pointer: %p\n", &p)

	// 控制输出的精度
	fmt.Printf("width1: |%6d|%6d|\n", 12, 345)
	fmt.Printf("width2: |%6.2f|%6.2f|\n", 1.2, 3.45)

	// 要左对齐，使用 - 标志。
	fmt.Printf("width3: |%-6.2f|%-6.2f|\n", 1.2, 3.45)
	fmt.Printf("width4: |%6s|%6s|\n", "foo", "b")
	fmt.Printf("width5: |%-6s|%-6s|\n", "foo", "b")

	// Sprintf 则格式化并返回一个字符串而没有任何输出
	s := fmt.Sprintf("sprintf: a %s", "string")
	fmt.Println(s)

	fmt.Fprintf(os.Stderr, "io: an %s\n", "error")
}

/******************************************************
	Go 使用 text/template 包为创建动态内容或向用户显示自定义输出提供了内置支持。
	一个名为 html/template 的兄弟软件包提供了相同的 API，但具有额外的安全功能，被用于生成 HTML。
 ******************************************************/
func testStringTemplate() {
	fmt.Println("\n\n>>>>>>>>>>>>>>>>>>>>>>>")
	t1 := template.New("t1")
	t1, err := t1.Parse("Value is {{.}}\n")
	if err != nil {
		panic(err)
	}

	t1 = template.Must(t1.Parse("Value: {{.}}\n"))

	// {{.}} 动作被作为参数传递给 Execute 的值所代替。
	t1.Execute(os.Stdout, "some text")
	t1.Execute(os.Stdout, 5)
	t1.Execute(os.Stdout, []string{
		"Go",
		"Rust",
		"C++",
		"C#",
	})

	Create := func(name, t string) *template.Template {
		return template.Must(template.New(name).Parse(t))
	}

	// 如果数据是一个结构体，可以使用 {{.FieldName}} 动作来访问其字段。 这些字段应该是导出的，以便在模板执行时可访问。
	t2 := Create("t2", "Name: {{.Name}}\n")
	t2.Execute(os.Stdout, struct {
		Name string
	}{"Jane Doe"})

	// 同样适用于 map；在 map 中没有限制键名的大小写。
	t2.Execute(os.Stdout, map[string]string{
		"Name": "Mickey Mouse",
	})

	// if/else 提供了条件执行模板。如果一个值是类型的默认值，例如 0、空字符串、空指针等， 则该值被认为是 false。
	t3 := Create("t3",
		"{{if . -}} yes {{else -}} no {{end}}\n")
	t3.Execute(os.Stdout, "not empty")
	t3.Execute(os.Stdout, "")

	// range 块允许我们遍历切片，数组，映射或通道。在 range 块内，{{.}} 动作被设置为迭代的当前项。
	t4 := Create("t4",
		"Range: {{range .}}{{.}} {{end}}\n")
	t4.Execute(os.Stdout,
		[]string{
			"Go",
			"Rust",
			"C++",
			"C#",
		})
}
