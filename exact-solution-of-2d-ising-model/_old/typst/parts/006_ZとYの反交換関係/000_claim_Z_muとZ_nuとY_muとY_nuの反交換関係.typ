#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#claim([$Z$と$Y$の反交換関係])[
  $
  [Z_mu, Z_nu]_+ = 2I_((CC^2)^(times.o M)) delta^M_((mu, nu)), quad
  [Z_mu, Y_nu]_+ = 0, quad
  [Y_mu, Y_nu]_+ = 2I_((CC^2)^(times.o M)) delta^M_((mu, nu))
  $

  #proof[
    $mu, nu in M$について、
    
    $mu = nu$ のとき、
    $
    [Z_mu, Z_mu]_+
    &=
    Z_mu Z_mu + Z_mu Z_mu
    \
    &=
    2 I_((CC^2)^(times.o M))
    $

    $mu < nu$のとき、
    $
    [Z_mu, Z_nu]_+
    &=
    Z_mu Z_nu + Z_nu Z_mu
    \
    &=
    (sigma_1^x dots.c sigma_(mu-1)^x dot.op sigma_mu^z)
    dot.op 
    (sigma_1^x dots.c sigma_mu^x dots.c sigma_(nu-1)^x sigma_nu^z)
    +
    (sigma_1^x dots.c sigma_mu^x dots.c sigma_(nu-1)^x sigma_nu^z)
    dot.op
    (sigma_1^x dots.c sigma_(mu-1)^x dot.op sigma_mu^z)
    \
    &=
    (
      sigma^x 
      times.o dots.c times.o 
      overbrace(sigma^x,mu-1"th") 
      times.o 
      overbrace(sigma^z,mu"th")
    )
    dot.op
    (
      sigma^x
      times.o dots.c times.o 
      overbrace(sigma^x,mu-1"th") 
      times.o 
      overbrace(sigma^x,mu"th") 
      times.o dots.c times.o 
      overbrace(sigma^x,nu-1"th") 
      times.o 
      overbrace(sigma^z,nu)
    )
    \
    &quad +
    (
      sigma^x
      times.o dots.c times.o 
      overbrace(sigma^x,mu-1"th") 
      times.o 
      overbrace(sigma^x,mu"th") 
      times.o dots.c times.o 
      overbrace(sigma^x,nu-1"th") 
      times.o 
      overbrace(sigma^z,nu)
    )
    dot.op
    (
      sigma^x 
      times.o dots.c times.o 
      overbrace(sigma^x,mu-1"th") 
      times.o 
      overbrace(sigma^z,mu"th")
    )
    \
    &=
    (
      sigma^x dot.op sigma^x
      times.o dots.c times.o 
      overbrace(sigma^x dot.op sigma^x,mu-1"th") 
      times.o 
      overbrace(sigma^z dot.op sigma^x,mu"th")
      times.o 
      overbrace(sigma^x,mu+1"th")
      times.o dots.c times.o
      overbrace(sigma^x,nu-1"th")
      times.o
      overbrace(sigma^z,nu)
    )
    \
    &quad +
    (
      sigma^x dot.op sigma^x
      times.o dots.c times.o 
      overbrace(sigma^x dot.op sigma^x,mu-1"th") 
      times.o 
      overbrace(sigma^x dot.op sigma^z,mu"th")
      times.o 
      overbrace(sigma^x,mu+1"th")
      times.o dots.c times.o
      overbrace(sigma^x,nu-1"th")
      times.o
      overbrace(sigma^z,nu)
    )
    \
    &=
    (
      I_((CC^2)^(times.o M))
      times.o dots.c times.o 
      overbrace(I_((CC^2)^(times.o M)),mu-1"th") 
      times.o 
      overbrace(sigma^z dot.op sigma^x,mu"th")
      times.o 
      overbrace(sigma^x,mu+1"th")
      times.o dots.c times.o
      overbrace(sigma^x,nu-1"th")
      times.o
      overbrace(sigma^z,nu)
    )
    \
    &quad +
    (
      I_((CC^2)^(times.o M))
      times.o dots.c times.o 
      overbrace(I_((CC^2)^(times.o M)),mu-1"th") 
      times.o 
      overbrace(sigma^x dot.op sigma^z,mu"th")
      times.o 
      overbrace(sigma^x,mu+1"th")
      times.o dots.c times.o
      overbrace(sigma^x,nu-1"th")
      times.o
      overbrace(sigma^z,nu)
    )
    \
    &=
    (
      I_((CC^2)^(times.o M))
      times.o dots.c times.o 
      overbrace(I_((CC^2)^(times.o M)),mu-1"th") 
      times.o 
      overbrace(sigma^z dot.op sigma^x,mu"th")
      times.o 
      overbrace(sigma^x,mu+1"th")
      times.o dots.c times.o
      overbrace(sigma^x,nu-1"th")
      times.o
      overbrace(sigma^z,nu)
    )
    \
    &quad -
    (
      I_((CC^2)^(times.o M))
      times.o dots.c times.o 
      overbrace(I_((CC^2)^(times.o M)),mu-1"th") 
      times.o 
      overbrace(sigma^z dot.op sigma^x,mu"th")
      times.o 
      overbrace(sigma^x,mu+1"th")
      times.o dots.c times.o
      overbrace(sigma^x,nu-1"th")
      times.o
      overbrace(sigma^z,nu)
    )
    \
    &=
    0
    $
    Q.E.D.

    $
    [Z_mu, Y_nu]_+
    $
    TODO: 同様

    $
    [Y_mu, Y_nu]_+
    $
    TODO
  ]
]<anticommutator_of_Z_and_Y>
