-- USDC/USDT Transfer Flows During Stress Events (30d)
-- Tracks daily stablecoin transfer volume and count on Ethereum
-- Uses tokens_ethereum.transfers (spellbook) which has standardized column names

WITH daily_transfers AS (
    SELECT
        DATE_TRUNC('day', block_time) AS day,
        symbol,
        COUNT(*) AS transfer_count,
        SUM(amount_usd) AS volume_usd
    FROM tokens_ethereum.transfers
    WHERE
        symbol IN ('USDC', 'USDT')
        AND block_time >= NOW() - INTERVAL '30' DAY
        AND amount_usd IS NOT NULL
        AND amount_usd > 0
    GROUP BY 1, 2
)
SELECT
    day,
    symbol AS stablecoin,
    transfer_count,
    volume_usd,
    AVG(volume_usd) OVER (PARTITION BY symbol ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS rolling_7d_avg_volume
FROM daily_transfers
ORDER BY 1 DESC, 2
