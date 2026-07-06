-- USDC/USDT Daily Price vs $1 Peg (90d)
-- Tracks daily average price of USDC and USDT on Ethereum vs $1.00 peg
-- Depeg % = ABS(price - 1.00) / 1.00 * 100

SELECT
    DATE_TRUNC('day', minute) AS day,
    symbol,
    AVG(price) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    ABS(AVG(price) - 1.0) AS depeg_abs,
    ABS(AVG(price) - 1.0) / 1.0 * 100 AS depeg_pct
FROM prices.usd
WHERE
    blockchain = 'ethereum'
    AND symbol IN ('USDC', 'USDT')
    AND minute >= NOW() - INTERVAL '90' DAY
GROUP BY 1, 2
ORDER BY 1 DESC, 2
