
// const baseUrl = 'http://localhost:8080/'
const baseUrl = 'https://res.allinstem.com/edu/'

function request(path, method, data) {
	return new Promise(function(resolve, reject) {
		uni.request({
		    url: baseUrl + path,
		    success: (res) => {
		        console.log(res.data);
				resolve(res.data);
		    },
			fail: (error) => {
				console.log(error);
				reject(error);
			}
		});
	});
}

function getRequest(path, headers={}) {
	console.log(headers)
	return new Promise(function(resolve, reject) {
		uni.request({
		    url: baseUrl + path,
			header: headers,
			method:'GET',
		    success: (res) => {
		        console.log(res.data);
				resolve(res.data);
		    },
			fail: (error) => {
				console.log(error);
				reject(error);
			}
		});
	});
}
export {request, getRequest, baseUrl};