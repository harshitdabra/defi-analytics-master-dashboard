-- ETH Daily Price Tracker (90d)
SELECT
    DATE_TRUNC('day', minute) AS day,
        ROUND(AVG(price), 2) AS avg_price_usd,
            ROUND(MIN(price), 2) AS low_price_usd,
                ROUND(MAX(price), 2) AS high_price_usd,
                    ROUND((MAX(price) - MIN(price)) / MIN(price) * 100, 2) AS daily_range_pct
                    FROM prices.usd
                    WHERE symbol = 'ETH'
                        AND minute >= NOW() - INTERVAL '90' DAY
                        GROUP BY 1
                        ORDER BY 1 ASC
