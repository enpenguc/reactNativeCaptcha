import React, { Component } from "react";
import { Text, View, Button } from "react-native";
import { CaptchaModule } from '../nativeModules';

export default class Login extends Component {
  constructor(props) {
    super(props);
    this.state = {
      captchaData: "",
    };
  }
  render() {
    const onPressCaptcha = async () => {
      try {
        const appId = "2073347220";
        const res = await CaptchaModule.showCaptcha(appId);
        this.setState({
          captchaData: JSON.stringify(res)
        });
        if (res.ret === 0) {
          alert("验证通过");
        }
      } catch (e) {
        alert(`验证发生异常, error=${e.message}`);
      }
    };
    return (
      <View style={{ flex: 1, justifyContent: "center", alignItems: "center" }}>
        <Text>Hello world!</Text>
        <Text>验证返回值：</Text>
        <Text>{this.state.captchaData}</Text>
        <Button title="获取验证码" onPress={onPressCaptcha} />
      </View>
    );
  }
}
