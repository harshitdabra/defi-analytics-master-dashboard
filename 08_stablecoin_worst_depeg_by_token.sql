-- Stablecoin Depeg Summary Stats (90d)
-- Aggregate KPI stats for USDC and USDT on Ethereum over the last 90 days
-- Includes: min/max price, worst depeg %, total depeg hours, avg price

SELECT
    symbol,
    AVG(price) AS avg_price_90d,
    MIN(price) AS min_price_90d,
    MAX(price) AS max_price_90d,
    MAX(ABS(price - 1.0)) * 100 AS worst_depeg_pct,
    MIN(price - 1.0) * 100 AS worst_depeg_down_pct,
    MAX(price - 1.0) * 100 AS worst_depeg_up_pct,
    COUNT(CASE WHEN ABS(price - 1.0) > 0.001 THEN 1 END) AS depeg_minutes,
    COUNT(CASE WHEN ABS(price - 1.0) > 0.001 THEN 1 END) / 60.0 AS depeg_hours
FROM prices.usd
WHERE
    blockchain = 'ethereum'
    AND symbol IN ('USDC', 'USDT')
    AND minute >= NOW() - INTERVAL '90' DAY
GROUP BY 1
ORDER BY worst_depeg_pct DESC
