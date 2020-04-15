Lag in DC Test Results
================

### Postive Covid-19 Results in DC Lag by About Four Days

15 April, 2020

The below plot shows the number of Positive Tests in red and the number
of New Tests (multiplied by the positive test rate) in blue. Although
the numbers tracked pretty well early on in testing, they have diverged
recently. The correlation coefficient is currently 0.7339686.

![](Testing_Results_Lag_files/figure-gfm/same_day-1.png)<!-- -->

The below plot shows the number of Positive Tests in red compared to the
number of New Tests four days ago (times the cumulative positive test
rate) in blue. These numbers track much better, with a current
correlation coefficient of 0.9246045.

![](Testing_Results_Lag_files/figure-gfm/lag_4-1.png)<!-- -->

Here is the correlation matrix for those interested in such a thing.

    ##             Test_New   Pos_New Test_Lag_1 Test_Lag_2 Test_Lag_3 Test_Lag_4
    ## Test_New   1.0000000 0.7339686  0.7204835  0.7982241  0.6496469  0.6693130
    ## Pos_New    0.7339686 1.0000000  0.7304063  0.7830946  0.7870896  0.9246045
    ## Test_Lag_1 0.7204835 0.7304063  1.0000000  0.7898085  0.8201760  0.7252773
    ## Test_Lag_2 0.7982241 0.7830946  0.7898085  1.0000000  0.8084274  0.8186051
    ## Test_Lag_3 0.6496469 0.7870896  0.8201760  0.8084274  1.0000000  0.8297817
    ## Test_Lag_4 0.6693130 0.9246045  0.7252773  0.8186051  0.8297817  1.0000000
    ## Test_Lag_5 0.6106773 0.7935265  0.7689716  0.7215526  0.8526638  0.8260539
    ## Test_Lag_6 0.6992365 0.8563329  0.7020480  0.7656685  0.7509179  0.8491750
    ## Test_Lag_7 0.6208070 0.8084250  0.7535456  0.7016906  0.7780175  0.7504594
    ##            Test_Lag_5 Test_Lag_6 Test_Lag_7
    ## Test_New    0.6106773  0.6992365  0.6208070
    ## Pos_New     0.7935265  0.8563329  0.8084250
    ## Test_Lag_1  0.7689716  0.7020480  0.7535456
    ## Test_Lag_2  0.7215526  0.7656685  0.7016906
    ## Test_Lag_3  0.8526638  0.7509179  0.7780175
    ## Test_Lag_4  0.8260539  0.8491750  0.7504594
    ## Test_Lag_5  1.0000000  0.8174149  0.8536711
    ## Test_Lag_6  0.8174149  1.0000000  0.8196731
    ## Test_Lag_7  0.8536711  0.8196731  1.0000000

A couple notes. First, the test counts for 20 March were missing so I
averaged the 19 March and 21 March test rate. In addition, for the
initial lagged variables, I made the defaults zero. This could make the
correlation metrics stronger for the lagged variables, but the effect
doesn’t look uniform.
