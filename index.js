import { NativeModules } from 'react-native';

const PianoOauthModule = NativeModules.PianoOAuth;

const PianoOauth = {
    /*
     * @param aid                               set this value to <PUBLISHER_AID>
     * @param endpointURL
     * @param signInCallbackHandler             callback handler called after user sign in.
     * @param didCancelSignInCallbackHandler    callback handler called when user cancel sign in.
     */
    signInWithAID(
        aid: String,
        googleCID: String,
        endpointURL: String,
        widgetType: Int,
        didSignInCallbackHandler = ({payload}) => {},
        didCancelSignInCallbackHandler = () => {}) 
    {
        PianoOauthModule.signInWithAID(
            aid,
            googleCID,
            endpointURL,
            widgetType,
            didSignInCallbackHandler,
            didCancelSignInCallbackHandler);
    },

    /*
     * @param token                     token of user to sign out.
     * @param signOutCallbackHandler    callback handler called after sign out.
     */
    signOutWithToken(
        token: String,
        didSignOutCallbackHandler = (error) => {}) 
    {
        PianoOauthModule.signOutWithToken(
            token,
            didSignOutCallbackHandler);
    }
};

export default PianoOauth;

export const WidgetType = {
  Login: 0,
  Register: 1
}
