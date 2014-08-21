Anisotropic and Heterogeneous Diffusion
=======================================

The classic isotropic diffusion equation uses a diffusion parameter $D$
which is constant over the entire domain. While this smooths out noise,
it also smooths out image features, most notably edges (jumps in pixel
intensity). If we want to preserve an edge $\Gamma$, we wish to
reduce diffusion across (or perpendicular) to the edge while keeping
normal diffusion along (tangential) to the edge. We therefore need to
identify the perpendicular and tangential directions near an edge in the
image. We can do this using the grandient vector of $u$, which we
know to be (a) large near $\Gamma$ and (b) perpendicular to
$\Gamma$. Hence the unit vector $N$ normal to $\Gamma$ and the
tangential vector $T$ are given by

$$N &= \frac{1}{|\nabla{u}|} \nabla{u} = \frac{1}{|\nabla{u}|}\begin{pmatrix} u_x \\u_y \end{pmatrix} \\
T &= N^\perp = \frac{1}{|\nabla{u}|}\begin{pmatrix} -u_y \\u_x \end{pmatrix}$$

We can then define the first and second derivatives of $u$ with respect
to $N$ and $T$.

$$u_N &= N \dot \nabla u,\\
u_{NN} &= N \dot H(u) N,\\
u_T &= T \dot \nabla u,\\
u_{TT} &= T \dot H(u) T,\\$$

where $H(u)$ is the hessian matrix of $u$

$$H(u) = \begin{pmatrix} u_xx & u_xy \\ u_yx & u_yy \end{pmatrix}$$

Note that $u_T=0$, since the gradient of $u$ is zero
tangential to the edge.

Now that we have defined a new local coordinate system in terms of
$N$ and $T$, we can use this to construct an anisotropic
diffusion equation, where the pixel values diffuse differently either
normal or tangent to an edge. We therefore redefine $D$ to be a
2x2 matrix. For example,

$$K = \begin{pmatrix} a & 0 \\ 0 & b \end{pmatrix}.$$
