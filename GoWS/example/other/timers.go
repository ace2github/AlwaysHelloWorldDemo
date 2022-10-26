package other

import (
	"fmt"
	"time"
)

/******************************************************
 * timer & tickeer
	内置通道 C
 ******************************************************/
func TestTimerMain() {
	fmt.Println("\n\n>>>>>>>>>>>>>>>>>>>>>>")
	timer1 := time.NewTimer(2 * time.Second)
	<-timer1.C
	fmt.Println("timer 1 is fired")

	timer2 := time.NewTimer(time.Second)
	go func() {
		<-timer2.C
		fmt.Println("timer 2 is fired")
	}()

	stop2 := timer2.Stop()
	fmt.Println(stop2)
	if stop2 {
		fmt.Println("timer 2 stopped")
	}

	time.Sleep(2 * time.Second)
}

func testTicker() {
	fmt.Println("\n\n>>>>>>>>>>>>>>>>>>>>>>")
	ticker := time.NewTicker(500 * time.Millisecond)
	done := make(chan bool)

	go func() {
		fmt.Println("task running ... ")
		for {
			select {
			case <-done:
				return
			case t := <-ticker.C:
				fmt.Println("count ", t)
			}
		}
	}()

	time.Sleep(2 * time.Second)

	// stop
	ticker.Stop()
	fmt.Println("stop ticker now")
	done <- true

	fmt.Println("main done!")
}

/******************************************************
 * time base
 ******************************************************/
func testTimeBase() {
	fmt.Println("\n\n>>>>>>>>>>>>>>>>>>>>>>")
	now := time.Now()
	fmt.Println("当前时间：", now)
	fmt.Println("year", now.Year())
	fmt.Println("Month", now.Month())
	fmt.Println("Day", now.Day())
	fmt.Println("Hour", now.Hour())
	fmt.Println("Minute", now.Minute())
	fmt.Println("Second", now.Second())
	fmt.Println("Nanosecond", now.Nanosecond()) // 纳秒
	fmt.Println("Location", now.Location())
	fmt.Println("Weekday", now.Weekday())

	fmt.Println("\n\n>>>>>>>>>>>>>>>>>>>>>>")
	// 构建时间
	otherTime := time.Date(2009, 11, 17, 20, 34, 58, 651387237, time.UTC)
	fmt.Println("自定义日期：", otherTime)

	fmt.Println("Before", otherTime.Before(now))
	fmt.Println("After", otherTime.After(now))
	fmt.Println("Equal", otherTime.Equal(now))

	fmt.Println("\n\n>>>>>>>>>>>>>>>>>>>>>>")
	diff := now.Sub(otherTime)
	fmt.Println("sub:", diff)
	fmt.Println("Hours", diff.Hours())
	fmt.Println("Minutes", diff.Minutes())
	fmt.Println("Seconds", diff.Seconds())
	fmt.Println("Nanoseconds", diff.Nanoseconds())

	fmt.Println("\n\n>>>>>>>>>>>>>>>>>>>>>>")
	fmt.Println("add:", otherTime.Add(diff))
	fmt.Println("add:", otherTime.Add(-diff))

	fmt.Println("\n\n>>>>>>>>>>>>>>>>>>>>>>")
	secs := now.Unix()
	nanos := now.UnixNano() // 纳秒

	millis := nanos / 1000000
	fmt.Println("secs", secs)
	fmt.Println("millis", millis)
	fmt.Println("nanos", nanos)

	// 将 Unix 纪元起的整数秒或者纳秒转化到相应的时间。
	fmt.Println(time.Unix(secs, 0))
	fmt.Println(time.Unix(0, nanos))

	fmt.Println("\n\n>>>>>>>>>>>>>>>>>>>>>>")
	fmt.Println("RFC3339", time.RFC3339)
	fmt.Println("now format with RFC3339", now.Format(time.RFC3339))

	// 格式化自定义日期
	timeStr := "2012-11-01T22:08:41+00:00"
	fmt.Println("字符串日期：", timeStr)
	ft, err := time.Parse(time.RFC3339, timeStr)
	if err != nil {
		fmt.Println(err)
	} else {
		fmt.Println("格式化日期：", ft)
	}

	fmt.Println("\n\n>>>>>>>>>>>>>>>>>>>>>>")
	fmt.Println("3:04PM", now.Format("3:04PM"))
	fmt.Println("Mon Jan _2 15:04:05 2006", now.Format("Mon Jan _2 15:04:05 2006"))
	fmt.Println("2006-01-02T15:04:05.999999-07:00", now.Format("2006-01-02T15:04:05.999999-07:00"))

	fmt.Println("\n\n>>>>>>>>>>>>>>>>>>>>>>")
	form := "3 04 PM"
	t2, e := time.Parse(form, "8 41 PM")
	fmt.Println(t2)

	fmt.Println("\n\n>>>>>>>>>>>>>>>>>>>>>>")
	fmt.Printf("%d-%02d-%02dT%02d:%02d:%02d-00:00\n",
		now.Year(), now.Month(), now.Day(),
		now.Hour(), now.Minute(), now.Second())

	ansic := "Mon Jan _2 15:04:05 2006"
	_, e = time.Parse(ansic, "8:41PM")
	fmt.Println(e)
}
