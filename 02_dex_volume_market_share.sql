SELECT
    project AS dex_protocol,
        SUM(amount_usd) AS total_volume_usd,
            COUNT(*) AS trade_count,
                SUM(amount_usd) / NULLIF(COUNT(*), 0) AS avg_trade_size_usd
                FROM dex.trades
                WHERE block_time >= NOW() - INTERVAL '30' DAY
                    AND blockchain = 'ethereum'
                        AND amount_usd IS NOT NULL
                            AND amount_usd > 0
                            GROUP BY 1
                            ORDER BY 2 DESC
                            LIMIT 20
