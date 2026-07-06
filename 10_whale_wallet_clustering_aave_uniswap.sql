WITH aave_whales AS (
    SELECT
        onBehalfOf AS wallet,
        COUNT(*) AS aave_deposits,
        SUM(CAST(amount AS DOUBLE) / 1e18) AS aave_volume_raw
    FROM aave_v2_ethereum.LendingPool_evt_Deposit
    WHERE evt_block_time >= NOW() - INTERVAL '365' DAY
    GROUP BY 1
    HAVING COUNT(*) >= 5
),
uniswap_whales AS (
    SELECT
        taker AS wallet,
        COUNT(*) AS uni_swaps,
        SUM(amount_usd) AS uni_volume_usd
    FROM dex.trades
    WHERE project = 'uniswap'
        AND blockchain = 'ethereum'
        AND block_time >= NOW() - INTERVAL '90' DAY
        AND amount_usd > 10000
    GROUP BY 1
    HAVING COUNT(*) >= 5
)
SELECT
    a.wallet,
    a.aave_deposits,
    u.uni_swaps,
    u.uni_volume_usd,
    CASE
        WHEN a.aave_deposits >= 100 AND u.uni_swaps >= 1000 THEN 'Hyper Active'
        WHEN a.aave_deposits >= 20 AND u.uni_swaps >= 100 THEN 'High Frequency'
        WHEN a.aave_deposits >= 5 AND u.uni_swaps >= 20 THEN 'Regular'
        ELSE 'Occasional'
    END AS cluster
FROM aave_whales a
INNER JOIN uniswap_whales u ON a.wallet = u.wallet
ORDER BY u.uni_volume_usd DESC
LIMIT 50
