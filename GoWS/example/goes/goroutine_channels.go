package goes

import (
	"errors"
	"fmt"
	"math/rand"
	"sync"
	"sync/atomic"
	"time"
)

/******************************************************
 * 协程(goroutine) ，轻量级的执行线程。
 		关键字go funcTask，如果程序退出，对应的协程也一并结束
		goroutine在逻辑处理器上执行，逻辑处理器具有独立的系统线程和运行队列
		并发执行，并发是指goroutine之间相互独立的运行
 ******************************************************/
func task(from string) {
	for i := 0; i < 3; i++ {
		fmt.Println(from, ":", i)
		time.Sleep(time.Second)
	}
}
func TestGoroutineTask() {
	// 并发执行：首先会看到阻塞式调用的输出，然后是两个协程的交替输出。
	task("直接调用")

	go task("协程调用")

	go func(msg string) {
		for i := 0; i < 5; i++ {
			fmt.Println(msg)
			time.Sleep(time.Second)
		}
	}("匿名函数...")

	// time.Sleep(3 * time.Second)
	fmt.Println("main done!")
}

/******************************************************
 * 通道(channels) 是连接多个协程的管道。
	使用 make(chan val-type) 创建一个新的通道。 通道类型就是他们需要传递值的类型。
	使用 channel <- 语法 发送 一个新的值到通道中
	使用 m := <-channel 语法从通道中 接收 一个值。
	注意：默认发送和接收操作是阻塞的，直到发送方和接收方都就绪。


	无缓冲通道
		无缓冲通道是指在接收前没有能力保存任何值的通道，这种通道需要发送goroutine和接收goroutine同时准备好，才能完成发送和接收操作。
		如果发送goroutine和接收goroutine没有同时准备好，会造成发送或接收操作的goroutine阻塞等待。
	有缓冲通道
		有缓冲通道是一种在被接收前能存储一个或者多个值的通道。不强制要求goroutine之间必须同时完成发送和接受。
		通道中没有要接收的值时，接收动作会阻塞。
		通道没有可用的缓冲区容纳被发送的值时，发送动作会阻塞。
		无缓冲通道能保证发送和接受会在同一时间进行数据交换，有缓冲通道没有这种保证。

	https://blog.csdn.net/qq_45893475/article/details/121422599

 ******************************************************/
func testChannel_1() {
	message := make(chan string)

	go func() {
		for i := 0; i < 3; i++ {
			fmt.Println("task runing ", i)
			message <- fmt.Sprintf("ping %d ...", i)
		}

		message <- "finish"
		fmt.Println("task 1 done!\n")
	}()

	// // 收到一次消息后，主线程继续，程序结束
	// msg := <-message
	// fmt.Println(msg)

	// 任务2，循环接收消息，知道接受完命令，结束
	go func() {
		for {
			msg := <-message
			fmt.Println(msg)

			if msg == "finish" {
				break
			}
		}

		fmt.Println("task 2 done!\n")
	}()

	time.Sleep(time.Second * 5)
	fmt.Println("main done!")
}

/*
 特性：缓冲
	默认是无缓冲，这意味着只有对应的接收通道准备好接收时，才允许进行发送。
	有缓冲通道 允许在没有对应接收者的情况下，缓存一定数量的值。
 **/
func testChannel_2() {
	// 缓冲个数为2
	message := make(chan string, 2)

	go func() {
		for i := 0; i < 5; i++ {
			fmt.Println("task runing ", i)
			message <- fmt.Sprintf("ping %d ...", i)
		}

		message <- "finish"
		fmt.Println("task 1 done!\n")
	}()

	// // 收到一次消息后，主线程继续，程序结束
	// msg := <-message
	// fmt.Println(msg)

	time.Sleep(time.Second)
	// 任务2，循环接收消息，知道接受完命令，结束
	go func() {
		for {

			msg := <-message
			fmt.Println(msg)

			fmt.Println("recving...")
			if msg == "finish" {
				break
			}
		}

		fmt.Println("task 2 done!\n")
	}()

	time.Sleep(time.Second * 5)
	fmt.Println("main done!")
}

