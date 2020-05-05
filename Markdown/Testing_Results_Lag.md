Lag in DC Test Results
================

### Postive Covid-19 Results in DC Lag by About Four Days

05 May, 2020

**Note: I’m going to stop updating this file as the clear relationship
between tests a few days ago and positive numbers now doesn’t appear to
be valid anymore.**

The below plot shows the number of Positive Tests in red and the number
of New Tests (multiplied by the positive test rate) in blue. Although
the numbers tracked pretty well early on in testing, they have diverged
recently. The correlation coefficient is currently 0.8540016.

![](Testing_Results_Lag_files/figure-gfm/same_day-1.png)<!-- -->

The below plot shows the number of Positive Tests in red compared to the
number of New Tests four days ago (times the cumulative positive test
rate) in blue. These numbers track much better, with a current
correlation coefficient of 0.7230607.

![](Testing_Results_Lag_files/figure-gfm/lag_4-1.png)<!-- -->

Here is the correlation matrix for those interested in such a thing.

    ##              Test_New   Pos_New Test_Lag_1 Test_Lag_2 Test_Lag_3 Test_Lag_4
    ## Test_New    1.0000000 0.8540016  0.7661157  0.7052675  0.6136835  0.6292945
    ## Pos_New     0.8540016 1.0000000  0.6739048  0.6576971  0.6566246  0.7230607
    ## Test_Lag_1  0.7661157 0.6739048  1.0000000  0.7740931  0.7349192  0.6302708
    ## Test_Lag_2  0.7052675 0.6576971  0.7740931  1.0000000  0.7859521  0.7385733
    ## Test_Lag_3  0.6136835 0.6566246  0.7349192  0.7859521  1.0000000  0.7789861
    ## Test_Lag_4  0.6292945 0.7230607  0.6302708  0.7385733  0.7789861  1.0000000
    ## Test_Lag_5  0.6736989 0.7544673  0.6589080  0.6382753  0.7165144  0.7717293
    ## Test_Lag_6  0.6931940 0.7541224  0.6920716  0.6623577  0.6195128  0.7074573
    ## Test_Lag_7  0.6904215 0.7658921  0.7025186  0.7053401  0.7039435  0.6445528
    ## Test_Lag_8  0.6850192 0.7413969  0.6976921  0.7087010  0.7283966  0.7154790
    ## Test_Lag_9  0.6595675 0.7272718  0.6934086  0.7091445  0.7481516  0.7510090
    ## Test_Lag_10 0.6854888 0.7489734  0.6733663  0.6949267  0.6978827  0.7406839
    ##             Test_Lag_5 Test_Lag_6 Test_Lag_7 Test_Lag_8 Test_Lag_9 Test_Lag_10
    ## Test_New     0.6736989  0.6931940  0.6904215  0.6850192  0.6595675   0.6854888
    ## Pos_New      0.7544673  0.7541224  0.7658921  0.7413969  0.7272718   0.7489734
    ## Test_Lag_1   0.6589080  0.6920716  0.7025186  0.6976921  0.6934086   0.6733663
    ## Test_Lag_2   0.6382753  0.6623577  0.7053401  0.7087010  0.7091445   0.6949267
    ## Test_Lag_3   0.7165144  0.6195128  0.7039435  0.7283966  0.7481516   0.6978827
    ## Test_Lag_4   0.7717293  0.7074573  0.6445528  0.7154790  0.7510090   0.7406839
    ## Test_Lag_5   1.0000000  0.7605538  0.7531578  0.6675410  0.7580708   0.7421973
    ## Test_Lag_6   0.7605538  1.0000000  0.7892382  0.7670741  0.6929536   0.7498747
    ## Test_Lag_7   0.7531578  0.7892382  1.0000000  0.7958876  0.7725665   0.7156435
    ## Test_Lag_8   0.6675410  0.7670741  0.7958876  1.0000000  0.8015520   0.7827701
    ## Test_Lag_9   0.7580708  0.6929536  0.7725665  0.8015520  1.0000000   0.8224750
    ## Test_Lag_10  0.7421973  0.7498747  0.7156435  0.7827701  0.8224750   1.0000000

A couple notes. First, the test counts for 20 March were missing so I
averaged the 19 March and 21 March test rate. In addition, for the
initial lagged variables, I made the defaults zero. This could make the
correlation metrics stronger for the lagged variables, but the effect
doesn’t look uniform.

### Cumulitave Positive Test Rate

![](Testing_Results_Lag_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->
