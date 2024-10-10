{smcl}
{hline}
help for {hi:ineqdecgini}{right:Stephen P. Jenkins (August 2019)}
{hline}

{title:Gini index of inequality, with optional decomposition by subgroups}


{p 8 17 2} {cmd:ineqdecgini} {it:varname} [{it:weights}] 
	[{cmd:if} {it:exp}] [{cmd:in} {it:range}]
	[, {cmdab:by:group}{cmd:(}{it:groupvar}{cmd:)} 
	{cmdab:s:ummarize}   ]

{p 4 4 2} {cmd:fweight}s, {cmd:pweight}s, {cmd:iweight}s, and {cmd:aweights} 
are allowed; see help {help weights}.

{title:Description}

{p 4 4 2} 
{cmd:ineqdecgini} estimates the Gini coefficient (a.k.a. Gini index) of inequality 
plus, optionally, a decomposition by population subgroup into components representing
inequality within groups, inequality between groups, and a residual term, where each
component is non-negative. 

{p 4 4 2} 
Inequality within groups is equal to a subgroup-weighted sum of each subgroup's Gini
index, where each subgroup's weight is equal to the product of the subgroup's income
share and population share. Inequality between groups is equal to the Gini coefficient
arising when each observation is attributed with the mean of `varname' for the subgroup
to which the obs belongs. The residual (a.k.a. overlap) term exists when the income
distributions of each subgroup overlap along the income range; it is equal to zero
in the case when there are no subgroup income distribution overlaps. (An example of
zero overlapping would be when subgroups are defined as the Rich and the Poor, with
the Rich being those with incomes no less than the 90th percentile of {it:varname} and
the Poor being those with incomes less than the 90th percentile of {it:varname}. For 
an application of the Gini decomposition formula in this case, see Jenkins (2017).)

{p 4 4 2}
The decomposition formula is provided by, inter alia, Bhattacharya and Mahalanobis (1967), 
Pyatt (1976), and Mookherjee and Shorrocks (1982). Lambert and Aronson explain how "the 
overlaps [residual] term ... is at once a between groups and a within groups effect: it 
measures a between groups phenomenon, overlapping, that is generated by inequality within 
groups" (1993: p. 1224). They also explain how the residual component can be understood
as a sub-area of the Lorenz diagram. 

{p 4 4 2} 
For undertaking inequality decompositions by population subgroup, most analysts 
deprecate the use of the Gini coefficient as the inequality measure because of the
presence of the residual term. Instead, analysts use Generalised Entropy inequality
indices, because all of them are additively decomposable and there is no residual
component. See e.g. {cmd:ineqdeco} and {cmd:ineqdec0} for Stata implementations 
(available from SSC).

{p 4 4 2} 
Unit record (`micro' level) data are required. If you have grouped (banded) data, 
you should not use this program unless you know what you're doing. Observations with 
values of {it:varname} less than or equal to zero are not excluded from calculations 
(unless otherwise excluded using the {cmd:if} or {cmd:in} options). 

{p 4 4 2}
{it:groupvar} must take non-negative integer values only, and provide an exhaustive
partition of the estimation sample. To create such a variable from an existing variable, 
use the {help egen} function {cmd:group}. By default, observations with missing values 
on {it:groupvar} are excluded from calculations when the {cmd:bygroup} option is specified. 
If you wish to include them, create a new variable with the {help egen} function {cmd:group} 
and use its {cmd:missing} option. The {help egen} function {cmd:group} is 
also useful for multi-way decompositions. E.g. for a decomposition by sex 
and region, create a new {it:groupvar} defining sex-region combinations by 
specifying sex and region in {cmd:group(}{it:varlist}{cmd:)}.


{title:Options}

{p 4 8 2} 
{cmd:bygroup(}{it:groupvar}{cmd:)} requests inequality decompositions by population
subgroup, with subgroup membership summarized by {it:groupvar}.

{p 4 8 2}
{cmd:summarize} requests presentation of {cmd:summary, detail} output for {it:varname}.


{title:Saved results} 

    r(gini)			Gini coefficient

    r(mean), r(sd), r(Var)	mean, standard deviation, variance
    r(min), r(max)		minimum, maximum
    r(N), r(sumw)		Number of observations, sum of weights


{p 4 4 2}If the {cmd:bygroup} option is specified, also saved are:

    r(gini_k)			Gini for each subgroup k

    r(gini_w)			Within-groups component
    r(gini_b)			Between-groups component
    r(residual)			Residual component

    r(gini_w_pc)		Within-groups component as % of Gini
    r(gini_b_pc)		Between-groups component as % of Gini
    r(residual_pc)		Residual component as % of Gini

    r(mean_k), r(lambda_k)	subgroup mean (m_k), and relative mean (m_k/m)
    r(theta_k)			subgroup income share, s_k
    r(sumw_k)			subgroup sum of weights
    r(v_k)			subgroup population share, v_k 

    r(levels)			macro containing the set of values of {it:groupvar}
				(the number of unique values = K)


{title:Examples}

{p 4 8 2}{cmd:. sysuse nlsw88, clear} 

{p 4 8 2}{cmd:. ineqdecgini wage if collgrad == 0, by(race) }

{p 4 8 2}{cmd:. * compare with ineqdec0 results }

{p 4 8 2}{cmd:. ineqdec0 wage if collgrad == 0, by(race) }


{title:Author}

{p 4 4 2}Stephen P. Jenkins <s.jenkins@lse.ac.uk>{break}
London School of Economics

{title:Acknowledgements}

{p 4 4 2}The code for {cmd:ineqdecgini} is based on my {cmd:ineqdec0} command, 
also available from SSC.  It was written in response to a Statalist query from
Elif Cengen about results returned from {cmd:ginidesc}: see
{browse "https://www.statalist.org/forums/forum/general-stata-discussion/general/1508367-why-do-ginidesc-command-yield-different-gini-coefficients-when-combined-with-the-if-qualifier":here}. 


{title:References}

{p 4 8 2}
Bhattacharya, N. and Mahalanobis, B. 1967.
Regional Disparities in Household Consumption in India.
{it:Journal of the American Statistical Association} 62: 143{c -}161.

{p 4 8 2}
Jenkins, S.P. 2017.
Pareto Models, Top Incomes and Recent Trends in UK Income Inequality.
{it:Economica} 84: 261{c -}289.

{p 4 8 2}
Lambert, P.J. and Aronson, J. A. 1993.
Inequality Decomposition Analysis and the Gini Coefficient Revisited.
{it:Economic Journal}, 103: 1221{c -}1227. 

{p 4 8 2}
Mookherjee, D. and Shorrocks, A. 1982.
A Decomposition Analysis of the Trend in UK Inequality.
{it:Economic Journal} 92: 886{c -}992.

{p 4 8 2}
Pyatt, G. 1976.
On the Interpretation and Disaggregation of Gini Coefficients.
{it:Economic Journal} 86: 243{c -}255.


{title:Also see}

{p 4 13 2}
{help ineqdeco} if installed;
{help ineqdec0} if installed;
{help sumdist} if installed;
{help svylorenz} if installed; 
{help svygei} if installed;
{help svyatk} if installed;
{help povdeco} if installed;
{help ginidesc} if installed. All of the programs cited are available from SSC.


