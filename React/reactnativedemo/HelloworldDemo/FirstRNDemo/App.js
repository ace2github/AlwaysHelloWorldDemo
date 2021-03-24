/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow strict-local
 */

import React from 'react';
import type {Node} from 'react';
import {
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  Image,
  useColorScheme,
  TouchableOpacity,
  View,
  FlatList,
  NativeModules,
  NativeEventEmitter,
} from 'react-native';

import {
  Colors,
  DebugInstructions,
  Header,
  LearnMoreLinks,
  ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';


/*******************************************************
  Default
*******************************************************/
const Section = ({children, title}): Node => {
  const isDarkMode = useColorScheme() === 'dark';
  return (
    <View style={styles.sectionContainer}>
      <Text
        style={[
          styles.sectionTitle,
          {
            color: isDarkMode ? Colors.white : Colors.black,
          },
        ]}>
        {title}
      </Text>
      <Text
        style={[
          styles.sectionDescription,
          {
            color: isDarkMode ? Colors.light : Colors.dark,
          },
        ]}>
        {children}
      </Text>
    </View>
  );
};

const App: () => Node = () => {
  const isDarkMode = useColorScheme() === 'dark';

  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
  };

  return (
    <SafeAreaView style={backgroundStyle}>
      <StatusBar barStyle={isDarkMode ? 'light-content' : 'dark-content'} />
      <ScrollView
        contentInsetAdjustmentBehavior="automatic"
        style={backgroundStyle}>
        <Header />
        <View
          style={{
            backgroundColor: isDarkMode ? Colors.black : Colors.white,
          }}>
          <Section title="Step One">
            Edit <Text style={styles.highlight}>App.js</Text> to change this
            screen and then come back to see your edits.
          </Section>
          <Section title="See Your Changes">
            <ReloadInstructions />
          </Section>
          <Section title="Debug">
            <DebugInstructions />
          </Section>
          <Section title="Learn More">
            Read the docs to discover what to do next:
          </Section>
          <LearnMoreLinks />
        </View>
      </ScrollView>
    </SafeAreaView>
  );
};

/* 代码中只会被创建 */
const styles = StyleSheet.create({
  sectionContainer: {
    marginTop: 32,
    paddingHorizontal: 24,
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: '600',
  },
  sectionDescription: {
    marginTop: 8,
    fontSize: 18,
    fontWeight: '400',
  },
  highlight: {
    fontWeight: '700',
  },
});


/*******************************************************
  HelloWorld
*******************************************************/
class HelloWorld extends React.Component {
  render() {
    return (
      // <TouchBox></TouchBox>
      //<FlexBox></FlexBox>
      // <ImageBox></ImageBox>
      // <ListView></ListView>
      <NativeConnectBox></NativeConnectBox>
    )
  }
}

/*******************************************************
  flex布局相关
*******************************************************/
class FlexBox extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      selectedValue: 'column',
    };

    // bind(self)会报错，this.state is undefined
    this.didSelectValueHandler = this.didSelectValueHandler.bind(this);
  }
  render() {
    return (
      <FlexPreviewLayoutBox
        label='flexDirection'
        values={['column', 'row', 'column-reverse', 'row-reverse']}
        selectedValue={this.state.selectedValue}
        callbackFunc={this.didSelectValueHandler}>
          <View style={{width:60, height:60, backgroundColor:'powderblue'}}></View>
          <View style={{width:60, height:60, backgroundColor:'skyblue'}}></View>
          <View style={{width:60, height:60, backgroundColor:'steelblue'}}></View>
        </FlexPreviewLayoutBox>
    )
  }
  didSelectValueHandler(value) {
    this.setState({
        selectedValue: value
    });
  }
}
/*******************************************************
  功能：1、将values数组里面的值，渲染为可点击Text（相当于button）；同时点击的时候，改变flexDirection的值，改变布局方向。
       2、this.props.children 表示父组件里面的所有子组件
*******************************************************/
class FlexPreviewLayoutBox extends React.Component {
  render() {
    return (
      <View style={[FlexBoxStyles.container, {flex:1}]}>
        <Text style={{textAlign:'center', marginBottom:10, marginTop:20, fontSize:24}}>{this.props.label}</Text>
        <View style={{flexDirection:'row', flexWrap:'wrap'}}>
        {this.props.values.map((value) => (
            <TouchableOpacity
              key={value}
              onPress={()=>this.props.callbackFunc(value)}
              style={[FlexBoxStyles.button, this.props.selectedValue === value && FlexBoxStyles.selected,]}>
              <Text style={[FlexBoxStyles.buttonLabel, this.props.selectedValue === value && FlexBoxStyles.selectedLabel,]}>{value}</Text>
            </TouchableOpacity>
        ))}
        </View>
        <View style={[FlexBoxStyles.container, {[this.props.label]: this.props.selectedValue}]}>
          {this.props.children}
        </View>
      </View>
    )
  }
}

