let executionCount = 0;

exports.handler = async (event, context) => {
	console.log('Echo received event:', JSON.stringify(event, null, 2));
	console.log('Echo received context:', JSON.stringify(context, null, 2));

	const tokenData = JSON.parse(event.requestContext.authorizer.tokenData)
	if (!tokenData.privs.includes('echo1')) {
		return {statusCode: 401, body: JSON.stringify({message: "privs don't include echo1"})};
	}

	executionCount++;
	const responseBody = {
		name: 'echo1',
		date: new Date().toString(),
		executionCount: executionCount,
		authorizerData: tokenData
	};
	const response = {statusCode: 200, body: JSON.stringify(responseBody)};
	console.log("response: " + JSON.stringify(response))
	return response;
};