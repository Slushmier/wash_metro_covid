Lag in DC Test Results
================

### Postive Covid-19 Results in DC Lag by About Four Days

12 April, 2020

The below plot shows the number of Positive Tests in red and the number
of New Tests (multiplied by the positive test rate) in blue. Although
the numbers tracked pretty well early on in testing, they have diverged
recently. The correlation coefficient is currently 0.8180627.

![](Testing_Results_Lag_files/figure-gfm/same_day-1.png)<!-- -->

The below plot shows the number of Positive Tests in red compared to the
number of New Tests four days ago (times the cumulative positive test
rate) in blue. These numbers track much better, with a current
correlation coefficient of 0.9223203.

![](Testing_Results_Lag_files/figure-gfm/lag_4-1.png)<!-- -->

Here is the correlation matrix for those interested in such a thing.

    ##             Test_New   Pos_New Test_Lag_1 Test_Lag_2 Test_Lag_3 Test_Lag_4
    ## Test_New   1.0000000 0.8180627  0.8129040  0.8390431  0.7291386  0.7603697
    ## Pos_New    0.8180627 1.0000000  0.7272474  0.8115591  0.7796381  0.9223203
    ## Test_Lag_1 0.8129040 0.7272474  1.0000000  0.8104692  0.8365950  0.7309178
    ## Test_Lag_2 0.8390431 0.8115591  0.8104692  1.0000000  0.8026037  0.8427214
    ## Test_Lag_3 0.7291386 0.7796381  0.8365950  0.8026037  1.0000000  0.8065306
    ## Test_Lag_4 0.7603697 0.9223203  0.7309178  0.8427214  0.8065306  1.0000000
    ## Test_Lag_5 0.6954809 0.7738058  0.7595599  0.7308147  0.8440853  0.8070948
    ## Test_Lag_6 0.7443372 0.8509438  0.6997910  0.7691501  0.7381403  0.8457218
    ## Test_Lag_7 0.6976197 0.8129254  0.7371107  0.6818008  0.7567267  0.7415686
    ##            Test_Lag_5 Test_Lag_6 Test_Lag_7
    ## Test_New    0.6954809  0.7443372  0.6976197
    ## Pos_New     0.7738058  0.8509438  0.8129254
    ## Test_Lag_1  0.7595599  0.6997910  0.7371107
    ## Test_Lag_2  0.7308147  0.7691501  0.6818008
    ## Test_Lag_3  0.8440853  0.7381403  0.7567267
    ## Test_Lag_4  0.8070948  0.8457218  0.7415686
    ## Test_Lag_5  1.0000000  0.8091787  0.8488025
    ## Test_Lag_6  0.8091787  1.0000000  0.8209136
    ## Test_Lag_7  0.8488025  0.8209136  1.0000000

A couple notes. First, the test counts for 20 March were missing so I
averaged the 19 March and 21 March test rate. In addition, for the
initial lagged variables, I made the defaults zero. This could make the
correlation metrics stronger for the lagged variables, but the effect
doesn’t look uniform.
