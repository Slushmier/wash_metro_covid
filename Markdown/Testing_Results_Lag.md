Lag in DC Test Results
================

### Postive Covid-19 Results in DC Lag by About Four Days

23 April, 2020

**Note: I’m going to stop updating this file as the clear relationship
between tests a few days ago and positive numbers now doesn’t appear to
be valid anymore.**

The below plot shows the number of Positive Tests in red and the number
of New Tests (multiplied by the positive test rate) in blue. Although
the numbers tracked pretty well early on in testing, they have diverged
recently. The correlation coefficient is currently 0.8005374.

![](Testing_Results_Lag_files/figure-gfm/same_day-1.png)<!-- -->

The below plot shows the number of Positive Tests in red compared to the
number of New Tests four days ago (times the cumulative positive test
rate) in blue. These numbers track much better, with a current
correlation coefficient of 0.8573462.

![](Testing_Results_Lag_files/figure-gfm/lag_4-1.png)<!-- -->

Here is the correlation matrix for those interested in such a thing.

    ##              Test_New   Pos_New Test_Lag_1 Test_Lag_2 Test_Lag_3 Test_Lag_4
    ## Test_New    1.0000000 0.8005374  0.7528415  0.7474900  0.6574723  0.7044287
    ## Pos_New     0.8005374 1.0000000  0.6839421  0.7742732  0.7306120  0.8573462
    ## Test_Lag_1  0.7528415 0.6839421  1.0000000  0.7624816  0.7751079  0.6676042
    ## Test_Lag_2  0.7474900 0.7742732  0.7624816  1.0000000  0.7708756  0.7819632
    ## Test_Lag_3  0.6574723 0.7306120  0.7751079  0.7708756  1.0000000  0.7942347
    ## Test_Lag_4  0.7044287 0.8573462  0.6676042  0.7819632  0.7942347  1.0000000
    ## Test_Lag_5  0.6855713 0.7822784  0.7126163  0.6749142  0.8016943  0.7990223
    ## Test_Lag_6  0.7156503 0.8280881  0.6988118  0.7143976  0.6677115  0.8112982
    ## Test_Lag_7  0.6527717 0.8185657  0.7236941  0.7014387  0.7203872  0.6747240
    ## Test_Lag_8  0.6537431 0.7907564  0.6665863  0.7247441  0.6915465  0.7310507
    ## Test_Lag_9  0.6114420 0.7378356  0.6633478  0.6811519  0.7649596  0.7004736
    ## Test_Lag_10 0.6800005 0.7717437  0.6193804  0.6697833  0.7012145  0.7689503
    ##             Test_Lag_5 Test_Lag_6 Test_Lag_7 Test_Lag_8 Test_Lag_9 Test_Lag_10
    ## Test_New     0.6855713  0.7156503  0.6527717  0.6537431  0.6114420   0.6800005
    ## Pos_New      0.7822784  0.8280881  0.8185657  0.7907564  0.7378356   0.7717437
    ## Test_Lag_1   0.7126163  0.6988118  0.7236941  0.6665863  0.6633478   0.6193804
    ## Test_Lag_2   0.6749142  0.7143976  0.7014387  0.7247441  0.6811519   0.6697833
    ## Test_Lag_3   0.8016943  0.6677115  0.7203872  0.6915465  0.7649596   0.7012145
    ## Test_Lag_4   0.7990223  0.8112982  0.6747240  0.7310507  0.7004736   0.7689503
    ## Test_Lag_5   1.0000000  0.8064778  0.8149726  0.6827639  0.7397766   0.7054442
    ## Test_Lag_6   0.8064778  1.0000000  0.8077145  0.8112264  0.7038708   0.7486109
    ## Test_Lag_7   0.8149726  0.8077145  1.0000000  0.8091770  0.8227753   0.7090417
    ## Test_Lag_8   0.6827639  0.8112264  0.8091770  1.0000000  0.8327191   0.8333506
    ## Test_Lag_9   0.7397766  0.7038708  0.8227753  0.8327191  1.0000000   0.8378140
    ## Test_Lag_10  0.7054442  0.7486109  0.7090417  0.8333506  0.8378140   1.0000000

A couple notes. First, the test counts for 20 March were missing so I
averaged the 19 March and 21 March test rate. In addition, for the
initial lagged variables, I made the defaults zero. This could make the
correlation metrics stronger for the lagged variables, but the effect
doesn’t look uniform.

### Cumulitave Positive Test Rate

![](Testing_Results_Lag_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->
