import { StackNavigator } from 'react-navigation';
import Login from './pages/Login';
import Home from './pages/Home';

const RootStack = StackNavigator(
  {
    Home: {
      screen: Home,
    },
    Login: {
      screen: Login,
    },
  },
  {
    initialRouteName: 'Home',
  }
);

export default RootStack;
