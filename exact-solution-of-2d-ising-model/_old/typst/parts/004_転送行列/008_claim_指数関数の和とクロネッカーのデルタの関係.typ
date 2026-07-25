#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#claim(none)[
  $k in ZZ "について、"$
  $
    \
    sum_(j=1)^M exp(k dot (2 pi sqrt(-1) j)/M) = M delta^M_((k, 0))
  $

  #proof[
    $(a) k equiv 0 mod M$のとき、
    $l in ZZ$を用いて$k = l M$とおけるので、
    $
      sum_(j=1)^M exp(l M dot.op (2 pi sqrt(-1) j)/M)
      &= sum_(j=1)^M exp(l dot.op 2 pi sqrt(-1) j)
      \
      &= sum_(j=1)^M cos(2 pi l j) + sqrt(-1) sin(2 pi l j)
      \
      &= sum_(j=1)^M (1 + sqrt(-1) dot.op 0)
      \
      &= sum_(j=1)^M 1
      = M
    $

    $(b)$その他のとき、
    $
      sum_(j=1)^M exp(k dot.op (2 pi sqrt(-1) j)/M)
      &=
      overbrace(
        exp(k dot.op (2 pi sqrt(-1))/M)
        ,
        "初項"
      )
      dot.op
      (
        1
        -
        (
          overbrace(
            exp(k dot.op (2 pi sqrt(-1))/M)
            ,
            "公比"
          )
        )
        ^M
      )
      /
      (
        1
        -
        overbrace(
          exp(k dot.op (2 pi sqrt(-1))/M)
          ,
          "公比"
        )
      )
      \
      &=
      (
        overbrace(
          exp(k dot.op (2 pi sqrt(-1))/M)
          ,
          "初項"
        )
      )
      /
      (
        1
        -
        overbrace(
          exp(k dot.op (2 pi sqrt(-1))/M)
          ,
          "公比"
        )
      )
      dot.op
      (
        1
        -
        (
          overbrace(
            exp(k dot.op (2 pi sqrt(-1))/M)
            ,
            "公比"
          )
        )
        ^M
      )
      \
      &=
      (
        exp(k dot.op (2 pi sqrt(-1))/M)
      )
      /
      (
        1
        -
        exp(k dot.op (2 pi sqrt(-1))/M)
      )
      dot.op
      (
        1
        -
        exp(k dot.op (2 pi sqrt(-1))/M dot.op M)
      )
      \
      &=
      (
        exp(k dot.op (2 pi sqrt(-1))/M)
      )
      /
      (
        1
        -
        exp(k dot.op (2 pi sqrt(-1))/M)
      )
      dot.op
      (
        1
        -
        underbrace(
          exp(k dot.op 2 pi sqrt(-1))
          ,
          1
        )
      )
      \
      &=
      0
    $
  ]
]<exp_sum>
