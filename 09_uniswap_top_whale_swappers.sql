SELECT
    taker AS wallet,
        COUNT(*) AS swap_count,
            COUNT(DISTINCT token_bought_symbol) AS tokens_bought,
                SUM(amount_usd) AS total_volume_usd,
                    MIN(block_time) AS first_swap,
                        MAX(block_time) AS last_swap
                        FROM dex.trades
                        WHERE project = 'uniswap'
                            AND blockchain = 'ethereum'
                                AND block_time >= NOW() - INTERVAL '90' DAY
                                    AND amount_usd > 10000
                                    GROUP BY 1
                                    HAVING COUNT(*) >= 5
                                    ORDER BY total_volume_usd DESC
                                    LIMIT 50
