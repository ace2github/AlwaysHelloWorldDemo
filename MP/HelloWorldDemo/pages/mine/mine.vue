<template>
	<view class="content">
		<view class="cell-item" v-for="(title, index) in list">
			<text>{{ title }}</text>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				list: ['1', '2', '3', '4', '1', '2', '3', '4']
			}
		},
		methods: {
			
		}
	}
</script>

<style>
	.content {
		height: 100%;
		width: 100%;
	}
	.content {
		display: flex;
		flex-direction: row;
		flex-wrap: wrap;
	}

	.cell-item {
		width: 100px;
		height: 50px;
		background: orange;
		margin: 5px;
		
		display: flex;
		justify-content: center;
		align-items: center;
	}
</style>
