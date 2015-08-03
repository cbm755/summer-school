Lecture 5: Timestepping and ODEs
================================

Last Day Review
===============

Recall from last day, we can derive approximations to derivatives of a
smooth function $u(x)$:

**Forward difference**:
$$u'(x) = \frac{u(x+h)-u(x)}{h} + O(h)$$

**Backward difference**:
$$u'(x) = \frac{u(x)-u(x-h)}{h} + O(h)$$

**Centered difference**:
$$u'(x) = \frac{u(x+h)-u(x-h)}{2h} + O(h^2)$$


# Ordinary differential equations: ODE IVPs

**ODE**: ordinary differential eqn (i.e., just 1 independent variable)

**IVP**: initial-value problem

First-order IVP in standard form:

$$u' = f(t,u), \quad t > 0$$
$$u(0) = \eta  \quad \text{(initial data)}$$

We're looking for the solution, a function $u(t)$ for $t > 0$.

Looks restrictive but this form is quite general:

1.  It could describe a system of $N$ ODEs.

    * $u(t)$ is an $N$-vector, so is $\eta$.

2.  Equivalence to higher-order system.

    * Example: harmonic oscillator

        $$w'' = -w', w(0) = 1, w'(0) = 0$$

        Define $u_1 = w$, $u_2 = w'$, then we have

        $$u_1' = u_2,$$
        $$u_2' = -u_1.$$
	with initial conditions $u_1(0) = 1$, $u_2(0) = 0$.


In this example ODE the variable $t$ does not appear explicitly
($f(t,u)$ is just $f(u)$).
Such an ODE is said to be **autonomous**.

Another example: the sun and moon and eight planets.  Each has three
coordinates of position and three of velocity.  All together, that's
an autonomous ODE IVP of dimension $N=60$.



## Need for numerical methods

Above simple examples are linear and can be solved analytically.
Most **nonlinear ODEs**, however, cannot; we need *numerics*.

### van der Pol equation, a nonlinear example

$$w'' + C(w^2 -1)w' + w = 0,$$  for fixed $C > 0$.
For $|w|>1$, a damped oscillator; for $|w|<1$, negatively damped.
Big solutions decay; small solutions grow.
As $t \to \infty$ we have convergence to a **limit cycle** of size $O(1)$.

Equivalent first-order system:

$$u_1' = u_2,$$
$$u_2   ' = -u_1   - C[(u_1   )^2-1] u_2.$$


[m01_vanderpol.m]


## Time discretization

A grid in time: $t_n = nk, k > 0$ a fixed **time step**.  Often
"$\Delta t$" or "$\tau$" used instead.


         |-------|-------|-------|-------|-------|-----
        t0=0    t1=k    t2=2k   ...

(often in practice $k$ not fixed, and is changed automatically).

The exact solution (usually unknown) is $u(t)$ defined for all
continuous values of $t$.  We will fine a numerical solution at these
discrete points $v_n \approx u(t_n)$.


## Forward Euler method

The simplest method is the forward Euler method:

$v^0 = \eta$ (initial condition)

$v^1 = v^0 + k f(v^0)$

$v^2 = v^1 + k f(v^1)$

... etc.

We are *time-stepping* with the formula

$$v^{n+1} = v^n + k f(t_n,v^n)$$

And this simply the "forward difference" we saw earlier.
Matlab codes: [m02_euler.m], [m03_euler_graph.m].

We often want methods which are more accurate, or more stable, or have
other features.



## A little bit of history

Differential equations are at least as old as calculus.  Examples in
[Newton 1671], by series solutions.

The book by Hairer, Wanner and Norsett includes lots of historical
tidbits and quotes.  Besides, any book with a figure caption of "Cats,
beware of pendulums!" (pg 100) just has to be good.


