-- Create the player_stats table
CREATE TABLE player_stats (
    Rk INT,
    Player VARCHAR(100),
    Nation VARCHAR(10),
    Pos VARCHAR(10),
    Squad VARCHAR(50),
    Comp VARCHAR(50),
    Age INT,
    Born INT,
    MP INT,
    Starts INT,
    Min INT,
    "90s" FLOAT,
    Goals FLOAT,
    Shots FLOAT,
    SoT FLOAT,
    "SoT%" FLOAT,
    "G/Sh" FLOAT,
    "G/SoT" FLOAT,
    ShoDist FLOAT,
    ShoFK FLOAT,
    ShoPK FLOAT,
    PKatt FLOAT,
    PasTotCmp FLOAT,
    PasTotAtt FLOAT,
    "PasTotCmp%" FLOAT,
    PasTotDist FLOAT,
    PasTotPrgDist FLOAT,
    PasShoCmp FLOAT,
    PasShoAtt FLOAT,
    "PasShoCmp%" FLOAT,
    PasMedCmp FLOAT,
    PasMedAtt FLOAT,
    "PasMedCmp%" FLOAT,
    PasLonCmp FLOAT,
    PasLonAtt FLOAT,
    "PasLonCmp%" FLOAT,
    Assists FLOAT,
    PasAss FLOAT,
    Pas3rd FLOAT,
    PPA FLOAT,
    CrsPA FLOAT,
    PasProg FLOAT,
    PasAtt FLOAT,
    PasLive FLOAT,
    PasDead FLOAT,
    PasFK FLOAT,
    TB FLOAT,
    PasPress FLOAT,
    Sw FLOAT,
    PasCrs FLOAT,
    CK FLOAT,
    CkIn FLOAT,
    CkOut FLOAT,
    CkStr FLOAT,
    PasGround FLOAT,
    PasLow FLOAT,
    PasHigh FLOAT,
    PaswLeft FLOAT,
    PaswRight FLOAT,
    PaswHead FLOAT,
    TI FLOAT,
    PaswOther FLOAT,
    PasCmp FLOAT,
    PasOff FLOAT,
    PasOut FLOAT,
    PasInt FLOAT,
    PasBlocks FLOAT,
    SCA FLOAT,
    ScaPassLive FLOAT,
    ScaPassDead FLOAT,
    ScaDrib FLOAT,
    ScaSh FLOAT,
    ScaFld FLOAT,
    ScaDef FLOAT,
    GCA FLOAT,
    GcaPassLive FLOAT,
    GcaPassDead FLOAT,
    GcaDrib FLOAT,
    GcaSh FLOAT,
    GcaFld FLOAT,
    GcaDef FLOAT,
    Tkl FLOAT,
    TklWon FLOAT,
    TklDef3rd FLOAT,
    TklMid3rd FLOAT,
    TklAtt3rd FLOAT,
    TklDri FLOAT,
    TklDriAtt FLOAT,
    "TklDri%" FLOAT,
    TklDriPast FLOAT,
    Press FLOAT,
    PresSucc FLOAT,
    "Press%" FLOAT,
    PresDef3rd FLOAT,
    PresMid3rd FLOAT,
    PresAtt3rd FLOAT,
    Blocks FLOAT,
    BlkSh FLOAT,
    BlkShSv FLOAT,
    BlkPass FLOAT,
    Int FLOAT,
    "Tkl+Int" FLOAT,
    Clr FLOAT,
    Err FLOAT,
    Touches FLOAT,
    TouDefPen FLOAT,
    TouDef3rd FLOAT,
    TouMid3rd FLOAT,
    TouAtt3rd FLOAT,
    TouAttPen FLOAT,
    TouLive FLOAT,
    DriSucc FLOAT,
    DriAtt FLOAT,
    "DriSucc%" FLOAT,
    DriPast FLOAT,
    DriMegs FLOAT,
    Carries FLOAT,
    CarTotDist FLOAT,
    CarPrgDist FLOAT,
    CarProg FLOAT,
    Car3rd FLOAT,
    CPA FLOAT,
    CarMis FLOAT,
    CarDis FLOAT,
    RecTarg FLOAT,
    Rec FLOAT,
    "Rec%" FLOAT,
    RecProg FLOAT,
    CrdY FLOAT,
    CrdR FLOAT,
    "2CrdY" FLOAT,
    Fls FLOAT,
    Fld FLOAT,
    Off FLOAT,
    Crs FLOAT,
    TklW FLOAT,
    PKwon FLOAT,
    PKcon FLOAT,
    OG FLOAT,
    Recov FLOAT,
    AerWon FLOAT,
    AerLost FLOAT,
    "AerWon%" FLOAT
);

