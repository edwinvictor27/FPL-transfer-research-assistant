WITH player_base AS (

    SELECT
        p.player_id,
        p.team_id,
        p.player_first_name,
        p.player_last_name,
        p.player_display_name,
        p.selected_by_percentage,
        c.team_short_name,
        c.team_code,
        c.football_club_name AS team_name

    FROM {{ ref('int_player_information') }} p

    LEFT JOIN {{ ref('stg_fpl_clubs') }} c
        ON p.team_id = c.team_id

),

player_positions AS (

    SELECT
        player_name,
        team_name,
        player_position
    FROM {{ ref('stg_fpl_defenders') }}

    UNION ALL

    SELECT
        player_name,
        team_name,
        player_position
    FROM {{ ref('stg_fpl_forwards') }}

    UNION ALL

    SELECT
        player_name,
        team_name,
        player_position
    FROM {{ ref('stg_fpl_goalkeepers') }}

    UNION ALL

    SELECT
        player_name,
        team_name,
        player_position
    FROM {{ ref('stg_fpl_midfielders') }}

)

SELECT
    p.*,
    pos.player_position

FROM player_base p

LEFT JOIN player_positions pos
    ON LOWER(TRIM(p.player_display_name)) = LOWER(TRIM(pos.player_name))
    AND LOWER(TRIM(p.team_name)) = LOWER(TRIM(pos.team_name))