SELECT
    DATE_TRUNC('day', block_time) AS day,
        project AS dex_protocol,
            SUM(amount_usd) AS volume_usd
            FROM dex.trades
            WHERE block_time >= NOW() - INTERVAL '90' DAY
                AND blockchain = 'ethereum'
                    AND amount_usd IS NOT NULL
                        AND amount_usd > 0
                        GROUP BY 1, 2
                        ORDER BY 1 DESC, 3 DESC
