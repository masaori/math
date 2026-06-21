#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#claim([共役写像は環準同型])[
  $n in ZZ_(>=1)$ とする。

  $B in ("Mat"(n, CC))^(times)$（正則）について、共役写像 $T_(B): "Mat"(n, CC) -> "Mat"(n, CC)$, $T_(B)(A) = B A B^(-1)$ は次を満たす。

  1. 乗法的: 任意の $A, C in "Mat"(n, CC)$ について $T_(B)(A C) = T_(B)(A) T_(B)(C)$
  2. 単位的: $T_(B)(I) = I$
  3. 合成則: $A, B in ("Mat"(n, CC))^(times)$（正則）について $T_(A) compose T_(B) = T_(A B)$

  #proof[
    === Step 1: 乗法性

    $A, C in "Mat"(n, CC)$ に対して、

    $
      T_(B)(A C)
      &=
      B (A C) B^(-1)
      quad (because #ref(<mat_conj>))
      \
      &=
      B A C B^(-1)
      quad (because "行列の積の結合法則")
      \
      &=
      B A I C B^(-1)
      quad (because "単位元の性質 " I C = C)
      \
      &=
      B A (B^(-1) B) C B^(-1)
      quad (because B^(-1) B = I)
      \
      &=
      (B A B^(-1)) (B C B^(-1))
      quad (because "行列の積の結合法則")
      \
      &=
      T_(B)(A) (B C B^(-1))
      quad (because #ref(<mat_conj>))
      \
      &=
      T_(B)(A) T_(B)(C)
      quad (because #ref(<mat_conj>))
    $

    === Step 2: 単位性

    $
      T_(B)(I)
      &=
      B I B^(-1)
      quad (because #ref(<mat_conj>))
      \
      &=
      B B^(-1)
      quad (because "単位元の性質 " B I = B)
      \
      &=
      I
      quad (because B B^(-1) = I)
    $

    === Step 3: 合成則

    $A, B in ("Mat"(n, CC))^(times)$（正則）とする。

    まず、行列の積の逆元 $(A B)^(-1) = B^(-1) A^(-1)$ を確認する。$B^(-1) A^(-1)$ が $A B$ の右逆元かつ左逆元であることを示せばよい。

    $
      (A B) (B^(-1) A^(-1))
      &=
      A (B B^(-1)) A^(-1)
      quad (because "行列の積の結合法則")
      \
      &=
      A I A^(-1)
      quad (because B B^(-1) = I)
      \
      &=
      A A^(-1)
      quad (because "単位元の性質 " A I = A)
      \
      &=
      I
      quad (because A A^(-1) = I)
    $

    $
      (B^(-1) A^(-1)) (A B)
      &=
      B^(-1) (A^(-1) A) B
      quad (because "行列の積の結合法則")
      \
      &=
      B^(-1) I B
      quad (because A^(-1) A = I)
      \
      &=
      B^(-1) B
      quad (because "単位元の性質 " I B = B)
      \
      &=
      I
      quad (because B^(-1) B = I)
    $

    よって、$B^(-1) A^(-1)$ は $A B$ の両側逆元であり、逆元の一意性から $(A B)^(-1) = B^(-1) A^(-1)$ が成り立つ。

    任意の $M in "Mat"(n, CC)$ に対して、

    $
      (T_(A) compose T_(B))(M)
      &=
      T_(A)(T_(B)(M))
      quad (because "写像の合成の定義")
      \
      &=
      T_(A)(B M B^(-1))
      quad (because #ref(<mat_conj>))
      \
      &=
      A (B M B^(-1)) A^(-1)
      quad (because #ref(<mat_conj>))
      \
      &=
      (A B) M (B^(-1) A^(-1))
      quad (because "行列の積の結合法則")
      \
      &=
      (A B) M (A B)^(-1)
      quad (because (A B)^(-1) = B^(-1) A^(-1))
      \
      &=
      T_(A B)(M)
      quad (because #ref(<mat_conj>))
    $

    が成り立つ。

    よって、任意の $M in "Mat"(n, CC)$ について $(T_(A) compose T_(B))(M) = T_(A B)(M)$ であるから、$T_(A) compose T_(B) = T_(A B)$ である。

    $qed$
  ]
]<conjugation_is_ring_homomorphism>
