<template>
	<view class="content">
		<view class="top-header">
			<view class="body-top"></view>
		</view>
		
		<view class="body-main">
			<view class="desc-content">
				<icon :type="info" size="26"/>
				<text>{{title}}</text>
			</view>
			<view class="body-content">
				<uniTable border stripe emptyText="暂无数据">
					<uniTr v-for="(list,index) in tblDataList" :key="obj.date">
						<uniTd v-for="(value,v_index) in list" >{{value}}</uniTd>
					</uniTr>
				</uniTable>
			</view>
		</view>
	</view>
</template>

<script>
	import {uniTable} from "@/uni_modules/uni-table/components/uni-table/uni-table";
	import {uniTr} from "@/uni_modules/uni-table/components/uni-tr/uni-tr";
	import {uniTd} from "@/uni_modules/uni-table/components/uni-td/uni-td";
	import {uniTh} from "@/uni_modules/uni-table/components/uni-th/uni-th";
	export default {
		components:{
			uniTable,uniTr,uniTd,uniTh
		},
		data() {
			return {
				title: "现行的LPR包括1年期和5年期以上两个品种。\n",
				tblDataList: reqeustLprDataList(),
			}
		},
		methods: {
			
		}
	}
	
	function reqeustLprDataList() {
		var list = 
		[
			["日期",  "1年期",  "5年期以上"],
			["2021-08-20",  "3.85",  "4.65"],
			["2021-07-20",  "3.85",  "4.65"],
			["2021-06-20",  "3.85",  "4.65"],
			["2021-05-20",  "3.85",  "4.65"],
			["2021-04-20",  "3.85",  "4.65"],
			["2021-03-20",  "3.85",  "4.65"],
		]
		
		list =
		[
			["日期",  "1年期",  "5年期以上"],
			["2021-08-20",  "3.85",  "4.65"],
			["2021-07-20",  "3.85",  "4.65"],
			["2021-06-20",  "3.85",  "4.65"],
			["2021-05-20",  "3.85",  "4.65"],
			["2021-04-20",  "3.85",  "4.65"],
			["2021-03-20",  "3.85",  "4.65"],
		]
		
		return list;
	}
</script>

<style>
	.content {
		width: 100%;
		height: 100%;
	}
	// header
	.top-header {
		width: 100%;
		height: 50rpx;
		background-color: #09D0B2;
		
		display: flex;
		flex-direction: column;
		justify-content: flex-end;
	}
	.body-top {
		width: 100%;
		height: 30rpx;
		border-top-right-radius: 30rpx;
		border-top-left-radius: 30rpx;
		background-color: #fff;
	}
	
	// body
	.body-main {
		margin: 20rpx 15rpx 0rpx 15rpx;
		display: flex;
		flex-direction: column;
		justify-content: space-between;
		align-items: stretch;
		flex-wrap: wrap;
	}
	
	.desc-content {
		display: flex;
		flex-direction: row;
		justify-content: flex-start;
	}
	.desc-content text {
		font-size: 26rpx;
		line-height: 26rpx;
	}
	
	.body-content {
		height: 500rpx;
		width: 100%;
		margin-top: 40rpx;
	}
</style>
