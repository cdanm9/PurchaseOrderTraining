const xsenv = require('@sap/xsenv')
const UAA_CREDENTIALS = xsenv.getServices({myXsuaa: {tag: 'xsuaa'}}).myXsuaa

const express = require('express')
const app = express();
const xssec = require('@sap/xssec')
const passport = require('passport')
const JWTStrategy = xssec.JWTStrategy
passport.use('JWT', new JWTStrategy(UAA_CREDENTIALS))
app.use(passport.initialize())
app.use(express.json())


// start server
app.listen(process.env.PORT)


app.get('/endpoint', passport.authenticate('JWT', {session: false}), (req, res) => {
    const auth = req.authInfo  
    console.log(`===> [backendapp] called by user '${auth.getGivenName()}' from subdomain '${auth.getSubdomain()}' with oauth client: '${auth.getClientId()}'`)
    res.json({
        'message': 'BACKEND successfully called',
        'jwtToken': auth.getAppToken()})
})