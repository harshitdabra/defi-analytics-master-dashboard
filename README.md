# DeFi Analytics Master Dashboard

Dune Analytics queries covering DEX volume and fees, stablecoin peg monitoring, whale wallet tracking, token unlocks, gas analytics, NFT market activity, and ETH price on Ethereum mainnet.

Live dashboard: https://dune.com/harshit_dabra/defi-analytics-master-dashboard

## Queries

### DEX Volume & Fee Analysis

`01_dex_daily_volume_by_protocol.sql` tracks daily trading volume by protocol across major Ethereum DEXs.

`02_dex_volume_market_share.sql` computes market share by protocol over the last 30 days.

`03_dex_daily_fee_revenue_by_protocol.sql` tracks estimated daily fee revenue by protocol.

`04_dex_summary_stats.sql` computes 30-day aggregate stats: total volume, trade count, estimated fee revenue, and active protocol count.

### Stablecoin Peg Monitor

`05_stablecoin_price_vs_peg.sql` tracks USDC and USDT price deviation from the $1 peg over the last 90 days.

`06_stablecoin_transfer_volume.sql` tracks daily USDC/USDT transfer volume over the last 30 days.

`07_stablecoin_depeg_events.sql` flags depeg events where price deviation exceeds 0.1% over the last 90 days.

`08_stablecoin_worst_depeg_by_token.sql` ranks the worst depeg percentage by stablecoin over the last 90 days.

### Whale Wallet Tracker

`09_uniswap_top_whale_swappers.sql` ranks the top 50 wallets by USD volume on Uniswap over the last 90 days.

`10_whale_wallet_clustering_aave_uniswap.sql` clusters wallets active across both Aave and Uniswap.

`11_daily_whale_activity_uniswap.sql` tracks daily count of unique whale wallets and volume for trades over $100k on Uniswap.

### Token Unlock Tracker

`12_token_unlock_value_by_project.sql` tracks total unlock tokens, percent of supply, and USD value by project over the next 90 days. Powers both the total tokens and unlock share by project charts.

### ETH Gas Analytics

`13_eth_daily_gas_analytics.sql` tracks daily gas price (avg, median, p90), transaction count, and total fees paid in ETH over the last 90 days.

### NFT Market Overview

`14_nft_daily_market_overview.sql` tracks daily NFT marketplace trade volume and activity on Ethereum over the last 90 days.

### ETH Price Tracker

`15_eth_daily_price_tracker.sql` tracks daily ETH price performance: average, minimum, and maximum over the last 90 days.

## Notes

Built with DuneSQL against Ethereum mainnet data, using the dex.trades, nft.trades, and prices.usd spellbook tables among others. This dashboard is for informational and educational purposes only and is not financial advice.

## About

Built by Harshit Dabra.
