/**
 * @format
 */

import {  AppRegistry} from 'react-native';
import App from './components/App';
import {AppLDProvider}  from './components/ldsupport'
import config from './config.json'
import {  name as appName} from './app.json';
import React  from 'react';

AppRegistry.registerComponent(appName, (props) => App);
AppRegistry.setWrapperComponentProvider(  function () {
    
    return (props) => {
        return (
            <AppLDProvider config={config}>
                {props.children}
            </AppLDProvider>
        );
    };
    
});