/*
 特性：同步
 	如果发送goroutine和接收goroutine没有同时准备好，会造成发送或接收操作的goroutine阻塞等待。
*/
func testChannel_3() {
	done := make(chan bool, 1)
	go task3(done)

	// 程序将一直阻塞，直至收到 worker 使用通道发送的通知。
	<-done

	fmt.Println("main done!")
}
func task3(done chan bool) {
	fmt.Println("task working...")
	time.Sleep(time.Second)
	fmt.Println("task done!")

	done <- true
}

/*
 特性：读写，只写 chan<- type，只读 <-chan type
 	使用通道作为函数的参数时，你可以指定这个通道是否为只读或只写。
	该特性可以提升程序的类型安全。
*/
// 只写：只能发送数据
func ping(pings chan<- string, text string) {
	pings <- text
	// invalid operation: <-pings (receive from send-only type chan<- string)
	// msg := <-pings
}

// pings 仅用于接收数据（只读），pongs 仅用于发送数据（只写）。
func pong(pings <-chan string, pongs chan<- string) {
	msg := <-pings
	pongs <- msg
}

func testPingPong() {
	pings := make(chan string, 1)
	pongs := make(chan string, 1)
	ping(pings, "发送消息咯")
	pong(pings, pongs)
	fmt.Println(<-pongs)
}

/*
 * 特性：通道选择器
	Go 的 选择器（select） 让你可以同时等待多个通道操作。
	注意，等待个数必须匹配，否则死锁报错，fatal error: all goroutines are asleep - deadlock!
*/
func testChannel_select() {
	c1 := make(chan string, 1)
	c2 := make(chan string, 1)
	c3 := make(chan string, 1)

	// 各个通道将在一定时间后接收一个值， 通过这种方式来模拟并行的协程执行（例如，RPC 操作）时造成的阻塞（耗时）。
	go func() {
		time.Sleep(time.Second * 1)
		c1 <- "one"
	}()
	go func() {
		time.Sleep(time.Second * 2)
		c2 <- "two"
	}()
	go func() {
		time.Sleep(time.Second * 2)
		c3 <- "three"
	}()

	for i := 0; i < 3; i++ {
		select {
		case msg1 := <-c1:
			fmt.Println("received ", msg1)
		case msg2 := <-c2:
			fmt.Println("received ", msg2)
		case msg3 := <-c3:
			fmt.Println("received ", msg3)
		}
	}

	fmt.Println("main done!")
}

/*
 * 特性：超时处理
	超时 对于一个需要连接外部资源， 或者有耗时较长的操作的程序而言是很重要的。 得益于通道和 select，在 Go 中实现超时操作是简洁而优雅的。
*/
func makeTimeoutChannel(timeout int, callback func(result string, err error)) chan string {
	c := make(chan string, 1)
	bindTimeoutChannel(&c, timeout, callback)
	return c
}
func bindTimeoutChannel(c *chan string, timeout int, callback func(result string, err error)) {
	select {
	case m := <-*c:
		if callback != nil {
			callback(fmt.Sprintf("recv:%s", m), nil)
		}
	case t := <-time.After(time.Second * time.Duration(timeout)):
		if callback != nil {
			e := errors.New(fmt.Sprintf("timeout:%s", t))
			callback("", e)
		}
	}
}

/*
	封装为函数后，没办法得到预期的效果，为什么呢？有待研究
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
timeout:2022-09-20 14:21:42.133085 +0800 CST m=+1.000518967
timeout:2022-09-20 14:21:45.134568 +0800 CST m=+4.002066279
main done!
*/
func testChannel_timeout() {
	c1 := make(chan string)
	bindTimeoutChannel(&c1, 1, func(result string, err error) {
		if err != nil {
			fmt.Println(err)
		} else {
			fmt.Println(result)
		}
	})
	go func() {
		time.Sleep(time.Second * 2)
		c1 <- "finish one!"
	}()

	c2 := make(chan string)
	bindTimeoutChannel(&c2, 3, func(result string, err error) {
		if err != nil {
			fmt.Println(err)
		} else {
			fmt.Println(result)
		}
	})
	go func() {
		c2 <- "finish two!"
	}()

	fmt.Println("main done!")
}

