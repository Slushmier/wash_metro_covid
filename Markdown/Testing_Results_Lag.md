Lag in DC Test Results
================

### Postive Covid-19 Results in DC Lag by About Four Days

22 April, 2020

The below plot shows the number of Positive Tests in red and the number
of New Tests (multiplied by the positive test rate) in blue. Although
the numbers tracked pretty well early on in testing, they have diverged
recently. The correlation coefficient is currently 0.8077552.

![](Testing_Results_Lag_files/figure-gfm/same_day-1.png)<!-- -->

The below plot shows the number of Positive Tests in red compared to the
number of New Tests four days ago (times the cumulative positive test
rate) in blue. These numbers track much better, with a current
correlation coefficient of 0.8614693.

![](Testing_Results_Lag_files/figure-gfm/lag_4-1.png)<!-- -->

Here is the correlation matrix for those interested in such a thing.

    ##              Test_New   Pos_New Test_Lag_1 Test_Lag_2 Test_Lag_3 Test_Lag_4
    ## Test_New    1.0000000 0.8077552  0.7537070  0.7670827  0.6563022  0.7034331
    ## Pos_New     0.8077552 1.0000000  0.6764989  0.7634820  0.7337845  0.8614693
    ## Test_Lag_1  0.7537070 0.6764989  1.0000000  0.7630082  0.7748538  0.6648125
    ## Test_Lag_2  0.7670827 0.7634820  0.7630082  1.0000000  0.7876782  0.7957145
    ## Test_Lag_3  0.6563022 0.7337845  0.7748538  0.7876782  1.0000000  0.7931553
    ## Test_Lag_4  0.7034331 0.8614693  0.6648125  0.7957145  0.7931553  1.0000000
    ## Test_Lag_5  0.6897263 0.7731055  0.7060293  0.6581132  0.8060758  0.8012896
    ## Test_Lag_6  0.7159794 0.8254042  0.6932050  0.7128230  0.6661210  0.8102823
    ## Test_Lag_7  0.6576772 0.8103035  0.7176776  0.6836387  0.7243702  0.6750514
    ## Test_Lag_8  0.6548036 0.8081989  0.6732503  0.7594062  0.6933292  0.7337612
    ## Test_Lag_9  0.6101411 0.7417036  0.6620825  0.6944101  0.7639219  0.6989742
    ## Test_Lag_10 0.6794897 0.7812898  0.6206934  0.6904321  0.7008467  0.7691034
    ##             Test_Lag_5 Test_Lag_6 Test_Lag_7 Test_Lag_8 Test_Lag_9 Test_Lag_10
    ## Test_New     0.6897263  0.7159794  0.6576772  0.6548036  0.6101411   0.6794897
    ## Pos_New      0.7731055  0.8254042  0.8103035  0.8081989  0.7417036   0.7812898
    ## Test_Lag_1   0.7060293  0.6932050  0.7176776  0.6732503  0.6620825   0.6206934
    ## Test_Lag_2   0.6581132  0.7128230  0.6836387  0.7594062  0.6944101   0.6904321
    ## Test_Lag_3   0.8060758  0.6661210  0.7243702  0.6933292  0.7639219   0.7008467
    ## Test_Lag_4   0.8012896  0.8102823  0.6750514  0.7337612  0.6989742   0.7691034
    ## Test_Lag_5   1.0000000  0.8029834  0.8068166  0.6971757  0.7432569   0.7129821
    ## Test_Lag_6   0.8029834  1.0000000  0.8048600  0.8189252  0.7029845   0.7510367
    ## Test_Lag_7   0.8068166  0.8048600  1.0000000  0.8291965  0.8300112   0.7186350
    ## Test_Lag_8   0.6971757  0.8189252  0.8291965  1.0000000  0.8346388   0.8339814
    ## Test_Lag_9   0.7432569  0.7029845  0.8300112  0.8346388  1.0000000   0.8377869
    ## Test_Lag_10  0.7129821  0.7510367  0.7186350  0.8339814  0.8377869   1.0000000

A couple notes. First, the test counts for 20 March were missing so I
averaged the 19 March and 21 March test rate. In addition, for the
initial lagged variables, I made the defaults zero. This could make the
correlation metrics stronger for the lagged variables, but the effect
doesn’t look uniform.

### Cumulitave Positive Test Rate

![](Testing_Results_Lag_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->
