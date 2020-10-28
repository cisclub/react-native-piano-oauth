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
        endpointURL: String,
        widgetType: Int,
        didSignInCallbackHandler = ({token, error}) => {},
        didCancelSignInCallbackHandler = () => {}) 
    {
        PianoOauthModule.signInWithAID(
            aid,
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