/*
timeout 1
result 2
main done!
*/
func testChannel_timeout_1() {
	c1 := make(chan string)
	go func() {
		time.Sleep(2 * time.Second)
		c1 <- "result 1"
	}()

	select {
	case res := <-c1:
		fmt.Println(res)
	case <-time.After(1 * time.Second):
		fmt.Println("timeout 1")
	}

	c2 := make(chan string)
	go func() {
		time.Sleep(2 * time.Second)
		c2 <- "result 2"
	}()
	select {
	case res := <-c2:
		fmt.Println(res)
	case <-time.After(3 * time.Second):
		fmt.Println("timeout 2")
	}

	fmt.Println("main done!")
}

/*
 特性：非阻塞通道操作
 	使用带一个 default 子句的 select 来实现 非阻塞 的发送、接收，甚至是非阻塞的多路 select。
*/
func testChannel_nonblock() {
	messages := make(chan string)
	signals := make(chan string)

	// 非阻塞接收
	select {
	case m := <-messages:
		fmt.Println("recv:", m)
	default:
		fmt.Println("no message recv, non block, continue")
	}

	// 非阻塞发送
	msg := "hello"
	select {
	case messages <- msg:
		fmt.Println("send:", msg)
	default:
		fmt.Println("no message send")
	}

	// 多路非阻塞接收
	select {
	case msg := <-messages:
		fmt.Println("received message", msg)
	case sig := <-signals:
		fmt.Println("received signal", sig)
	default:
		fmt.Println("no activity")
	}

	fmt.Println("main done!")
}

/*
 特性：关闭通道，close x
*/
func testChannel_close() {
	jobs := make(chan int, 5)
	syncDone := make(chan bool)

	go func() {
		for {
			if j, close := <-jobs; close == true {
				fmt.Println("recv job ", j)
			} else {
				fmt.Println("received all jobs")
				syncDone <- true
				return
			}
		}
	}()

	for i := 0; i < 6; i++ {
		jobs <- i
		fmt.Println("send job ", i)
	}

	fmt.Println("close channel job now!")
	close(jobs)

	<-syncDone
	fmt.Println("main done!")
}

/*
 * 特性：通道遍历
	一个非空的通道是可以关闭的， 并且关闭后，通道中剩下的值仍然可以被接收到。
*/
func testChannel_travel() {
	c := make(chan string, 2)
	c <- "one"
	c <- "two"
	close(c)

	for msg := range c {
		fmt.Println("遍历通道", msg)
	}

	fmt.Println("main done!")
}

/*
 * 应用1：使用协程与通道实现工作池
 */
func worker(id int, recvs <-chan int, sends chan<- int) {
	// 接收动作
	fmt.Println("worker id:", id, "start")
	for job := range recvs {
		fmt.Println("woker id:", id, "started job", job)
		time.Sleep(time.Second)
		fmt.Println("woker id:", id, "finished job", job)
		// 返回结果
		sends <- job * 2
	}

	fmt.Println("worker id:", id, "end")
}
func testWorkerPool() {
	counts := 5
	jobs := make(chan int, counts)
	results := make(chan int, counts)

	// 开启多个协程，即多个worker
	// 初始是阻塞的，因为还没有传递任务~~ 将会阻塞协程~~
	for w := 0; w < 3; w++ {
		go worker(w, jobs, results)
	}

	// 通过 发送 工作，并且关闭jobs通道
	fmt.Println("派发工作\n")
	for i := 0; i < counts; i++ {
		jobs <- i
	}
	close(jobs)

	// 最后，我们收集所有这些任务的返回值。 这也确保了所有的 worker 协程都已完成。
	for j := 0; j < counts; j++ {
		fmt.Println(<-results)
	}

	fmt.Println("main done!")
}

