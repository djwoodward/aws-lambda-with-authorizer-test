const jwt = require('jsonwebtoken');

const generatePolicy = (principalId, effect, verifiedToken = {}) => ({
	principalId: principalId,
	policyDocument: {
		Version: '2012-10-17',
		Statement: [
			{Action: 'execute-api:Invoke', Effect: effect, Resource: '*'}
		]
	},
	context: {
		"tokenData": JSON.stringify(verifiedToken)
	}
});

exports.handler = async function (event, context) {
	const authHeader = event.authorizationToken;

	console.log('event:', JSON.stringify(event, null, 2));
	console.log('context:', JSON.stringify(context, null, 2));

	const jwtToken = authHeader.replace('Bearer ', '')

	let policy;
	try {
		const verifiedToken = jwt.verify(jwtToken, process.env.PUBLIC_KEY);
		console.log('verifiedToken: ' + JSON.stringify(verifiedToken, null, 2));
		policy = generatePolicy(verifiedToken.sub, 'Allow', verifiedToken);
	} catch (e) {
		console.log('error: ' + e);
		policy = generatePolicy('unknown', 'Deny');
	}
	console.log('Returning Policy:', JSON.stringify(policy, null, 2));

	return policy;
};