-- 1. OVERVIEW ANALYSIS: Player Distribution by Position and League
SELECT 
    Pos AS Position,
    COUNT(*) AS Player_Count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM player_stats), 2) AS Percentage
FROM player_stats
GROUP BY Pos
ORDER BY Player_Count DESC;

-- Note: This query analyzes the distribution of players across different positions
-- Conclusion: Shows which positions have the most representation in the dataset
-- Expected: Forwards and Midfielders likely dominate, reflecting attacking focus

-- 2. TOP SCORERS ANALYSIS: Players with Highest Goal Scoring Rate
SELECT 
    Player,
    Nation,
    Pos,
    Squad,
    Comp AS League,
    ROUND(Goals * 90.0 / Min, 4) AS Goals_Per_90,
    Goals,
    Min
FROM player_stats
WHERE Min >= 900  -- Minimum 10 full games played
ORDER BY Goals_Per_90 DESC
LIMIT 10;

-- Note: Calculates goals per 90 minutes to normalize scoring efficiency
-- Conclusion: Identifies the most clinical finishers regardless of playing time
-- Expected: Elite strikers from top leagues should dominate this list

-- 3. CREATIVE PLAYERS ANALYSIS: Top Assist Providers
SELECT 
    Player,
    Nation,
    Pos,
    Squad,
    Comp AS League,
    Assists,
    ROUND(Assists * 90.0 / Min, 4) AS Assists_Per_90,
    PasAss AS Key_Passes
FROM player_stats
WHERE Min >= 900
ORDER BY Assists_Per_90 DESC
LIMIT 10;

-- Note: Analyzes playmaking ability through assists and key passes
-- Conclusion: Shows the most creative players who create scoring opportunities
-- Expected: Attacking midfielders and wingers should feature prominently

-- 4. DEFENSIVE ANALYSIS: Most Effective Defenders
SELECT 
    Player,
    Nation,
    Pos,
    Squad,
    Comp AS League,
    Tkl AS Tackles,
    Int AS Interceptions,
    ROUND((TklWon * 100.0 / NULLIF(Tkl, 0)), 2) AS Tackle_Success_Rate,
    Blocks
FROM player_stats
WHERE Pos LIKE '%DF%' AND Min >= 900  -- Only defenders with significant minutes
ORDER BY (Tkl + Int) DESC
LIMIT 10;

-- Note: Evaluates defensive contributions through tackles, interceptions, and blocks
-- Conclusion: Identifies the most active and successful defenders
-- Expected: Central defenders from defensive-minded teams should excel

-- 5. PASSING MASTERS: Most Accurate Passers
SELECT 
    Player,
    Nation,
    Pos,
    Squad,
    Comp AS League,
    ROUND("PasTotCmp%", 1) AS Pass_Completion_Rate,
    PasTotCmp AS Passes_Completed,
    PasTotAtt AS Passes_Attempted
FROM player_stats
WHERE Min >= 900 AND PasTotAtt >= 500
ORDER BY "PasTotCmp%" DESC
LIMIT 10;

-- Note: Analyzes passing accuracy among players with significant passing volume
-- Conclusion: Shows players with the best ball distribution skills
-- Expected: Central midfielders and defenders from possession-based teams

