package ossys

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"path/filepath"
	"strings"
)

func TestFilesMain() {
	testFloderComponents()
	testDir()
	testReadFiles()
	testWriteFiles()
}

func checkErr(err error) bool {
	if err != nil {
		fmt.Println("error", err)
		return false
	}

	return true
}

/******************************************************
 *
 ******************************************************/
// fmt.Println("\n\n>>>>>>>>>>>>>>>>>>>>>>")
func testFloderComponents() {
	fmt.Println("\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	path := filepath.Join("dir1", "dir2", "dir3", "filename")
	fmt.Println(path)

	// 删除多余的分隔符和目录，使得路径更加规范。
	fmt.Println(filepath.Join("dir//", "filename"))
	fmt.Println(filepath.Join("dir1/...dir1", "filename"))

	fmt.Println("Dir", filepath.Dir(path))   // 返回目录
	fmt.Println("Base", filepath.Base(path)) // 返回文件

	// 判断路径是否为绝对路径。
	fmt.Println("是否为决定路径？", "dir/file")
	fmt.Println("是否为决定路径？", "/dir/file")

	filename := "config.json"
	ext := filepath.Ext(filename)
	fmt.Println("ext", ext)
	fmt.Println("文件名", strings.TrimSuffix(filename, ext))

	// Rel 寻找 basepath 与 targpath 之间的相对路径。
	rel, err := filepath.Rel("a/b", "a/b/t/file")
	if err != nil {
		fmt.Println(err)
	}
	fmt.Println("Rel()", rel)

	rel, err = filepath.Rel("a/b", "a/c/t/file")
	if err != nil {
		fmt.Println(err)
	}
	fmt.Println("Rel()", rel)
}

/******************************************************
 *
 ******************************************************/
func readAndPrintDir(path string) {
	dirs, err := os.ReadDir(path)
	checkErr(err)
	for _, entry := range dirs {
		fmt.Println(entry.Name(), entry.IsDir())
	}
}

func visit(p string, info os.FileInfo, err error) error {
	if err != nil {
		return err
	}
	fmt.Println(" ", p, info.IsDir())
	return nil
}
func testDir() {
	fmt.Println("\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	path := "./tmp/"
	// 如果目标已经存在会报错
	err := os.Mkdir(path, 0755)
	checkErr(err)
	// defer os.RemoveAll(path)

	// 一个用于创建临时文件的帮助函数
	createEmptyTempFile := func(name string) {
		checkErr(os.WriteFile(name, []byte(""), 0644))
	}
	createEmptyTempFile(filepath.Join(path, "file"))

	// 创建一个有层级的目录，使用 MkdirAll 函数，并包含其父目录。 这个类似于命令 mkdir -p。
	checkErr(os.MkdirAll(filepath.Join(path, "parent", "child"), 0755))

	createEmptyTempFile(filepath.Join(path, "parent", "file2"))
	createEmptyTempFile(filepath.Join(path, "parent", "file3"))
	createEmptyTempFile(filepath.Join(path, "parent", "child/file4"))

	fmt.Println("\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	// ReadDir 列出目录的内容，返回一个 os.DirEntry 类型的切片对象。
	readAndPrintDir(path)

	// Chdir 可以修改当前工作目录
	err = os.Chdir(filepath.Join(path, "parent"))
	checkErr(err)
	readAndPrintDir(".")

	fmt.Println("\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	//遍历一个目录及其所有子目录。
	fmt.Println(">>>>>walk<<<<<<")
	err = filepath.Walk(".", visit)

	fmt.Println("\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	/*
	 * 创建临时文件
	 */
	fmt.Println("\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	// os.CreateTemp 创建临时文件
	tmpfile, err := os.CreateTemp("", "sample.t")
	checkErr(err)
	defer os.Remove(tmpfile.Name())
	fmt.Println("临时文件", tmpfile.Name())

	// os.MkdirTemp 创建临时目录
	tmpfloder, err := os.MkdirTemp("", "sampledir")
	checkErr(err)
	fmt.Println("临时文件目录:", tmpfloder)
	defer os.RemoveAll(tmpfloder)

	fmt.Println("main done!")
}

/******************************************************
 * bufio 、 io 、 os
 ******************************************************/
func testReadFiles() {
	fmt.Println("\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	path := "./tmp"
	file, err := os.ReadFile(filepath.Join(path, "file"))
	if checkErr(err) {
		fmt.Println(string(file))
	}

	// open
	fo, err := os.Open(filepath.Join(path, "file"))
	defer fo.Close()

	if !checkErr(err) {
		return
	}

	buffer := make([]byte, 3)
	len1, err := fo.Read(buffer)
	if checkErr(err) {
		fmt.Printf("%d bytes: %s\n", len1, string(buffer[:len1]))
	}

	fmt.Println("\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	seeko, err := fo.Seek(int64(len1), 0)
	if checkErr(err) {
		fmt.Println("seek", seeko)

		buffer := make([]byte, 3)
		len1, err := fo.Read(buffer)
		if checkErr(err) {
			fmt.Printf("seek :: %d bytes: %s\n", len1, string(buffer[:len1]))
		}
	}

	fmt.Println("\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	// io 包提供了一个更健壮的实现 ReadAtLeast
	buffer3 := make([]byte, 2)
	fo.Seek(0, 0)
	len3, err := io.ReadAtLeast(fo, buffer3, 2)
	if checkErr(err) {
		fmt.Printf("io.ReadAtLeast() :: %d bytes: %s\n", len3, string(buffer3))
	}

	// bufio 包实现了一个缓冲读取器，这可能有助于提高许多小读操作的效率，以及它提供了很多附加的读取函数。
	fmt.Println("\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	fo.Seek(0, 0)
	r4 := bufio.NewReader(fo)
	b4, err := r4.Peek(5)
	if checkErr(err) {
		fmt.Printf("bufio.NewReader :: 5 bytes: %s\n", string(b4))
	}

}

func testWriteFiles() {
	// path := "./tmp/"
	// filename := filepath.Join(path, "")

	// var file os.File
	// if exsit := os.w(filename); !exsit {
	// 	file
	// }
}
