SELECT
    DATE_TRUNC('day', block_time) AS day,
    COUNT(DISTINCT taker) AS unique_whale_wallets,
    COUNT(*) AS total_swaps,
    SUM(amount_usd) AS total_volume_usd,
    AVG(amount_usd) AS avg_swap_size_usd
FROM dex.trades
WHERE project = 'uniswap'
    AND blockchain = 'ethereum'
    AND block_time >= NOW() - INTERVAL '90' DAY
    AND amount_usd >= 100000
GROUP BY 1
ORDER BY 1 ASC
