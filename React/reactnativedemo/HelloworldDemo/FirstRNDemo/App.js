/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow strict-local
 */

import NetworkManager from './NetworkManager'
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
  TouchableHighlight,
  View,
  FlatList,
  Modal,
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
  HelloWorld
*******************************************************/
class HelloWorld extends React.Component {
  render() {
    return (
      // <TouchBox></TouchBox>
      //<FlexBox></FlexBox>
      //<ImageBox></ImageBox>
      // <ListView></ListView>
      // <NativeConnectBox></NativeConnectBox>
      <ModalBox/>
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
  modal 相关
*******************************************************/
class ModalBox extends React.Component {
  state = {
    modalVisible: false
  };

  setModalVisible = (visible) => {
    this.setState({ modalVisible: visible });
  }

  render() {
    const { modalVisible } = this.state;
    return (
      <View style={modalStyles.centeredView}>
        <Modal
          animationType="fade"
          transparent={true}
          visible={modalVisible}
          onRequestClose={() => {
            Alert.alert("Modal has been closed.");
            this.setModalVisible(!modalVisible);
          }}
        >
          <View style={modalStyles.modalBackgroundView}>
            <View style={modalStyles.modalView}>
              <Text style={modalStyles.modalText}>《虫师》简介</Text>
              <Text style={{marginBottom: 30}}>“虫”既不是动物，也不是微生物，而是一种自然界中无处不在的力量，拥有独特的生命形态，偶尔和人类生命产生交汇，便生出一些奇妙的故事。</Text>

              <TouchableHighlight
                style={{ ...modalStyles.openButton, backgroundColor: "#2196F3", paddingHorizontal: 60 }}
                onPress={() => {
                  this.setModalVisible(!modalVisible);
                }}
              >
                <Text style={modalStyles.textStyle}>确定</Text>
              </TouchableHighlight>
            </View>
          </View>
        </Modal>

        <TouchableHighlight
          style={modalStyles.openButton}
          onPress={() => {
            this.setModalVisible(true);
          }}
        >
          <Text style={modalStyles.textStyle}>Show Modal</Text>
        </TouchableHighlight>
      </View>
    );
  }
}

const modalStyles = StyleSheet.create({
  centeredView: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    marginTop: 22
  },

  modalBackgroundView: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    backgroundColor: 'rgba(178,178,178,0.5)'
  },
  modalView: {
    margin: 20,
    backgroundColor: "white",
    borderRadius: 20,
    padding: 35,
    alignItems: "center",
    shadowColor: "#000",
    shadowOffset: {
      width: 0,
      height: 2
    },
    shadowOpacity: 0.25,
    shadowRadius: 3.84,
    elevation: 5,
    width: '80%'
  },
  modalText: {
    marginBottom: 15,
    textAlign: "center",
    fontSize: 24
  },

  openButton: {
    backgroundColor: "#F194FF",
    borderRadius: 20,
    padding: 10,
    elevation: 2
  },
  textStyle: {
    color: "white",
    fontWeight: "bold",
    textAlign: "center"
  },

});

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
      <View style={CellStyles.backgroundView}>
        <View style={CellStyles.header}>
          <Image style={CellStyles.icon} source={this.props.icon} />
          <Text style={CellStyles.title}>{this.props.title}</Text>
        </View>
        <View style={CellStyles.content}>
          <Text style={CellStyles.contentText}>{this.props.content}</Text>
        </View>
        <View style={CellStyles.line}>
        </View>
      </View>
    );
  }
}
const CellStyles = StyleSheet.create({
    backgroundView: {
      marginTop: 10,
      marginHorizontal: 15,
      backgroundColor: '#fff',
      flexDirection: 'column'
    },
    header: {
      height: 50,
      flexDirection: 'row',
      alignItems: 'center',
      //backgroundColor: "darkorange",
    },

    content: {
      //backgroundColor: "darkorange",
      marginTop: 6,
      minHeight: 0
    },

    icon: {
      backgroundColor: '#efefef',
      width: 40,
      height: 40,
      borderRadius: 20
    },

    title: {
      marginHorizontal: 8,
      fontSize: 15,
      textAlign:'left',
      height: 30,
      lineHeight: 30,
      color: '#333333'
    },
    contentText: {
      fontSize: 16,
      color: '#1c1c1c',
      lineHeight: 20,
    },
    line:{
      backgroundColor: '#efefef',
      height: 1,
      marginTop: 20,
    }
});

class ListView extends React.Component {
  dataList = [];

  constructor (props) {
    super(props);
    this.state = {
      refreshing: false
    }

    this.handleRefresh();
  }

  render() {
    return (
      <SafeAreaView style={styles.container}>
        <FlatList
          data={this.dataList}
          renderItem={this.renderCellItem}
          initialNumToRender={16}
          initialScrollIndex={0}
          keyExtractor={item => item.id}
          refreshing={this.state.refreshing}
          onRefresh={this.handleRefresh}
          onEndReached={this.handleLoadMore}
        />
      </SafeAreaView>
    )
  }


  renderCellItem = ({ item }) => (
    <ListCellItem title={item.title} content={item.content} icon={item.icon}/>
  );

  pageNum = 0
  handleRefresh = () => {
    this.setState({
      refreshing: true,
    });

    this.pageNum = 0;
    this.startRequestDataList(' refresh', this.pageNum, (success, list)=>{
      this.dataList.splice(0, this.dataList.length)
      list.forEach((value)=>{
        this.dataList.push(value)
      });

      this.setState({
        refreshing: false,
      });
    });
  }

  handleLoadMore= ()=>{
    this.startRequestDataList(' more', this.pageNum, (success, list)=>{
      list.forEach((value)=>{
        this.dataList.push(value)
      });
    });
  }

  startRequestDataList(prefix, page, callBack) {
    url = 'https://www.fastmock.site/mock/4754dc7fe47c878f8ac1e5cc89dce04a/smart/list'
    networkHandler = new NetworkManager;
    networkHandler.postRequest(url, '{}', (response)=>{
      callBack(true, response.body.list);
    },(err)=>{
      alert(err);
    });
  }
  // startRequestDataList(prefix, page, callBack) {
  //   setTimeout(()=>{
  //     startIndex = page * 10;
  //
  //     list = []
  //     for(var i=startIndex; i< 10+startIndex; i++) {
  //       list.push({
  //         id:i,
  //         icon: require('./resources/static_image.png'),
  //         title: '李爱老师 ' + i + prefix,
  //         content:'我们班的小主持人手工真是棒棒哒、我们班的小主持人讲故事真是棒棒哒、我们班的小主持人讲故事真是棒棒哒、我们班的小主持人讲故事真是棒棒哒！'})
  //     }
  //
  //     if (list.length > 0) {
  //       this.pageNum += 1;
  //     }
  //
  //     callBack(true, list)
  //   }, 1 * 1000);
  // }
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
});



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

/* 代码中只会被创建一次 */
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
  导出组件
*******************************************************/
export {HelloWorld};
