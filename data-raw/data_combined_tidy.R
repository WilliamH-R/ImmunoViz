## code to prepare `data_combined_tidy` dataset goes here
data_combined_tidy <-
  dplyr::bind_rows(
    TCRSequenceFunctions::data_donor_one_tidy,
    TCRSequenceFunctions::data_donor_two_tidy,
    TCRSequenceFunctions::data_donor_three_tidy,
    TCRSequenceFunctions::data_donor_four_tidy
  )

usethis::use_data(data_combined_tidy, overwrite = TRUE)
