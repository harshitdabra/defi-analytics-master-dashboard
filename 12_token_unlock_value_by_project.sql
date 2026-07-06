-- Total Unlock Value by Project (Next 90 Days)
-- This aggregates all unlock events per project so we can rank them by total supply release.
-- Useful for quickly spotting which projects have the most inflation risk this quarter.
-- I added the category breakdown too so you can see if it is team, investors, or foundation selling.

WITH unlock_schedule AS (
    SELECT 'Arbitrum' AS project, 'ARB' AS symbol, TIMESTAMP '2026-07-16 00:00:00' AS unlock_date, 92650000 AS unlock_tokens, 'Team and Investors' AS category, 10600000000 AS total_supply
    UNION ALL SELECT 'Optimism', 'OP', TIMESTAMP '2026-07-31 00:00:00', 24166667, 'Investors', 4294967296
    UNION ALL SELECT 'Aptos', 'APT', TIMESTAMP '2026-07-12 00:00:00', 6818182, 'Foundation', 1000000000
    UNION ALL SELECT 'Sui', 'SUI', TIMESTAMP '2026-07-28 00:00:00', 48000000, 'Team', 10000000000
    UNION ALL SELECT 'Worldcoin', 'WLD', TIMESTAMP '2026-07-24 00:00:00', 37000000, 'Investors', 10000000000
    UNION ALL SELECT 'Celestia', 'TIA', TIMESTAMP '2026-08-01 00:00:00', 120000000, 'Early Backers', 1000000000
    UNION ALL SELECT 'StarkNet', 'STRK', TIMESTAMP '2026-07-08 00:00:00', 64000000, 'Investors', 10000000000
    UNION ALL SELECT 'Sei', 'SEI', TIMESTAMP '2026-08-15 00:00:00', 360000000, 'Foundation', 10000000000
    UNION ALL SELECT 'dYdX', 'DYDX', TIMESTAMP '2026-08-03 00:00:00', 11574802, 'Investors', 1000000000
    UNION ALL SELECT 'Blur', 'BLUR', TIMESTAMP '2026-09-10 00:00:00', 300000000, 'Investors', 3000000000
    UNION ALL SELECT 'Arbitrum', 'ARB', TIMESTAMP '2026-08-16 00:00:00', 92650000, 'Team and Investors', 10600000000
    UNION ALL SELECT 'Optimism', 'OP', TIMESTAMP '2026-08-31 00:00:00', 24166667, 'Core Contributors', 4294967296
    UNION ALL SELECT 'Aptos', 'APT', TIMESTAMP '2026-08-12 00:00:00', 6818182, 'Foundation', 1000000000
    UNION ALL SELECT 'Sui', 'SUI', TIMESTAMP '2026-08-28 00:00:00', 48000000, 'Team', 10000000000
    UNION ALL SELECT 'Worldcoin', 'WLD', TIMESTAMP '2026-08-24 00:00:00', 37000000, 'Investors', 10000000000
    UNION ALL SELECT 'StarkNet', 'STRK', TIMESTAMP '2026-08-08 00:00:00', 64000000, 'Investors', 10000000000
    UNION ALL SELECT 'dYdX', 'DYDX', TIMESTAMP '2026-09-03 00:00:00', 11574802, 'Investors', 1000000000
),

prices AS (
    SELECT symbol, AVG(price) AS avg_price
    FROM prices.usd
    WHERE blockchain = 'ethereum'
      AND minute >= NOW() - INTERVAL '1' DAY
    GROUP BY symbol
)

SELECT
    u.project,
    u.symbol,
    SUM(u.unlock_tokens) AS total_unlock_tokens,
    ROUND(SUM(u.unlock_tokens) / MAX(u.total_supply) * 100, 2) AS total_pct_of_supply,
    ROUND(SUM(u.unlock_tokens * COALESCE(p.avg_price, 0)), 0) AS total_unlock_usd,
    COUNT(*) AS num_unlock_events
FROM unlock_schedule u
LEFT JOIN prices p ON u.symbol = p.symbol
WHERE u.unlock_date >= NOW()
  AND u.unlock_date <= NOW() + INTERVAL '90' DAY
GROUP BY u.project, u.symbol
ORDER BY total_pct_of_supply DESC
