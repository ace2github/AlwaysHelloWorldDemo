/*
 * @Description:
 * @Version: 1.0
 * @Author: hui
 * @Date: 2022-09-22 13:18:09
 * @LastEditors: hui
 * @LastEditTime: 2022-09-29 13:45:50
 */
package ossys

import (
	"flag"
	"fmt"
	"os"
	"strings"
)

func TestCommandMain() {
	fmt.Println("\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	// testSysCmdArgs()
	// testSysCmdFlag()
	// testSysSubCmd()
	testSysCmdEnv()
}

/******************************************************
 *
 ******************************************************/
// fmt.Println("\n\n>>>>>>>>>>>>>>>>>>>>>>")
/**
 * @description: 获取命令行参数
	os.Args
 	flag 包提供的方式更为灵活，可以通过 key 和 value 的形式来获取。
 * @return {*}
 * @author: hui
*/
func testSysCmdArgs() {
	args := os.Args
	for i := 0; i < len(args); i++ {
		fmt.Println("参数", i, "=", args[i])
	}
}

func testSysCmdFlag() {
	// flag 包
	var (
		user     string
		password *string
		env      int
		port     *int
	)
	flag.StringVar(&user, "u", "", "账号")
	password = flag.String("p", "", "密码")

	flag.IntVar(&env, "env", 1, "环境")
	port = flag.Int("port", 3306, "端口")

	// 所有标志都声明完成以后，必须调用 flag.Parse() 来执行命令行解析。
	flag.Parse()

	fmt.Println(user, *password, env, *port)
}

/**
 * @description:
 	go 和 git 这种命令行工具，都有很多的 子命令 。 并且每个工具都有一套自己的 flag，比如： go build 和 go get 是 go 里面的两个不同的子命令。
	flag.NewFlagSet 轻松实现该功能
 * @return {*}
 * @author: hui
*/
func testSysSubCmd() {
	// 子命令 foo
	fooCmg := flag.NewFlagSet("foo", flag.ExitOnError)
	var (
		enableVal bool
		name      string
	)
	fooCmg.BoolVar(&enableVal, "enable", false, "开关")
	fooCmg.StringVar(&name, "name", "", "姓名")

	// 子命令 bar
	barCmd := flag.NewFlagSet("bar", flag.ExitOnError)
	barLevel := barCmd.Int("level", 0, "等级")

	if len(os.Args) < 2 {
		fmt.Println("expected 'foo' or 'bar' subcommands")
		os.Exit(-1)
	}

	switch os.Args[1] {
	case "foo":
		fooCmg.Parse(os.Args[2:])
		fmt.Println("subcmd foo:: name=", name, "enable=", enableVal)
		fmt.Println("other", fooCmg.Args())
	case "bar":
		barCmd.Parse(os.Args[2:])
		fmt.Println("subcmd bar:: level=", *barLevel)
		fmt.Println("other", barCmd.Args())
	default:
		fmt.Println("expected 'foo' or 'bar' subcommands")
		os.Exit(1)
	}
}

/**
 * @description: 获取和设置系统的环境变量
 * @return {*}
 * @author: hui
 */
func testSysCmdEnv() {
	name := "Hui"
	os.Setenv(name, "101")
	if val, exsit := os.LookupEnv(name); exsit {
		fmt.Println("LoolupEnv:", name, "=", val)
		fmt.Println("Getenv:", name, "=", os.Getenv(name))
	}
	os.Unsetenv(name)
	fmt.Println("Unsetenv:", name, "(get)=", os.Getenv(name))

	// 获取全部环境变量
	// getAllEnvs()
}

func getAllEnvs() {
	// os.Environ()，返回一个 KEY=value 形式的字符串切片
	for _, e := range os.Environ() {
		pair := strings.SplitN(e, "=", 2)
		fmt.Println(pair)
	}
}
