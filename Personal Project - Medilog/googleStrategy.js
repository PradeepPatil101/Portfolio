const passport = require("passport");
const GoogleStrategy = require("passport-google-oauth20").Strategy;
const config = require("./config")

var userProfile;

function extractProfile(profile) {
    let imageUrl = "";
    if (profile.photos && profile.photos.length) {
        imageUrl = profile.photos[0].value;
    }
    return {
        id: profile.id,
        displayName: profile.displayName,
        image: imageUrl,
    };

}

function getUserProfile() {
    return userProfile;
}

passport.use(new GoogleStrategy({
        clientID: config.clientId,
        clientSecret: config.secret,
        callbackURL: config.callback,
        accessType: "offline",
        userProfileURL: "",
    },
    (accessToken, refreshToken, profile, cb) => {
        userProfile = profile;
        cb(null, extractProfile(profile));
    }));
passport.serializeUser((user, cb) => {
    cb(null, user);
});
passport.deserializeUser((obj, cb) => {
    cb(null, obj);
});

module.exports = { getUserProfile: getUserProfile };