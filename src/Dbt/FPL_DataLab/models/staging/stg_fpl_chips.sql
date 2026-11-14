SELECT 
    Chip_Name as chip_name,
    Start_Gameweek as start_gameweek,
    End_Gameweek as end_gameweek,
    chip_type 
from {{ source('fpl', 'fpl_chips')}}
