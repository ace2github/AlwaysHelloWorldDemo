<template>
	<view class="list_content_view">
		<view class="cell_content" v-for="(item, index) in newList" @click="cellClickHandler(index)">
			<view class="cell_left">
				<view class="tint"></view>
				<text class="new_title">{{item.title}}</text>
			</view>
			<image src="@/static/icon_arrow.png" style="width: 15rpx; height: 25rpx; padding: 5px;"></image>
		</view>
	</view>
</template>

<script>
	import {getRequest} from '@/components/common/network.js'
	import {showLoading, showToast} from '@/components/common/tools.js'
	
	export default {
		data() {
			return {
				newList:[]
			}
		},
		methods: {
			cellClickHandler(index) {
				var item = this.newList[index];
				uni.navigateTo({
					url:"../index/imagearticle?d=" + JSON.stringify(item.imgs) + "&share=" + item.title
				});
			},
			
			startRequestNewList(isRefresh) {
				showLoading(true);
				// 5分钟时间间隔，需要添加次后缀，否则存在资源缓存问题
				let time = parseInt((new Date()).getTime() / 1000 / 60 / 5)
				getRequest('plan?'+time, {"Cache-Control": "no-cache, max-age=360"}).then((response)=>{
					let res = response.plan
					this.newList = res.articleList;
					console.log(this.newList)
					showLoading(false);
				}).catch((e)=>{
					showLoading(false);
				});
			}
		},
		onLoad() {
			this.startRequestNewList(true);
		},
		onReachBottom() {
			
		},
		onPullDownRefresh() {
			
		},
		onShareAppMessage(obj){
		    return {
		      title: "厦门幼儿园、小学、初中划片资讯~~~",
		    }
		},
		onShareTimeline(obj) {
			return {
				title: "厦门幼儿园、小学、初中划片资讯~~~",
			}
		}
	}
	
</script>

<style lang="scss" scoped>
.list_content_view {
	width: 100%;
	height: 100%;
	
	padding-left: 10rpx;
	padding-right: 10rpx;
	
	display: flex;
	flex-direction: column;
	background-color: #fff;
	
	.cell_content {
		padding-left: 15px;
		padding-right: 15px;
		
		min-height: 50px;
		
		display: flex;
		flex-direction: row;
		align-items: center;
		
		background-color: #ffffff;
		border-bottom: 1px solid #e5e6ea;
		
		.cell_left {
			flex-grow: 1;
			
			display: flex;
			flex-direction: row;
			flex-wrap: nowrap;
			align-items: center;
			
			.new_title {
				margin-left: 10px;
				width: 580rpx;
				
				overflow: hidden;
				white-space: nowrap;
				text-overflow: ellipsis;
				
				font-size: 14px;
				color: #1D2129;
			}
			
			.tint {
				width: 6px; 
				height: 6px; 
				border-radius: 6px;
				background-color: #e5e6ea;
			}
		}
	}
	
	
	
}
</style>
