Lecture 3: Differentiation
==========================

So far we're looked at interpolation and quadrature.  In both cases,
we're given data $f_i$ at points $x_i$ and we want to
compute/estimate/approximate:

1. the function values (interpolation);

2. the definite integral (quadrature).

What about differentiation?  Suppose we want to estimate the
derivative of a function at a point (often, but not always, one of the
$x_i$'s).


Fit interpolating polynomial and differentiate it
-------------------------------------------------

This approach is conceptually simple and illustrative, although
traditionally not used very often in practice (however, see
"Barycentric Lagrange" in a later lecture, or search for "Chebfun")


#### Example

Suppose I want to estimate the second derivative of a function
$f(x)$ at a point $x_j$ from samples $f_i$ and nodes $x_i$.  How many
data points do I need?  Constant or linear interpolant won't work (why
not?)  Simplest is quadratic.

[Worked example, perhaps in a CAS...]

>
>

>
>

>
>

>
>

>
>

>
>

Assuming the data is equispaced, note this reduces to the gives the common "1 -2 1"
rule:

$$f''(x_j) = \frac{1}{h^2} f_{j-1} -  \frac{2}{h^2} f_j  +   \frac{1}{h^2} f_{j+1}.$$


#### Error analysis

What can we learn from the polynomial interpolant error formula?

>
>

>
>

>
>

Note predicts $O(h)$ which is correct when the data is not equispaced.
Equispaced, it should be $O(h^2)$, which we'll see this more precisely by
the next method.



Method of Undetermined Coefficients
-----------------------------------

Instead of working with interpolants, the most commonly used
alternative approach is the method of undetermined coefficients.

Reference: [Chapter 1 of LeVeque 2007 Textbook].

Based on Taylor series.  Taylor expand $f(x+h)$ and $f(x-h)$ (and
others) in small parameter $h$ about $x$.


#### Example

Second derivative from three data points again...

>
>

>
>

>
>

>
>

>
>

>
>


#### Error Analysis

Note: get's the $O(h^2)$ error term.

For practical algorithms, see paper
[Fornberg, Calculation of Weights in Finite Difference Formulas,
SIAM Review, 1998, [doi:10.1137/S0036144596322507](http://dx.doi.org/10.1137/S0036144596322507)].





Lecture 4: the Barycentric Formula
==================================

Handout:
[Berrut & Trefethen, _Barycentric Lagrange interpolation_, SIAM Review
2004, [doi:10.1137/S0036144502417715](http://dx.doi.org/10.1137/S0036144502417715)].


Consider the "Barycentric formula" for Lagrange interpolation:

\begin{equation*}
  p_n(x) = \frac{
    \displaystyle\sum_{k=0}^n\frac{w_k}{(x-x_k)}f_k
  }{
    \displaystyle\sum_{k=0}^n\frac{w_k}{(x-x_k)}
  },
\end{equation*}
where
$$w_k = \frac{1}{\prod_{i \ne k} (x_k - x_i)}  \,\,\,\,\,\left( = \frac{1}{w'(x_k)} \right).$$


Is this expression really the same as the Lagrange Interpolating
Polynomial from Lecture 1?

What do you think could go wrong in computation?

Reference:
[Higham, _The numerical stability of barycentric Lagrange
interpolation_, IMAJNA 2004, [doi:10.1093/imanum/24.4.547](http://dx.doi.org/10.1093/imanum/24.4.547)].


