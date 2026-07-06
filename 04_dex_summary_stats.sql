SELECT
    SUM(amount_usd) AS total_volume_usd_30d,
        COUNT(*) AS total_trades_30d,
            SUM(amount_usd) * 0.003 AS total_estimated_fees_30d,
                COUNT(DISTINCT project) AS active_protocols
                FROM dex.trades
                WHERE block_time >= NOW() - INTERVAL '30' DAY
                    AND blockchain = 'ethereum'
                        AND amount_usd IS NOT NULL
                            AND amount_usd > 0
