#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#claim([$psi$の反交換関係])[
  $cal(M) := {-M, dots, -2, -1, 1, 2, dots, M}$ とする。

  $gamma_2(theta_mu) eq.not 0$ かつ $gamma_2(theta_nu) eq.not 0$ なる $mu, nu in cal(M)$について（このとき $#ref(<def_fermi>)$ より $psi_mu, psi_mu^dagger, psi_nu, psi_nu^dagger$ が定義される）、

  $
    [psi_mu^dagger, psi_nu^dagger]_(+) &= 0
    \
    [psi_mu^dagger, psi_nu]_(+) &= delta^M_(mu + nu, 0) I_((CC^2)^(times.o M))
    \
    [psi_mu, psi_nu]_(+) &= 0
  $

  #proof[
    $#ref(<def_fermi>)$ より、$c_mu := (1) / (2 sqrt(M) gamma_2(-theta_(mu)))$ とおくと、

    $
      psi_mu^dagger
      &=
      c_mu
      (
        plus sqrt(-1) sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu))) hat(Z)_mu^((minus))
        +
        gamma_2(-theta_(mu)) hat(Y)_mu
      )
      \
      psi_mu
      &=
      c_mu
      (
        minus sqrt(-1) sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu))) hat(Z)_mu^((minus))
        +
        gamma_2(-theta_(mu)) hat(Y)_mu
      )
    $

    である。

    また、$#ref(<anticommutator_of_hat_Z_and_hat_Y>)$ より、

    $
      [hat(Z)_mu^((minus)), hat(Z)_nu^((minus))]_(+) &= 2M delta^M_(mu + nu, 0) I_((CC^2)^(times.o M))
      \
      [hat(Z)_mu^((minus)), hat(Y)_nu]_(+) &= 0
      \
      [hat(Y)_mu, hat(Y)_nu]_(+) &= 2M delta^M_(mu + nu, 0) I_((CC^2)^(times.o M))
    $

    である。

    $a) [psi_mu^dagger, psi_nu^dagger]_(+)$ について、

    $
      [psi_mu^dagger, psi_nu^dagger]_(+)
      &=
      c_mu c_nu
      [
        plus sqrt(-1) sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu))) hat(Z)_mu^((minus))
        +
        gamma_2(-theta_(mu)) hat(Y)_mu
        ,
        plus sqrt(-1) sqrt(gamma_2(theta_(nu)) gamma_2(-theta_(nu))) hat(Z)_nu^((minus))
        +
        gamma_2(-theta_(nu)) hat(Y)_nu
      ]_(+)
      quad (because "双線型性")
      \
      &=
      c_mu c_nu
      (
        (sqrt(-1))(sqrt(-1))
        sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu)))
        sqrt(gamma_2(theta_(nu)) gamma_2(-theta_(nu)))
        [hat(Z)_mu^((minus)), hat(Z)_nu^((minus))]_(+)
        \
        & quad
        +
        sqrt(-1) sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu)))
        gamma_2(-theta_(nu))
        [hat(Z)_mu^((minus)), hat(Y)_nu]_(+)
        \
        & quad
        +
        gamma_2(-theta_(mu))
        sqrt(-1) sqrt(gamma_2(theta_(nu)) gamma_2(-theta_(nu)))
        [hat(Y)_mu, hat(Z)_nu^((minus))]_(+)
        \
        & quad
        +
        gamma_2(-theta_(mu)) gamma_2(-theta_(nu))
        [hat(Y)_mu, hat(Y)_nu]_(+)
      )
      \
      &=
      c_mu c_nu
      (
        minus
        sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu)))
        sqrt(gamma_2(theta_(nu)) gamma_2(-theta_(nu)))
        +
        gamma_2(-theta_(mu)) gamma_2(-theta_(nu))
      )
      dot.op 2M delta^M_(mu + nu, 0) I_((CC^2)^(times.o M))
    $

    $delta^M_(mu + nu, 0) eq.not 0$ のとき、$mu + nu equiv 0 (mod M)$ すなわち $theta_(nu) = -theta_(mu)$ である。よって、

    $
      sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu)))
      sqrt(gamma_2(theta_(nu)) gamma_2(-theta_(nu)))
      &=
      sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu)))
      sqrt(gamma_2(-theta_(mu)) gamma_2(theta_(mu)))
      \
      &=
      (sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu))))^2
      \
      &=
      gamma_2(theta_(mu)) gamma_2(-theta_(mu))
      quad (because (sqrt(z))^2 = z)
    $

    $
      gamma_2(-theta_(mu)) gamma_2(-theta_(nu))
      =
      gamma_2(-theta_(mu)) gamma_2(theta_(mu))
      =
      gamma_2(theta_(mu)) gamma_2(-theta_(mu))
    $

    したがって、

    $
      minus
      sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu)))
      sqrt(gamma_2(theta_(nu)) gamma_2(-theta_(nu)))
      +
      gamma_2(-theta_(mu)) gamma_2(-theta_(nu))
      =
      minus gamma_2(theta_(mu)) gamma_2(-theta_(mu))
      +
      gamma_2(theta_(mu)) gamma_2(-theta_(mu))
      =
      0
    $

    $delta^M_(mu + nu, 0) = 0$ のときは全体が $0$。以上から、

    $
      [psi_mu^dagger, psi_nu^dagger]_(+) = 0
    $

    $b) [psi_mu^dagger, psi_nu]_(+)$ について、

    $
      [psi_mu^dagger, psi_nu]_(+)
      &=
      c_mu c_nu
      [
        plus sqrt(-1) sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu))) hat(Z)_mu^((minus))
        +
        gamma_2(-theta_(mu)) hat(Y)_mu
        ,
        minus sqrt(-1) sqrt(gamma_2(theta_(nu)) gamma_2(-theta_(nu))) hat(Z)_nu^((minus))
        +
        gamma_2(-theta_(nu)) hat(Y)_nu
      ]_(+)
      quad (because "双線型性")
      \
      &=
      c_mu c_nu
      (
        (sqrt(-1))(minus sqrt(-1))
        sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu)))
        sqrt(gamma_2(theta_(nu)) gamma_2(-theta_(nu)))
        [hat(Z)_mu^((minus)), hat(Z)_nu^((minus))]_(+)
        \
        & quad
        +
        0
        +
        0
        +
        gamma_2(-theta_(mu)) gamma_2(-theta_(nu))
        [hat(Y)_mu, hat(Y)_nu]_(+)
      )
      quad (because [hat(Z)_mu^((minus)), hat(Y)_nu]_(+) = 0)
      \
      &=
      c_mu c_nu
      (
        sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu)))
        sqrt(gamma_2(theta_(nu)) gamma_2(-theta_(nu)))
        +
        gamma_2(-theta_(mu)) gamma_2(-theta_(nu))
      )
      dot.op 2M delta^M_(mu + nu, 0) I_((CC^2)^(times.o M))
    $

    $delta^M_(mu + nu, 0) eq.not 0$ のとき、$a)$ と同じ計算により、

    $
      sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu)))
      sqrt(gamma_2(theta_(nu)) gamma_2(-theta_(nu)))
      &=
      gamma_2(theta_(mu)) gamma_2(-theta_(mu))
      \
      gamma_2(-theta_(mu)) gamma_2(-theta_(nu))
      &=
      gamma_2(theta_(mu)) gamma_2(-theta_(mu))
    $

    であるから、係数の和は

    $
      sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu)))
      sqrt(gamma_2(theta_(nu)) gamma_2(-theta_(nu)))
      +
      gamma_2(-theta_(mu)) gamma_2(-theta_(nu))
      =
      2 gamma_2(theta_(mu)) gamma_2(-theta_(mu))
    $

    また、$c_mu c_nu = (1) / (4M gamma_2(-theta_(mu)) gamma_2(-theta_(nu)))$ で、$gamma_2(-theta_(nu)) = gamma_2(theta_(mu))$ より、

    $
      c_mu c_nu
      =
      (1) / (4M gamma_2(-theta_(mu)) gamma_2(theta_(mu)))
      =
      (1) / (4M gamma_2(theta_(mu)) gamma_2(-theta_(mu)))
    $

    よって、

    $
      [psi_mu^dagger, psi_nu]_(+)
      &=
      (1) / (4M gamma_2(theta_(mu)) gamma_2(-theta_(mu)))
      dot.op
      2 gamma_2(theta_(mu)) gamma_2(-theta_(mu))
      dot.op 2M
      dot.op delta^M_(mu + nu, 0) I_((CC^2)^(times.o M))
      \
      &=
      delta^M_(mu + nu, 0) I_((CC^2)^(times.o M))
    $

    $delta^M_(mu + nu, 0) = 0$ のときは全体が $0$。以上から、

    $
      [psi_mu^dagger, psi_nu]_(+) = delta^M_(mu + nu, 0) I_((CC^2)^(times.o M))
    $

    $c) [psi_mu, psi_nu]_(+)$ について、

    $
      [psi_mu, psi_nu]_(+)
      &=
      c_mu c_nu
      [
        minus sqrt(-1) sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu))) hat(Z)_mu^((minus))
        +
        gamma_2(-theta_(mu)) hat(Y)_mu
        ,
        minus sqrt(-1) sqrt(gamma_2(theta_(nu)) gamma_2(-theta_(nu))) hat(Z)_nu^((minus))
        +
        gamma_2(-theta_(nu)) hat(Y)_nu
      ]_(+)
      quad (because "双線型性")
      \
      &=
      c_mu c_nu
      (
        (minus sqrt(-1))(minus sqrt(-1))
        sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu)))
        sqrt(gamma_2(theta_(nu)) gamma_2(-theta_(nu)))
        [hat(Z)_mu^((minus)), hat(Z)_nu^((minus))]_(+)
        \
        & quad
        +
        0
        +
        0
        +
        gamma_2(-theta_(mu)) gamma_2(-theta_(nu))
        [hat(Y)_mu, hat(Y)_nu]_(+)
      )
      \
      &=
      c_mu c_nu
      (
        minus
        sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu)))
        sqrt(gamma_2(theta_(nu)) gamma_2(-theta_(nu)))
        +
        gamma_2(-theta_(mu)) gamma_2(-theta_(nu))
      )
      dot.op 2M delta^M_(mu + nu, 0) I_((CC^2)^(times.o M))
    $

    $a)$ と同じ式であるから、同じ議論により、

    $
      [psi_mu, psi_nu]_(+) = 0
    $

    $qed$
  ]
]<anticommutator_of_psi>
