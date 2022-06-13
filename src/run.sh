#! /bin/bash

# start a timer
SECONDS=0

# # # run downloaders

echo -e "\n\n======================================\n\n"
echo -e "Running downloaders"
echo -e "\n\n======================================\n\n"
. src/run_downloaders.sh

# # # run transformers

echo -e "\n\n======================================\n\n"
echo -e "Running transformers"
echo -e "\n\n======================================\n\n"
. src/run_transformers.sh

# # run mapping

echo -e "\n\n======================================\n\n"
echo -e "Mapping data to postgres"
echo -e "\n\n======================================\n\n"
python src/match/1-mappings.py 

# # run matching

echo -e "\n\n======================================\n\n"
echo -e "Running match algorithms"
echo -e "\n\n======================================\n\n"
python src/match/2-matching.py 

# run superjoin

echo -e "\n\n======================================\n\n"
echo -e "Running superjoin"
echo -e "\n\n======================================\n\n"
python src/match/3-superjoin.py 

# run model 

echo -e "\n\n======================================\n\n"
echo -e "Generating model predictions"
echo -e "\n\n======================================\n\n"
Rscript -e "source('src/model/01_preprocess.R');"
Rscript -e "source('src/model/02_linear.R');"

# combine tiers

echo -e "\n\n======================================\n\n"
echo -e "Combining tiers into one spatial wsb layer"
echo -e "\n\n======================================\n\n"
python src/combine_tiers.py

# end the timer
t=$SECONDS
echo -e "\n\n======================================\n\n"
printf 'Time elapsed: %d minutes' "$(( t/60 ))"
echo -e "\n\n======================================\n\n"
