<template>
	<view class="content">
		<view class="header">
			<view class="header_top"></view>
			<view class="banner">
				<image class="banner_image" src="https://pic.quanjing.com/ux/58/QJ6551561157.jpg?x-oss-process=style/794ws" mode="aspectFill"></image>
			</view>
		</view>
		
		<view class="body-area">
			<view class="item-cell" v-for="(obj,index) in dataList">
				<view class="cell-content" @click="cellClickhandler(index)">
					<view class="module-c">
						<text>{{obj.title}}</text>
					</view>
					<view class="cell-main">
						<text>{{obj.desc}}</text>
					</view>
				</view>
				<view style="height: 1px; background-color: #efefef;"></view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				title: 'Hello',
				dataList: [
					{"title": "LPR", "desc": "desc \nxxx"},
					{"title": "CPI", "desc": "desc xxx"},
					{"title": "油价", "desc": "desc xxx"},
					{"title": "xxx", "desc": "desc xxx"},
					{"title": "xxx", "desc": "desc xxx"},
				]
			}
		},
		onLoad() {

		},
		methods: {
			cellClickhandler(index){
				console.log('cell click', index)
				uni.navigateTo({
					url:"../detailbase/detailbase"
				})
			}
		}
	}
</script>

<style>
	.content {
		height: 100%;
		width: 100%;
	}
	
	.header {
		height: 240;
		width: 100%;
	}
	
	.header_top {
		height: 80rpx;
		width: 100%;
		background-color: #09D0B2;
	}
	
	// banner
	.banner {
		height: 220rpx;
		margin: -60rpx 10rpx 0rpx 10rpx;
	}
	
	.banner image {
		height: 100%;
		width: 100%;
		border-radius: 10rpx;
	}
	
	
	// body
	.body-area {
		margin: 20rpx 10rpx 0rpx 10rpx;
		display: flex;
		flex-direction: column;
		justify-content: space-between;
		align-items: stretch;
		flex-wrap: wrap;
	}
	

	// cell
	.item-cell {
		height: 120rpx;
	}
	.cell-content {
		height: 119rpx;
		
		display: flex;
		flex-direction: row;
		align-items: center;
	}
	.module-c {
		width: 100rpx;
		height: 100rpx;
		border-radius: 50rpx;
		background-color: #09D0B2;
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-items: center;
	}
	.module-c text {
		font-size: 30rpx;
		line-height: 30rpx;
		color: #FFFFFF;
	}
	
	.cell-main {
		margin-left: 20rpx;
	}
	.cell-main text {
		font-size: 26rpx;
		line-height: 26rpx;
		color: #000;
	}
</style>