const FlexBoxStyles = StyleSheet.create({
    container: {
      flex: 1,
      marginTop: 8,
      backgroundColor: "aliceblue",
    },

    button: {
      paddingHorizontal: 8,
      paddingVertical: 6,
      borderRadius: 4,
      backgroundColor: "oldlace",
      alignSelf: "flex-start",
      marginHorizontal: "1%",
      marginBottom: 6,
      minWidth: "48%",
      textAlign: "center",
    },
    selected: {
      backgroundColor: "coral",
      borderWidth: 0,
    },

    buttonLabel: {
      fontSize: 12,
      fontWeight: "500",
      color: "coral",
      textAlign: 'center'
    },
    selectedLabel: {
      color: "white",
    },
});
// end

/*******************************************************
  原生交互组件
*******************************************************/
// 获取原生RN交互模块ReactConnector
const NativeConnector = NativeModules.NativeConnector;

// 监听原生调用js的方法emitter
const NativeConnectorEmitter = new NativeEventEmitter(NativeModules.NativeConnector);

class NativeConnectBox extends React.Component {
  constructor(props) {
    super(props)
    this.clickHandler =  this.clickHandler.bind(this);
    this.clickCallBackHandler =  this.clickCallBackHandler.bind(this);
  }
  render() {
    return(
      <View style={{flex:1, justifyContent:'center'}}>
        <TouchableOpacity onPress={this.clickHandler} style={{marginTop:20, alignItems:'center', backgroundColor:'darkorange'}}>
          <Text>click me</Text>
        </TouchableOpacity>
        <TouchableOpacity onPress={this.clickCallBackHandler} style={{marginTop:10, alignItems:'center', backgroundColor:'darkorange'}}>
          <Text>click callBack Func</Text>
        </TouchableOpacity>
      </View>
    )
  }

  clickHandler() {
    NativeConnector.callNativeFunc('nihao native, i`m react native.');
  }

  clickCallBackHandler() {
    NativeConnector.callNativeWithCallBackFunc('nihao native, i`m react native.', (data) => {
      alert(data);
    })
  }

  componentDidMount() {
      eventInitSubscription = NativeConnectorEmitter.addListener('EventInit', (name) => {
          alert('EventInit ' + name);

          eventInitSubscription.remove();
      });

      eventLoginSubscription = NativeConnectorEmitter.addListener('EventLogin', () => {
          alert('EventLogin');

          eventLoginSubscription.remove();
      });
  }

}

/*******************************************************
  Touch组件
*******************************************************/
class TouchBox extends React.Component {
  constructor(props) {
    super(props);
    this.state = {count: 1};
    this.onPress = this.onPress.bind(this);
  }

  render() {
      return (
        <View style={TouchBoxStyles.container}>
          <View style={TouchBoxStyles.countContainer}>
            <Text>count:{this.state.count}</Text>
          </View>
          <TouchableOpacity onPress={this.onPress} style={TouchBoxStyles.button}>
            <Text>Press Here</Text>
          </TouchableOpacity>
        </View>
      )
  }

  onPress() {
    this.setState(state => ({
      count: state.count + 1
    }));
  }
}

const TouchBoxStyles = StyleSheet.create({
    container: {
      flex: 1,
      justifyContent: 'center',
      paddingHorizontal: 10,
      backgroundColor: '#efefef'
    },
    button: {
      alignItems: 'center',
      backgroundColor: 'darkorange',
      padding: 10
    },
    countContainer: {
      alignItems: 'center',
      padding: 10
    },
});
// end

/*******************************************************
  图片组件
*******************************************************/
class ImageBox extends React.Component {
  render() {
    return(
      <View style={{margin:30}}>
        <Image source={require('./resources/dynamic.gif')} style={{width: 40, height: 40}}></Image>

        <Image
          source={require('./resources/static_image.png')}
          resizeMode={'center'}
          style={{width: 80, height: 80, backgroundColor:'darkorange'}}></Image>

        <Image source={{uri: 'https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png'}} style={{width: 40, height: 40}}/>
      </View>
    )
  }
}


/*******************************************************
  ListView
*******************************************************/
// const ListCellItem = ({ title }) => {
//     return (
//       <View style={listViewStyles.item}>
//         <Text style={listViewStyles.title}>{title}</Text>
//       </View>
//     );
// }
class ListCellItem extends React.Component {
  render(){
    return(
      <View style={listViewStyles.item}>
        <Text style={listViewStyles.itemTitle}>{this.props.title}</Text>
      </View>
    );
  }
}

class ListView extends React.Component {
  dataList = [];

  renderCellItem = ({ item }) => (
    <ListCellItem title={item.title} />
  );

  constructor (props) {
    super(props);

    // 数据源
    for(var i=0; i< 32; i++) {
      this.dataList.push({id:i, title: 'title ' + i})
    }
  }

  render() {
    return (
      <SafeAreaView style={styles.container}>
        <FlatList
          data={this.dataList}
          renderItem={this.renderCellItem}
          initialNumToRender={16}
          initialScrollIndex={0}
        />
      </SafeAreaView>
    )
  }
}

const listViewStyles = StyleSheet.create({
  container: {
    flex: 1,
    marginTop: 40,
  },

  item: {
    padding: 8,
    backgroundColor: 'darkorange',
    marginVertical: 2,
    marginHorizontal: 12,
    height: 40,
  },
  itemTitle: {
    fontSize: 16,
    textAlign:'left',
    lineHeight: (40 - 2*8)
  },
});

/*******************************************************
  导出组件
*******************************************************/
export {HelloWorld};
