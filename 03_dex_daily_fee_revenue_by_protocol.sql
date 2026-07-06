SELECT
    DATE_TRUNC('day', block_time) AS day,
        project AS dex_protocol,
            SUM(amount_usd) AS daily_volume_usd,
                SUM(amount_usd) * 0.003 AS estimated_fees_usd
                FROM dex.trades
                WHERE block_time >= NOW() - INTERVAL '30' DAY
                    AND blockchain = 'ethereum'
                        AND amount_usd IS NOT NULL
                            AND amount_usd > 0
                            GROUP BY 1, 2
                            ORDER BY 1 DESC, 3 DESC
