import logo from './logo.svg';
import './App.css';

// 导入react框架
import React from 'react';


function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}

/**
  组件的State和setState
  组件的生命周期
*/
class Clock extends React.Component {
  // 构造函数
  constructor(props) {
    super(props);

    // 定义state里面的 date 属性
    this.state = {date: new Date()};
  }

  // 声明周期
  componentDidMount() {
    this.timer = setInterval(
      () => this.timerHandler(),
      1000
    );
  }

  componentWillUnmount() {
    clearInterval(this.timer);
  }

  // 渲染核心函数
  render() {
    return (
        <h2> today is {this.state.date.toLocaleTimeString()}</h2>
    )
  }

  // custom
  timerHandler() {
    // 更新 state.date 属性
    this.setState({
      date: new Date()
    });
  }
}

/**
  React的事件绑定
*/
class TapButton extends React.Component {
  constructor(props){
    super(props);

    this.state = {isToggleOn: true};

    // 为了在回调中使用 `this`，这个绑定是必不可少的
    this.clickHandler = this.clickHandler.bind(this);
  }

  render() {
    return <button onClick={this.clickHandler}> {this.state.isToggleOn ? "ON" : "OFF"} </button>
  }

  clickHandler() {
    this.setState(state => ({
      isToggleOn: !state.isToggleOn
    }));
  }
}

/*
  组件定义、复合组件
  props属性
*/
class HelloWorld extends React.Component {
  // 渲染核心函数
  render() {
    return (
      <div>
        <h1>Hello, {this.props.title} !</h1>
        <Clock></Clock>
        <TapButton></TapButton>
      </div>
    )
  }
}


// export default App;
export {App, HelloWorld};
