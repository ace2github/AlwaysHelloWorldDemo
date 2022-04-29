function showLoading(show, title) {
	if (show) {
		uni.showLoading({
		    title: title ? title : '加载中...',
		});
	} else {
		uni.hideLoading();
	}
}

function showToast(message, icon) {
    return uni.showToast({
        title: message,
        duration: 2000
    })
}

export {showLoading, showToast};