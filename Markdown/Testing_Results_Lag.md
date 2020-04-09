Lag in DC Test Results
================

## New Postive Results in DC Lag by About Four Days

The below plot show the number of Positive Tests in red and the number
of New Tests times the positive test rate in blue.

``` r
plot1 <- testing_test %>% 
  dplyr::mutate(Test_by_Pos_Rate = Test_New / (max(Tested_Overall)/max(Tested_Positive))) %>% 
  dplyr::select(Date, Pos_New, Test_by_Pos_Rate) %>% 
  tidyr::gather(key = "Test_Metric", value = "Number",
                Pos_New, Test_by_Pos_Rate)

ggplot(data = plot1, aes(x = Date)) +
  geom_line(aes(y = Number, color = Test_Metric), size = 1) +
  labs(title = "Positive Tests and Total Tests for Covid-19 in DC", y = "Tests", x = "Date") +
  scale_color_discrete(name = "Testing Metric by Day",
                       labels = c("Positve Tests",
                                  "Total Tests\n(times cumulative\npositive test rate)")) +
  theme(plot.title = element_text(hjust = 0.5))
```

![](Testing_Results_Lag_files/figure-gfm/same_day-1.png)<!-- -->

## Lagged test results

The below plot shows the number of Positive Tests in red and the number
of New Tests four days ago times the positive test rate in blue.

``` r
plot2 <- testing_test %>% 
  dplyr::mutate(Test_Lag_4_by_Pos_Rate = Test_Lag_4 / (max(Tested_Overall)/max(Tested_Positive))) %>% 
  dplyr::select(Date, Pos_New, Test_Lag_4_by_Pos_Rate) %>% 
  tidyr::gather(key = "Test_Metric", value = "Number",
                Pos_New, Test_Lag_4_by_Pos_Rate)

ggplot(data = plot2, aes(x = Date)) +
  geom_line(aes(y = Number, color = Test_Metric), size = 1) +
  labs(title = "Positive Tests and Lagged Total Tests for Covid-19 in DC",
       y = "Tests", x = "Date") +
  scale_color_discrete(name = "Testing Metric by Day",
                       labels = c("Positve Tests",
                                  "Total Tests 4 Days Ago\n(times cumulative\n positive test rate)")) +
  theme(plot.title = element_text(hjust = 0.5))
```

![](Testing_Results_Lag_files/figure-gfm/lag_4-1.png)<!-- -->

Here are the correlation matricies for those interested in such a thing.

``` r
cor(testing_test[6:ncol(testing_test)])
```

    ##             Test_New   Pos_New Test_Lag_1 Test_Lag_2 Test_Lag_3 Test_Lag_4
    ## Test_New   1.0000000 0.7896354  0.7882913  0.8306581  0.7169521  0.7388761
    ## Pos_New    0.7896354 1.0000000  0.7052579  0.8057446  0.7763158  0.9180961
    ## Test_Lag_1 0.7882913 0.7052579  1.0000000  0.7909807  0.8338953  0.7229599
    ## Test_Lag_2 0.8306581 0.8057446  0.7909807  1.0000000  0.7949991  0.8384835
    ## Test_Lag_3 0.7169521 0.7763158  0.8338953  0.7949991  1.0000000  0.8090459
    ## Test_Lag_4 0.7388761 0.9180961  0.7229599  0.8384835  0.8090459  1.0000000
    ## Test_Lag_5 0.6580893 0.7563592  0.7405630  0.7237436  0.8407823  0.8143756
    ## Test_Lag_6 0.7139655 0.8512888  0.6949720  0.7777661  0.7841002  0.8428988
    ## Test_Lag_7 0.6363658 0.8103285  0.7188805  0.6947253  0.7914377  0.7694673
    ##            Test_Lag_5 Test_Lag_6 Test_Lag_7
    ## Test_New    0.6580893  0.7139655  0.6363658
    ## Pos_New     0.7563592  0.8512888  0.8103285
    ## Test_Lag_1  0.7405630  0.6949720  0.7188805
    ## Test_Lag_2  0.7237436  0.7777661  0.6947253
    ## Test_Lag_3  0.8407823  0.7841002  0.7914377
    ## Test_Lag_4  0.8143756  0.8428988  0.7694673
    ## Test_Lag_5  1.0000000  0.8662940  0.8495708
    ## Test_Lag_6  0.8662940  1.0000000  0.8702399
    ## Test_Lag_7  0.8495708  0.8702399  1.0000000

Note: the test counts for 20 March were missing so I averaged the 19
March and 21 March test rate.
