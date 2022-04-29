<template>
    <view class="basepage-content">
        <view class="basepage-header-top">
            <view class="basepage-body-top"></view>
        </view>
        <view class="basepage-body-main">
			<view class="basepage-desc-content">
			    <text> {{baseTitle}} </text>
			</view>
            
            <view class="basepage-body-content">
                <slot name="base-layout"></slot>
            </view>
        </view>
    </view>
</template>

<script>
    export default {
		props:{
			baseTitle: '',
		},
		
        data() {
            return {

            }
        },
		
        methods: {
            
        },
    }
</script>

<style scoped>
    .basepage-content {
        width: 100%;
        height: 100%;
		display: flex;
		flex-direction: column;
    }
	
    // header
    .basepage-header-top {
        width: 100%;
        height: 50rpx;
        background-color: #09D0B2;
        
        display: flex;
        flex-direction: column;
        justify-content: flex-end;
    }
    .basepage-body-top {
        width: 100%;
        height: 30rpx;
        border-top-right-radius: 30rpx;
        border-top-left-radius: 30rpx;
        background-color: #fff;
    }
    
    // body
    .basepage-body-main {
        margin: 20rpx 15rpx 0rpx 15rpx;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        align-items: stretch;
        flex-wrap: wrap;
    }
    
    .basepage-desc-content {
        display: flex;
        flex-direction: row;
        justify-content: flex-start;
    }
    .basepage-desc-content text {
        font-size: 26rpx;
        line-height: 40rpx;
    }
	
	.basepage-body-content {
		width: 100%;
		margin-top: 5rpx;
	}
</style>
