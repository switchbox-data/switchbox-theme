#import "sb-template.typ": *

#show: template.with(
  title: "Win Climate Report Template",
  authors: (
    (
      name: "Juan-Pablo Velez",
      organization: "Win Climate",
      email: "jpv@climate.win"
    ),
   (
      name: "Max Shron",
      organization: "Polynumeral",
      email: "max@polynumeral.com"
    ),
    (
      name: "Carl Vogel",
      email: "carljv@gmail.com"
    ), 
    (
      name: "Fred Flinstone",
      organization: "Town of Bedrock",
      email: "fred@yabbadabba.doo"
    ),
  ),
  draft: true,
  bib: bibliography("../theme/references.bib")
)

= Brooklyn residents who are highly energy burdened today
== Foreward

New York State's Solar Tax Credit is the largest of several state
incentives available to homeowners installing rooftop solar.#note[See NY Scoping Plan Integration Analysis (NYSERDA 2022)] The credit can pay for 25% of a residential rooftop solar installation, or \$5,000, whichever is less.

The *Residential Solar Tax Credit Reform Act* (#link("https://www.nysenate.gov/legislation/bills/2023/S3596/amendment/A")[S3596/A6739])
updates the current tax credit to make it fully refundable, so that low-income homeowners and people living in disadvantaged communities can also benefit from this incentive.#note(dy:-4em)[§1 of S3596/A6739 (Harckham and
Walker 2024) allows residents to receive the full incentive from the state, regardless how much they owe in income tax. Today, a homeowner installing a \$20K system that owes \$1K in taxes would only receive \$1K, not the full \$5K they are eligible for.] The Act also increases #note(dy: 7em)[The All-Electric Building Act of 2023
(#cite_full(<aeba_2023>)), a version of
which was enacted in the state's FY '23--24 budget.] the tax credit amount to \$10,000, which has
not been updated since 2006.

The solar-project-by-income percentages in Figure 1 and Section 3.1 are based on the Residential Solar-Adopter Income and Demographic datasets from Lawrence Berkeley National Lab
(LBNL), which counts the number of #define[solar projects] within each
NYS county at each income level.

== Executive Summary 

Analyzing solar installation data from NYSERDA and Lawrence
Berkeley National Lab (@tab-bucks-cost), we find that:

#note(numbered: false, dy: -3em)[#figure([#table(
  columns: (2fr, 2fr),
  align: (left, right),
[Replacement \ year],[Yearly cost \ (millions)],
[2025],[\$548],
[2026],[\$1,534],
[2027],[\$2,366],
[2028],[\$3,260],
[2029],[\$4,472],
[2030],[\$4,837])],
caption: [Cost to New York State of implementing Bucks for Boilers, by year.])<tab-bucks-cost>
]


- NY has a large rooftop solar gap: homeowners with an annual income above \$50,000 are 2.5x more likely to have rooftop solar than those making below \$50,000, who don't always pay enough income tax to claim the full credit.

- NY's solar tax credit is inequitable: households making less than \$50,000 make up 24% of owner-occupied households in New York State, but have only received 5% of the state's residential tax credit subsidies.


The following table contains a complete breakdown of our
findings:


#wideblock[
#table(
  columns: (1fr, 0.5fr, 0.5fr, 0.75fr),
  align: (left, right, right, right),
  table.header( 
  [Region], [Homes with high engergy burdens], [Avg. monthly energy bills of high burden homes], [Avg. monthly saving for high-burden homes under NY HEAT]
),
[*Community District 4* \ Bushwick], [23%],[\$254],[\$128],
[*Community District 11* \ Bensonhurst & Bath Beach], [28%],[\$256],[\$123],
[*Community District 16* \ Brownsville & Ocean Hill], [35%],[\$248],[\$144],
[*Community District 10* \ Bay Ridge & Dyker Heights], [21%],[\$279],[\$140],
[*Community District 1* \ Greenpoint & Williamsburg], [18%],[\$230],[\$113],
[*Community District 18* \ Canarsie & Flatlands], [7%],[\$385],[\$176],
[*Community District 14* \ Flatbush & Midwood], [22%],[\$265],[\$123]
)
#linebreak()
]

What could be driving this “two tier” disparity (@fig-tax-expenditure) #note(numbered: false)[#figure(image("wc-solar-chart.png"), caption: [Yearly tax expenditure, NY solar tax credit. Source: NYS Tax Expenditure Reports.])<fig-tax-expenditure>] in installation rates?

+ High up-front costs. Solar panels are expensive, costing tens of thousands of dollars to install, so lower income people often can't afford them.

+ Low creditworthiness.

+ Exclusion from tax credits.

Furthermore, 88% of these highly-burdened homeowners live in single family or low-rise multifamily buildings. Unlike residents of large multifamily buildings, where the savings from rooftop solar get diluted over many units, these households may be able to meaningfully cut their electricity bills by installing panels.

In total, making the tax credit fully refundable could benefit up to 63% of all highly energy-burdened families in New York.


= Findings \
== Rooftop Solar Gap
While 25% of all homeowners made less than \$50,000 a year, these households installed only *10%* of solar projects between 2010 and 2022. This is New York State's *rooftop solar gap*. 

If solar was being deployed equitably, we'd expect homeowners with annual incomes under \$50,000 to receive a quarter of the state's rooftop solar projects, not a tenth. Closing the solar gap would require growing these homeowners' share of the solar installation pie by 2.5x.

=== Unequal installation rates

To understand what's behind New York's inequitable distribu-
tion of rooftop solar, we must examine solar installation rates.

The contrast with higher-income households is striking: those
with annual incomes above \$50,000 are 2.5x more likely to have
panels than those below.

But it is not the case that the higher a household's income, the
more likely they are to have solar panels on their roof. In fact,
solar penetration rates are similar for all income buckets above
\$50,000, ranging from 22 to 27 households per project.

=== Discussion
What could be driving this "two tier" disparity in installation rates?

High up-front costs: solar panels #note[The Federal Residential Clean Energy
Credit administered by the IRS just received a 10-year extension through the Inflation Reduction Act.] are expensive, costing tens of thousands of dollars to install, so lower income people often can't afford them. The rise of solar leases, which allow home owners to rent solar panels while paying nothing up-front, has significantly lowered up-front cost as an obstacle to adoption, however. #icon

