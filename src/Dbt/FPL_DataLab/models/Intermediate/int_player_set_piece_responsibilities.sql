SELECT
    id AS player_id,
    corners_and_indirect_freekicks_order AS corners_and_indirect_free_kicks_priority,
    direct_freekicks_order AS direct_free_kicks_priority,
    penalties_order AS penalty_taking_priority
FROM {{ ref('stg_fpl_player_data') }}