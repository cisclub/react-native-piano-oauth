# react-native-piano-oauth

## Getting started

`$ npm install react-native-piano-oauth --save`

### Mostly automatic installation

`$ react-native link react-native-piano-oauth`

## Usage
```javascript
import PianoOAuth from 'react-native-piano-oauth';

PianoOAuth.signInWithAID(
  '<AID>',
  'https://sandbox.tinypass.com',
  (token, error) => {
    console.log(token, " ", error);
  },
  () => {
    console.log("Login cancelled");
  },
);
```