/*
 特性： WaitGroup ， 等待多个协程完成
	注意：如果 WaitGroup 显式传递到函数中，则应使用 *指针*
*/
func workTask(id int) {
	fmt.Printf("Worker %d starting\n", id)
	time.Sleep(time.Second)
	fmt.Printf("Worker %d done\n", id)
}
func testWaitGroup() {
	// 1、初始化waitgroup
	var wg sync.WaitGroup

	for i := 0; i < 5; i++ {
		// 2、waitgroup 加 1
		wg.Add(1)

		// 开始协程
		// 避免在每个协程闭包中重复利用相同的 i 值
		oi := i

		// 将 worker 调用包装在一个闭包中，可以确保通知 WaitGroup 此工作线程已完成。 这样，worker 线程本身就不必知道其执行中涉及的并发原语
		go func() {
			workTask(oi)
			// 3、协程借宿，waitgroup完成
			defer wg.Done()
		}()
	}

	fmt.Println("waiting...")
	// 4、阻塞等待：直到 WaitGroup 计数器恢复为 0； 即所有协程的工作都已经完成。
	wg.Wait()
	fmt.Println("main done!")
}

/*
 * 原子量
 	Go 中最主要的状态管理机制是依靠通道间的通信来完成的。
	如何使用 sync/atomic 包在多个协程中进行 _原子计数_。
*/
func testAtomicCounts() {
	var atomicCounts uint64
	var normalCounts uint64

	// WaitGroup等待所有协程结束
	var wg sync.WaitGroup

	for i := 0; i < 50; i++ {
		wg.Add(1)
		// 开启协程
		go func() {
			for j := 0; j < 1000; j++ {
				atomic.AddUint64(&atomicCounts, 1)
				normalCounts += 1
			}

			// 该协程结束
			defer wg.Done()
		}()
	}

	// 等待 所有协程结束
	wg.Wait()

	// 如果我们使用非原子的 ops++ 来增加计数器， 由于多个协程会互相干扰，运行时值会改变，可能会导致我们得到一个不同的数字。
	// 此外，运行程序时带上 -race 标志，我们可以获取数据竞争失败的详情。
	// 50 * 1000（协程个数 * 单个协程计数）
	fmt.Println("原子计数：", atomicCounts, atomic.LoadUint64(&atomicCounts))

	// 如果我们使用非原子的 ops++ 来增加计数器， 由于多个协程会互相干扰，运行时值会改变，可能会导致我们得到一个不同的数字。
	// 值不可预估，每次运行值都不同
	fmt.Println("非原子计数：", normalCounts)

	fmt.Println("main done!")
}

/*
 互斥量：
*/
type CounterWithMutex struct {
	values     map[string]int
	innerMutex sync.Mutex
}

// 请注意不能复制互斥锁，如果需要传递这个 struct，应使用指针完成。
// 如果复制了，就变成不同结构体的实例
func (c *CounterWithMutex) inc(key string) {
	c.innerMutex.Lock()
	defer c.innerMutex.Unlock()
	c.values[key]++
	// c.innerMutex.Unlock()
}

func testMutex() {
	// 注意，互斥量的零值是可用的，因此这里不需要初始化。
	counter := CounterWithMutex{
		values: map[string]int{},
	}

	// 等待所有协程完成
	var wg sync.WaitGroup

	// 定义协程函数
	// 同时运行多个 goroutines; 请注意，它们都访问相同的 Container，其中两个访问相同的计数器。
	taskHandler := func(key string, total int) {
		for i := 0; i < total; i++ {
			// inc 内部互斥上锁，
			counter.inc(key)
		}
		defer wg.Done()
	}

	for j := 0; j < 9; j++ {
		wg.Add(1)
		go taskHandler(fmt.Sprintf("go_k_%d", j), 1000*(j+1))
	}

	wg.Wait()
	fmt.Println("计数器值：", counter.values)
	fmt.Println("main done!")
}

/*
 * 特性： 速率限制，是控制服务资源利用和质量的重要机制。
	基于协程、通道和打点器，Go 优雅的支持速率限制。
*/
func testLimitter() {
	requests := make(chan int, 5)
	for i := 0; i < 5; i++ {
		requests <- i
	}
	close(requests)

	// 限速器实现：利用Ticker的通道实现
	limitter := time.Tick(500 * time.Millisecond)
	for response := range requests {
		// 限速原理：每次time来临前，会阻塞当前线程
		<-limitter
		fmt.Println("response ", response, time.Now())
	}
}