### History of numerical solutions of ODEs

  1. Leonhard Euler, 1768
  2. John Couch Adams, 1850s (unpubl.)  (predicted Neptune 1845, age 26;
		    		         Leverrier found it 1846)
     [Cambridge Senior Wrangler, 1843]
  3. Francis Bashforth, 1883
     [Cambridge Second Wrangler, 1843]
  4. Carl Runge, 1895
  5. Karl Heun, 1900
  6. Martin Wilhelm Kutta, 1901
  7. F R Moulton, 1926
  8. Richard von Mises, 1930


## Accuracy

Under some assumptions (smooth enough solution) the forward Euler
method has a global error which behaviors like $Ck$ (notation: $error
= O(k)$).

Roughly speaking if we want 6 digits of accuracy, we need million
steps.  Often we want more accuracy for less work.  Money for nuthin'!



### Runge--Kutta and linear multistep methods

Compared to forward Euler, we often want methods which are more
accurate, or more stable, or have other features.  We'll do some
analysis later, but for now let's list some other methods.

There are two main classes of methods:
Runge--Kutta ("1-step"); Adams--[others] ("multistep")


#### Adams-Bashforth multistep formulas

Notation: define $f^n = f(t_n,v^n)$.


$v^{n+1} = v^n + k f^n$:    *forward Euler* again, accuracy $O(k)$

$v^{n+1} = v^n + \frac{k}{2} (3 f^n - f^{n-1})$:   accuracy $O(k^2)$

$v^{n+1} = v^n + \frac{k}{12} (23f^n - 16f^{n-1} + 5f^{n-2})$:  accuracy $O(k^3)$

$v^{n+1} = v^n + \frac{k}{24} (55f^n - 59f^{n-1} + 37f^{n-2} - 9f^{n-3})$:  accuracy $O(k^4)$

...

(an infinite sequence of such formulas)

Adams--Bashforth uses previous values, not just the current one.
[modify our code].

Tricky to start up because extra values are needed.


#### Runge--Kutta methods

Use temporary intermediate values (called *stage values*).

1. Forward Euler  (again)  $O(k)$

2. "Modified Euler"    $O(k^2)$

    $a = k f(t_n,v^n),$

    $b = k f(t_n+k/2, v^n + a/2),$

    $v^{n+1} = v^n + b.$

3. "*The* Fourth-order Runge-Kutta Method"  $O(k^4)$

    $a = k f(t_n,v^n),$

    $b = k f(t_n + k/2, v^n + a/2),$

    $c = k f(t_n + k/2, v^n + b/2),$

    $d = k f(t_n + k, v^n + c),$

    $v^{n+1} = v^n + \frac{1}{6} (a + 2b + 2c + d).$

    If you could take just one formula to a desert island, this is it.

Higher-order RK formulas get very complicated.
The coefficients of Runge-Kutta methods can be stored in a "Butcher
Tableau".  Matlab's |ode45| uses a method of Dormand and Prince 1980
(see pg178 of HairerWannerNorsett).  Jim Verner (I've had the
honour of working with him) also constructed high-order methods (and still
does).  See "DVERK User Guide" from 1976.

Aside: if anyone has an interest in pure mathematics, John Butcher has
a beautiful algebraic theory relating Runge-Kutta methods to rooted
trees.


### IVP codes in higher-level software

ODE codes are among the must successful algorithms (and software) in
all of scientific computing.  The key is that they are **adaptive** --
varying step size, and sometimes order, automatically.

Matlab has many codes, but in my experience, most people use ode45 and
ode15s.  These differ in numerics but are basically the same in
syntax.  For info see

   L. F. Shampine and M. W. Reichel, The Matlab ODE suite,
   SIAM J. Sci. Comput. 18 (1997), 1-22.




## From local to global error

We want to compute to $T_f$ (a fixed value, $O(1)$).  This will take $N
= T_f / k$ steps.  This is $O(1/k)$ steps.
So to get a global error of $O(k^p)$ we need the local error to be
$O(k^{k+1})$.

The local truncation error is often straightforward to determine:
Taylor expand the exact solution around $(t_n,u^n)$ and compare terms
to the numerical method applied from $(t_n,u^n)$.


