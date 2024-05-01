## data cleaning/preprocessing
library(dplyr)
ppg<- Player.Per.Game %>%
  filter(season>=1980 & season<=2023)
ppg<-ppg %>%
  select(player, tm, season, pts_per_game)
team_per_game<-Team.Stats.Per.Game %>%
  filter(season>=1980 & season<=2023)
team_per_game$tm<-team_per_game$abbreviation
team_per_game<-team_per_game %>%
  select(season, tm, pts_per_game)
team_sum<-Team.Summaries %>%
  filter(season>=1980 & season<=2023)
team_sum$tm<-team_sum$abbreviation
team_sum<-team_sum %>%
  select(season, tm, playoffs, w)
merged_table<-merge(ppg, team_per_game, by = c("tm", "season"))
merged_df<-merge(merged_table, team_sum, by = c("tm", "season"))
write.csv(merged_df, "basketball_data.csv", row.names = FALSE)
# Define a function to map old team abbreviations to new ones
map_team <- function(old_tm) {
  team_mapping <- c("ATL" = "ATL", "BOS" = "BOS", "BRK" = "BRK", "CHI" = "CHI",
                    "CHO" = "CHO", "CLE" = "CLE", "DAL" = "DAL", "DEN" = "DEN",
                    "DET" = "DET", "GSW" = "GSW", "HOU" = "HOU", "IND" = "IND",
                    "LAC" = "LAC", "LAL" = "LAL", "MEM" = "MEM", "MIA" = "MIA",
                    "MIL" = "MIL", "MIN" = "MIN", "NOP" = "NOP", "NYK" = "NYK",
                    "OKC" = "OKC", "ORL" = "ORL", "PHI" = "PHI", "PHO" = "PHO",
                    "POR" = "POR", "SAC" = "SAC", "SAS" = "SAS", "TOR" = "TOR",
                    "UTA" = "UTA", "WAS" = "WAS", "SEA" = "OKC", "NJN" = "BRK",
                    "VAN" = "MEM", "NOH" = "NOP", "NOK" = "NOP", "WSB" = "WAS",
                    "SDC" = "LAC", "KCK" = "SAC", "CHA" = "CHO", "CHH" = "CHO")
  
  return(team_mapping[old_tm])
}

# Update the tm column with the current team names
basketball_data$tm <- map_team(basketball_data$tm)

# Print the updated dataframe
print(basketball_data)
write.csv(basketball_data, "bball_current.csv", row.names = FALSE)
ts_nba<-ts(nba_updated_data)

