
# Title

Casey Perkins, Bryn Rivenes

Dr. Chris Merkord

## Introduction

Ecogeographic rules explain variation within a species using
biogeography. Allen’s rule states that body surface-area-to-volume ratio
for animals varies with the average temperature of their habitat.
Typically, latitude is used as the temperature variable. However, this
rule should hold true over any type of temperature variable. We want to
know, is there a correlation between altitude and ratio of mass to
length of birds in The Atlantic Forest? To answer this question, we will
be using the Atlantic Bird Traits data set. This data set has been
compiled over two centuries by tens of researchers (1820-2018) and
includes data on 80% of the bird populations found in The Atlantic
Forest. We will perform an exploratory analysis on this data set looking
for correlations between altitude and ratio of mass to length of bird
species. Based on other similar analyses, we expect to see a positive
correlation between these variables.

## Methods

Using R studio, we created our length to mass ratio data by dividing
length by mass for every bird in the Atlantic Bird’s Data Set that had a
recorded mass and length. Using a frequency test on our lmr variable, we
tested for normal distribution. We found we had a serious right skew. To
correct for this, we took the natural log of each data point. Then we
separated out each Order into its’ own graph and found that
Passeriformes made up a disproportionately large part of the data set.
We focused in on this order and made a scatterplot of the means of each
order, family, genus and species vs altitude. We added a trendline which
showed a slight upward trend. We then removed all of the species found
at altitudes of less than 1000 and made another scatterplot. This
revealed a much sharper positive correlation. Then we performed a t-test
comparing means above 1000 and means below 1000 and found (enter what we
find)

## Results

## Discussion

We can see that there is a correlation between the mean lmr of bird
species within order Passeriformes and the altitude at which they are
found. Our graph suggests that the greater the altitude a bird species
is found at, the greater their mean lmr is. This trend follows the trend
seen in birds examined latitudinally as seen in many other research
projects on birds. Essentially, what we see is that birds that are fat
and fluffy tend to live at higher elevations that birds that are long
and skinny. However, it is important to note that this trend was far
more apparent in birds over 1000 in elevation. There are a couple of
possible explanations for this. Generally, at higher elevations, there
are colder temperatures, so birds require a higher body to length ratio
to stay warm. However, birds from birds found in more extreme climates,
we would expect to see greater variation in morphology. For example,
many bird species that live in elevations below 1000 can be found at
100, 500, or 800 easily. However, birds that are found in more extreme
climates (higher elevations) tend to be more adapted for their specific
environment. Allen’s rule suggest that any morphological trait (such as
appendage thickness or hair length) should also vary based on
temperature. A future analysis we would like to do is see if this trend
holds true for other morphological bird characteristics.  

## References

-   Blackburn T, Ruggiero A. Latitude, elevation and body mass variation
    in Andean passerine birds. Global Ecology and Biography 2001 (cited
    2022 Feb 18); 10: 245-259.

-   Lamichhaney S, Han F, Berglund J, Wang C, Almén MS, Webster MT,
    Grant BR, Grant PR, Andersson L. A beak size locus in Darwin’s
    finches facilitated character displacement during a drought.
    Science. 2016 (cited 2022 Feb 18);352(6284):470-4

-   Landmann A, Winding N. Guild Organization and Morphology of
    High-Altitude Granivorous and Insectivorous Birds: Convergent
    Evolution in an Extreme Environment. Oikos. 2995 (cited 2022 Feb
    18);73(2):237-250.

-   Sun Y, Li M, Song G, Lei F, Li D, Wu Y. The Role of Climate Factors
    in Geographic Variation in Body Mass and Wing Length in a Passerine
    Bird. Avian Res. 2017 (cited 2022 Feb 19); 8, 1.

## Acknowledgments
