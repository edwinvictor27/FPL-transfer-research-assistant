SELECT
    id AS player_id,
    first_name AS player_first_name,
    second_name AS player_last_name,
    web_name AS player_display_name,

    influence_rank AS overall_influence_rank,
    influence_rank_type AS position_specific_influence_rank,

    creativity_rank AS overall_creativity_rank,
    creativity_rank_type AS position_specific_creativity_rank,

    threat_rank AS overall_threat_rank,
    threat_rank_type AS position_specific_threat_rank,

    ict_index_rank AS overall_ict_index_rank,
    ict_index_rank_type AS position_specific_ict_index_rank,

    now_cost_rank AS overall_price_rank,
    now_cost_rank_type AS position_specific_price_rank,

    form_rank AS overall_form_rank,
    form_rank_type AS position_specific_form_rank,

    points_per_game_rank AS overall_points_per_game_rank,
    points_per_game_rank_type AS position_specific_points_per_game_rank,

    selected_rank AS overall_selection_popularity_rank,
    selected_rank_type AS position_specific_selection_popularity_rank

FROM {{ ref('stg_fpl_player_data') }}