//
// 2、在速率限制方案中允许短暂的并发请求，并同时保留总体速率限制。我们可以通过缓冲通道来完成此任务。
//
func testBurstyLimitter() {
	// 允许三个缓冲
	burstyCount := 3
	burstyLimitter := make(chan time.Time, burstyCount)

	// // 填充通道，表示允许的爆发（bursts），这些将会立刻处理，不收限制
	// for i := 0; i < burstyCount; i++ {
	// 	burstyLimitter <- time.Now()
	// }

	// 开启协程
	go func() {
		burstyIndex := 0
		for t := range time.Tick(500 * time.Millisecond) {
			burstyIndex++
			// 每3次，模拟一次bursty
			if burstyIndex%3 == 0 {
				for i := 0; i < burstyCount; i++ {
					burstyLimitter <- t
				}
			} else {
				burstyLimitter <- t
			}
			fmt.Println("500ms tick")
		}
		fmt.Println("ticker go done")
	}()

	requestCount := 15
	burstyRequests := make(chan int, requestCount)
	for i := 0; i < requestCount; i++ {
		burstyRequests <- i
	}
	close(burstyRequests)

	for response := range burstyRequests {
		<-burstyLimitter
		fmt.Println("response ", response, time.Now())
	}

	// 主程序多生存10
	time.Sleep(time.Second * 10)
	fmt.Println("done!")
}

/*
 * 状态协程（共享内存）
	使用内建协程和通道的同步特性来达到同样的效果。
	Go 共享内存的思想是，通过通信使每个数据仅被单个协程所拥有，即通过通信实现共享内存。 基于通道的方法与该思想完全一致！

	使用场景，例如，当你涉及其他通道，或者管理多个同类互斥锁时，会很容易出错。
*/
type ReadChannel struct {
	key     int
	channel chan int
}
type WriteChannel struct {
	key, value int
	channel    chan bool
}

// 运行这个程序显示这个基于协程的状态管理的例子
// 达到了每秒大约 80,000 次操作。
func testState() {
	// 初始化读写通道，类型为自定的类型
	readChan := make(chan ReadChannel)
	writeChan := make(chan WriteChannel)
	// 初始化共享空间
	go func() {
		// state
		var stateDic = make(map[int]int)
		for {
			select {
			case r := <-readChan:
				r.channel <- stateDic[r.key]
			case w := <-writeChan:
				stateDic[w.key] = w.value
				w.channel <- true
			}
		}
	}()

	//
	// 以下为模拟测试
	//
	var readCountVal uint64
	var writeCountVal uint64
	// 开启 read 的协程，100个
	for i := 0; i < 100; i++ {
		go func() {
			for {
				// 结构体初始化
				read_stu := ReadChannel{
					key:     rand.Intn(5),
					channel: make(chan int), // 无缓存
				}
				readChan <- read_stu
				// 无缓存，阻塞，等待有值
				<-read_stu.channel
				// 原子计数
				atomic.AddUint64(&readCountVal, 1)
				time.Sleep(time.Millisecond)
			}
		}()
	}

	// 开启 write 协程，10个
	for j := 0; j < 10; j++ {
		go func() {
			for {
				// 结构体初始化
				write_stu := WriteChannel{
					key:     rand.Intn(5),
					value:   rand.Intn(100),
					channel: make(chan bool), // 无缓存
				}
				writeChan <- write_stu
				// 无缓存，阻塞，等待有值
				<-write_stu.channel
				// 原子计数
				atomic.AddUint64(&writeCountVal, 1)
				time.Sleep(time.Millisecond)
			}
		}()
	}

	// 让协程们跑 1s。
	time.Sleep(time.Second * 1)
	fmt.Println("read final:", atomic.LoadUint64(&readCountVal))
	fmt.Println("write final:", atomic.LoadUint64(&writeCountVal))
	fmt.Println("main done!")
}

func main() {
	fmt.Println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")

	// testGoroutineTask()
	// testChannel_1()
	// testChannel_2()
	// testChannel_3()
	// testPingPong()
	// testChannel_select()

	// testChannel_timeout()
	// testChannel_timeout_1()

	// testChannel_nonblock()

	// testChannel_close()

	// testChannel_travel()

	// testWorkerPool()
	// testWaitGroup()

	// testLimitter()
	// testBurstyLimitter()

	// testAtomicCounts()

	// testMutex()

	testState()
}
