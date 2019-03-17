/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * 
 *
 * @format
 * @flow
 */

import React, { Component } from 'react';
import {
  Platform, 
  StyleSheet, 
  Text, 
  Button, 
  View, 
  ToastAndroid, 
  NativeModules,
} from 'react-native';

import HelloWorld from './src/components/HelloWorld';
import ToastExample from './src/components/ToastExample';
// import CaptchaModule from './src/components/CaptchaModule';


export default class App extends Component {
  render() {
    const onPressLearnMore = async () => {
      // ToastAndroid.show("A pikachu appeared nearby !", ToastAndroid.SHORT);
      // ToastExample.show("Awesome", ToastExample.SHORT);
      NativeModules.CaptchaModule.showCaptcha();
      // try {
      //   const res = await NativeModules.CaptchaHelper.showCaptcha();
      //   const { success, captchaData } = res;
      //   if (success) {
      //     // ToastAndroid.show(`验证通过，captchaData=${JSON.stringify(captchaData)}`, ToastAndroid.SHORT);
      //   }
      // } catch(e) {
      //   // ToastAndroid.show(`errorCode=${e.code}, errorMessage=${e.message}`, ToastAndroid.SHORT);
      // }
    }
  
    return (
      <View style={{ flex: 1, justifyContent: "center", alignItems: "center" }}>
        {/* <HelloWorld></HelloWorld> */}
        <Button 
          title="提 交"
          onPress={onPressLearnMore}
        />
      </View>
    )
  }
}

// import React, {Component} from 'react';
// import {Platform, StyleSheet, Text, View} from 'react-native';

// const instructions = Platform.select({
//   ios: 'Press Cmd+R to reload,\n' + 'Cmd+D or shake for dev menu',
//   android:
//     'Double tap R on your keyboard to reload,\n' +
//     'Shake or press menu button for dev menu',
// });

// type Props = {};
// export default class App extends Component<Props> {
//   render() {
//     return (
//       <View style={styles.container}>
//         <Text style={styles.welcome}>Welcome to React Native! 222 333</Text>
//         <Text style={styles.instructions}>To get started, edit App.js</Text>
//         <Text style={styles.instructions}>{instructions}</Text>
//       </View>
//     );
//   }
// }

// const styles = StyleSheet.create({
//   container: {
//     flex: 1,
//     justifyContent: 'center',
//     alignItems: 'center',
//     backgroundColor: '#F5FCFF',
//   },
//   welcome: {
//     fontSize: 20,
//     textAlign: 'center',
//     margin: 10,
//   },
//   instructions: {
//     textAlign: 'center',
//     color: '#333333',
//     marginBottom: 5,
//   },
// });
