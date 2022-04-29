<template>
	<view class="content-view">
		<view class="article-list-view" v-for="(img, index) in imageList" @click="previewPhoto(index)">
			<image class="img" :src="img" mode="widthFix" fade-show="true"></image>
		</view>
	</view>
</template>

<script>	
	import {baseUrl} from '@/components/common/network.js'
	
	export default {
		data() {
			return {
				imageList:[],
				shareText: '厦门学校划片信息'
			}
		},
		methods: {
			previewPhoto(index) {
				if (index < this.imageList.length) {
					uni.previewImage({
						urls:this.imageList,
						current:this.imageList[index]
					})
				}
			}
		},
		onLoad(arg) {
			this.shareText = arg.share || '厦门学校划片信息';
			uni.setNavigationBarTitle({
				title:this.shareText,
			})
			
			let imgs = JSON.parse(arg.d||[])
			for (var i = 0; i < imgs.length; i++) {
				let key = imgs[i]
				if (key && key.length) {
					if (key.length>4 && key.substring(0, 4) == ('http')) {
						this.imageList.push(key)
					} else {
						this.imageList.push(baseUrl + key)
					}
				}
			}
			console.log(this.imageList)
		},
		onShareAppMessage(obj){
		    return {
		      title: this.shareText,
		    }
		},
		onShareTimeline(obj) {
			return {
				title: this.shareText,
			}
		}
	}
</script>

<style lang="scss" scoped>
.content-view{
	display: flex;
	flex-direction: column;
	justify-content: flex-start;
	align-items: center;
	
	padding: 10px 10px;
	height: 100%;
	// background-color: green;
	
	.article-list-view {
		// background-color: orange;
		flex:0 0;
	}
}
</style>