### Consistency example: 2nd-order Adams-Bashforth

$$v^{n+1} = v^n  + \frac{k}{2}(3f^n  - f^{n-1})$$

$u' = f(t,u)$

Expand each with Taylor: $u(t_n+k)$ and $f(t_n-k)$ (remember $u' = f$):

$$u(t+k) = u + ku' + (1/2)k^2 u'' + (1/6)k^3 u''' + \ldots$$

$$f(t-k) = u' - ku'' + (1/2)k^2 u''' - \ldots$$

Substitute in, find the amount by which the exact solution
$u(t_{n+1})$ fails to satify the discrete equation:

  $$
  u(t_n+k) - \left(u(t_n) + \frac{k}{2}(3f^n - f^{n-1})\right)
  = \ldots = -(5/12)k^3 u''' + \ldots
  $$

So the local truncation error is $O(k^3)$ (so consistency order is $2$).

## Runge--Kutta

Doing this sort of Taylor analysis for RK leads to *order conditions*:

  >  "These computations, which are not reproduced in Kutta's 1905 paper
  >  (they are, however, in Heun 1900), are very tedious.  And they grow
  >  enormously with higher-orders.  We shall see... using an appropriate
  >  notation, they can become very elegant."   [Hairer, Wanner, Norsett]


## Convergence?

Having a small local truncation error isn't sufficient to tell us that
the sequence actually converges.

Here's an example of an unstable formula with order 3, try it and see how the computed solutions blow up as $k \to 0$.


   $$v^{n+1}   = -4v^n  + 5v^{n-1}    + k(4f^n  + 2f^{n-1})$$


[m05_unstab.m: an example of a multistep method that is
consistent... but unstable.]

[m05_unstab.m: also an example of a non-self-starting method: use
forward Euler or exact solution, either way still unstable.]

Precisely understanding the global convergence properties requires
*stability*.



## Fundamental Theorem

... of finite difference methods (or "of numerical analysis"?)

  -----------------------------------------
  Consistency + Stability  <=>  Convergence
  -----------------------------------------

We will see this again-and-again.  The notion of stability might
change, depending on the situation (generally stability harder than
consistency).

#### Multistep methods

For multistep methods, this is the **Dahlquist Equivalence Theorem**.


### Absolute Stability for Runge--Kutta methods

Dahlquist test problem:  $u' = \lambda u$, $u(0) = 1$.

Here $\lambda$ is a complex number.  Exact solution is $u(t) =
\exp(\lambda t)$.  Real part of $\lambda$ negative gives decay in the
exact solution.

We apply the numerical method to this test problem and:

   --------------------------------------------------------
   If the solution grows without bound, we say **unstable**,
   otherwise, we say the numerical method is **stable**.
   ---------------------------------------------------------

## Example: forward Euler

  $$v^{n+1} = v^n + k \lambda v^n,$$

  $$v^{n+1} = (1+k\lambda) v^n.$$

But we can apply this all the way back to $t_0$:
  $$v^{n+1} = (1+k\lambda)^{n+1} v^0 = (1+k\lambda)^{n+1}.$$

Thus for forward Euler, the soln will blow-up as $n \to \infty$ unless
$|1+k\lambda| \leq 1$. If $\lambda$ is real, this means
  $$-2 \leq k\lambda \leq 0.$$

Or in the complex plane, we have a **absolute stability region** for
forward Euler $z = k\lambda$ consisting of a unit disc centered at
$z=-1$.

   Absolute stablity
   ------------------------------------------------
   For a given $\lambda$, and a given numerical method, we need to
   choose $k$ such that $k\lambda$ lives inside the stability region.
   ------------------------------------------------

Different RK and MS methods have different absolute stability regions.



## Why is this a reasonable test problem?

This analysis is not much use if it only applies to this one problem...

Works well if (in theory) we can linearize our problem, and apply an
eigenvalue decomposition.  Each component of the diagonalized linear
system will then behave like the Dahlquist test problem.



# Stiffness


The classical stability/consistency/convergence theory for ODEs
was established by Dahlquist in 1956.
Just a few years later it began to be widely appreciated that
something was missing from this theory.
Key paper: [Dahlquist, 1963]

(Chemists Curtiss & Hirschfelder [1952], used the term "stiff", which
may actually have originated with the statistician John Tukey (who
also invented "FFT" and "bit").

## Definitions of stiffness

*  A stiff ODE is one with widely varying time scales.

*  More precisely, an ODE with solution of interest $u(t)$ is stiff
   when there are time scales present in the equation that are much
   shorter than that of $u(t)$  itself.

Neither is an ideal definition.

* A quote from HW: "Stiff equations are problems for which explicit
  methods don't work".

* My favourite: a stiff *problem* is one were implicit methods work
  better.  (I learned this from Raymond Spiteri but probably its
  due to Gear.)    C.W. Gear, 1982:

    >  Although it is common to talk about "stiff differential
    >  equations," an equation *per se* is not stiff, a particular initial
    >  value problem for that equation may be stiff, in some regions, but
    >  the size of these regions depend on the initial values *and* the
    >  error tolerance.

Why it matters: regardless of stiffness, you'll get convergence
as $k \to 0$   (Dahlquist's original theory).

But the result might be garbage except when $k$ is very small, because
of modes $k\lambda$ that aren't in the stability region.


## Example

ODE $u' = -\sin(t)$ with IC $u(0) = 1$ has solution $u(t) = \cos(t)$.

Change ODE to
  $$u' = -100(u(t) - \cos(t)) - \sin(t),$$
then this *still* has solution $u(t) = \cos(t)$.

But the numerics are much different:

[m07_stiff_fe_be.m: a convergence study showing forward Euler
convergences for very small $k$ but is unstable for larger $k$.]

We can also linearize around the soln: let $u(t) = \cos(t) + w(t)$ and
we get an ODE for $w(t)$ of $w'=-100w$ which does indeed have a very
different *time scale* than $\cos(t)$.



# Introduction to implicit methods

(Part of) the cure for stiffness?  Use implicit methods.
E.g., backward Euler method:

$$v^{n+1} = v^n + k f^{n+1} = v^n + k f(t_{n+1}, v^{n+1}).$$

Note $v^{n+1}$, *the thing we want to solve for*, is inside the function $f$ --> implicit.

[m07_stiff_fe_be.m: implement backward Euler and note no instability]




### A-stability

Recall the exact solution of $u'=\lambda u$ is stable (the solution
itself, nothing about numerical methods) if $Re(\lambda) < 0$.  Seems
desirable to have numerical methods that are also stable in this way.

Want their linear stability regions to include the left-hand of the
complex plane.

**Defn** [Dahlquist 1963]: a method, whose stability region includes the
left-hand complex plane is called **A-stable**.

  -------------------------
  We also expect these to work well for stiff problems b/c $k\lambda$
  (for any $Re(\lambda) < 0$) will be in the stability region.
  -------------------------

Dahlquist in 1979:

>  I didn't like all these "strong", "perfect", "absolute",
>  "generalized", "super", "hyper", "complete" and so on in
>  mathematical definitions, I wanted something neutral; and having
>  been impressed by David Young's "Property A", I choose the term
>  "A-stable".



### Example, backward Euler

  $$v^{n+1} = v^n + k f(t_n+k, v^{n+1}) = v^n + k f^{n+1}$$

Using Dahlquist test problem, can show it is stable in the exterior of
a unit disc centered at 1 in the *right*-half complex plane.

Hairer & Wanner: "The backward Euler method is a *very* stable method."

(There are also implicit multistep and implicit Runge-Kutta.)

### Solving the system

Implicit methods have both $v^{n+1}$ and $f^{n+1}$: we need to solve a
linear or nonlinear system to advance the step.  Linear algebra if
linear, something like Newton's method if nonlinear.  We do not
discuss this issue further.

