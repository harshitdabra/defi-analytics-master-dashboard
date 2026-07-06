-- USDC/USDT Depeg Events: Price Below $0.999 or Above $1.001 (90d)
-- Identifies specific hourly depeg events for USDC and USDT on Ethereum
-- Flags hours where price deviated more than 0.1% from the $1 peg

SELECT
    DATE_TRUNC('hour', minute) AS hour,
    symbol,
    AVG(price) AS avg_price,
    AVG(price) - 1.0 AS peg_deviation,
    ABS(AVG(price) - 1.0) / 1.0 * 100 AS depeg_pct,
    CASE
        WHEN AVG(price) < 0.999 THEN 'DEPEG_DOWN'
        WHEN AVG(price) > 1.001 THEN 'DEPEG_UP'
        ELSE 'STABLE'
    END AS depeg_status
FROM prices.usd
WHERE
    blockchain = 'ethereum'
    AND symbol IN ('USDC', 'USDT')
    AND minute >= NOW() - INTERVAL '90' DAY
GROUP BY 1, 2
HAVING ABS(AVG(price) - 1.0) > 0.001
ORDER BY ABS(AVG(price) - 1.0) DESC
LIMIT 500