-- 6. YOUNG TALENTS: Promising Players Under 21
SELECT 
    Player,
    Nation,
    Pos,
    Squad,
    Comp AS League,
    Age,
    ROUND(Goals * 90.0 / Min, 4) AS Goals_Per_90,
    ROUND(Assists * 90.0 / Min, 4) AS Assists_Per_90,
    Min
FROM player_stats
WHERE Age < 21 AND Min >= 450  -- Young players with at least 5 games
ORDER BY (Goals + Assists) DESC
LIMIT 15;

-- Note: Identifies promising young players with significant contributions
-- Conclusion: Highlights future stars and breakout talents
-- Expected: Features players from development-focused clubs

-- 7. LEAGUE COMPARISON: Average Goals Per Game by League
-- CORRECTED: League Comparison Analysis for SQLite
SELECT 
    Comp AS League,
    COUNT(DISTINCT Player) AS Total_Players,
    ROUND(AVG(Goals * 90.0 / Min), 4) AS Avg_Goals_Per_90,
    ROUND(AVG(Shots), 2) AS Avg_Shots,
    ROUND(AVG("SoT%"), 2) AS Avg_Shot_Accuracy
FROM player_stats
WHERE Min >= 900
GROUP BY Comp
ORDER BY Avg_Goals_Per_90 DESC;

-- Note: Compares offensive output across different leagues
-- Conclusion: Shows which leagues are most productive and efficient in attack
-- Expected: Top leagues like Premier League and Bundesliga should rank high

-- 8. ALL-ROUND PERFORMERS: Players Excelling in Multiple Areas
SELECT 
    Player,
    Nation,
    Pos,
    Squad,
    Comp AS League,
    ROUND(Goals * 90.0 / Min, 4) AS Goals_Per_90,
    ROUND(Assists * 90.0 / Min, 4) AS Assists_Per_90,
    ROUND(Tkl * 90.0 / Min, 2) AS Tackles_Per_90,
    ROUND("PasTotCmp%", 1) AS Pass_Accuracy
FROM player_stats
WHERE Min >= 900
    AND Goals * 90.0 / Min >= 0.2  -- Minimum goal contribution
    AND Assists * 90.0 / Min >= 0.1  -- Minimum assist rate
    AND Tkl * 90.0 / Min >= 1.5  -- Defensive contribution
ORDER BY (Goals * 90.0 / Min + Assists * 90.0 / Min) DESC
LIMIT 10;

-- Note: Identifies complete players who contribute in attack, defense, and possession
-- Conclusion: Shows the most well-rounded players in the dataset
-- Expected: Box-to-box midfielders and modern fullbacks should feature

-- 9. SHOOTING EFFICIENCY: Most Clinical Finishers
SELECT 
    Player,
    Nation,
    Pos,
    Squad,
    Comp AS League,
    ROUND("G/Sh", 3) AS Conversion_Rate,
    ROUND("SoT%", 1) AS Shot_On_Target_Percentage,
    Goals,
    Shots AS Total_Shots,
    SoT AS Shots_On_Target
FROM player_stats
WHERE Min >= 900 AND Shots >= 20  -- Minimum shooting volume
ORDER BY "G/Sh" DESC
LIMIT 10;

-- Note: Analyzes shooting efficiency and accuracy
-- Conclusion: Identifies players who make the most of their chances
-- Expected: Elite strikers with high conversion rates

-- 10. TEAM ANALYSIS: Squad with Most Productive Attackers
SELECT 
    Squad AS Team,
    Comp AS League,
    COUNT(*) AS Attacking_Players,
    ROUND(SUM(Goals), 1) AS Total_Goals,
    ROUND(SUM(Assists), 1) AS Total_Assists,
    ROUND(AVG(Goals * 90.0 / Min), 4) AS Avg_Goals_Per_90
FROM player_stats
WHERE Min >= 900 AND Pos IN ('FW', 'MFFW', 'FWMF')
GROUP BY Squad, Comp
ORDER BY Total_Goals DESC
LIMIT 10;
