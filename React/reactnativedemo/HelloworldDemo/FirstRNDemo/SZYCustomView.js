// SZYCustomView.js
import PropTypes from 'prop-types';
import React from 'react';
import { requireNativeComponent } from 'react-native';

class SZYCustomView extends React.Component {
    // 点击NativeView的事件回调，也是通过导出 NativeView的类型为RCTBubblingEventBlock的block属性 实现。
    _onClickHandler = (event)=> {
      // console.log(event);
      if (!this.props.onClickHandler) {
        return;
      }

      this.props.onClickHandler(event.nativeEvent);
    }
    
    render() {
      return <RNSZYView {...this.props} onClickHandler={this._onClickHandler}/>;
    }
}

SZYCustomView.propTypes = {
    touchEnabled: PropTypes.bool,
    onClickHandler: PropTypes.func
};

  
// RNSZYView 为原生导出组件名（iOS：RCT_EXPORT_MODULE(RNSZYView)）
const RNSZYView = requireNativeComponent('RNSZYView', SZYCustomView);

export default SZYCustomView;