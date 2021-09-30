const getUserId = function (userInfo) {
    return userInfo.get('visa-id')
}

const getAccountParameters = function (userInfo) {
    return {
        'homePath': userInfo.get('homePath')
    }
}

const getUsername = function (userInfo) {
    return userInfo.get('preferred_username')
}

const getEmail = function (userInfo) {
    return userInfo.get('email')
}

module.exports = {
    getUserId: getUserId,
    getAccountParameters: getAccountParameters,
    getUsername: getUsername,
    getEmail: getEmail
};