# venv virtuaaliympäristö #
python -m venv --copies .venv 

# venv aktivointi
source .venv/Scripts/activate         

# tarkistus
which python                          


# dbt
dbt --version
dbt init dbt_example dbt_example` = luo kansion nimeltä dbt_example