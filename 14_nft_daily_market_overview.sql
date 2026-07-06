-- NFT Daily Market Overview - Ethereum (90d)
SELECT
    DATE_TRUNC('day', block_time) AS day,
        trade_category,
            COUNT(*) AS total_sales,
                ROUND(SUM(amount_usd), 0) AS volume_usd,
                    COUNT(DISTINCT buyer) AS unique_buyers,
                        COUNT(DISTINCT seller) AS unique_sellers
                        FROM nft.trades
                        WHERE blockchain = 'ethereum'
                            AND block_time >= NOW() - INTERVAL '90' DAY
                                AND amount_usd > 0
                                GROUP BY 1, 2
                                ORDER BY 1 ASC, 3 DESC
