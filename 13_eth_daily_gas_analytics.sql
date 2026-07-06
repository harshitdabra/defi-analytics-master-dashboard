-- ETH Daily Gas Analytics (90d)
SELECT
    DATE_TRUNC('day', block_time) AS day,
        ROUND(AVG(gas_price / 1e9), 2) AS avg_gas_price_gwei,
            ROUND(APPROX_PERCENTILE(gas_price / 1e9, 0.5), 2) AS median_gas_gwei,
                ROUND(APPROX_PERCENTILE(gas_price / 1e9, 0.9), 2) AS p90_gas_gwei,
                    COUNT(*) AS total_txns,
                        ROUND(SUM(CAST(gas_used AS DOUBLE) * CAST(gas_price AS DOUBLE) / 1e18), 2) AS total_fees_eth
                        FROM ethereum.transactions
                        WHERE block_time >= NOW() - INTERVAL '90' DAY
                            AND success = true
                            GROUP BY 1
                            ORDER BY 1 ASC
