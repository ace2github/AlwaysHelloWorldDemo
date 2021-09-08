/**
 * @format
 */

import {AppRegistry} from 'react-native';
import {HelloWorld, AppStackContainer, AppTabContainer, ComplexAppTabContainer} from './App';
import {name as appName} from './app.json';

AppRegistry.registerComponent(appName, () => HelloWorld);
