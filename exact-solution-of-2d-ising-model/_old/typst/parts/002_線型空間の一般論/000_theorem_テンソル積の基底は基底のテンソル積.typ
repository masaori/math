#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#theorem([テンソル冪の基底は基底のテンソル積の族])[
  $m, n in ZZ_(>= 1)$ とする。

  $V$ を $n$ 次元 $K$-線型空間、$E = { e_1, dots, e_n }$ を $V$ の基底とするとき、
  多重添字 $(i_1, dots, i_m) in {1, dots, n}^(m)$ で添字づけられた**族**

  $
    {
      e_(i_1) times.o dots.c times.o e_(i_m)
      mid(|)
      (i_1, dots, i_m) in {1, dots, n}^(m)
    }
  $

  は、$m$ 階テンソル冪 $V^(times.o m)$ の基底である。特に $dim_(K) V^(times.o m) = n^m$ である。

  #note[
    基底であるのは**族全体**であって、個々のテンソル積 $e_(i_1) times.o dots.c times.o e_(i_m)$
    ではない（単一の元は $1$ 次元しか張らないので、$n^m >= 2$ のとき基底になり得ない）。

    また、$V$ の次元 $n$ とテンソル冪の階数 $m$ は独立な量である。
    本論文での主な用途は $V = "Mat"(2, CC)$（$n = 4$）、$m = M$（格子の周期）の場合であり、
    $#ref(<Z_Y_generate_algebra>) $ や $#ref(<centralizer_is_scalar>)$ で
    $"Mat"(2, CC)^(times.o M)$ の基底を得るために使う。
  ]

  #proof[TODO]
]<tensor_basis>
