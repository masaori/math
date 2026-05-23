#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#theorem("可換行列の exp 積公式")[
  $K := RR$ または $K := CC$, $n in ZZ_(>= 1)$

  $A, B in "Mat"(n, K)$ が $A B = B A$ を満たすとき、

  $
    exp(A) exp(B) = exp(A + B)
  $

  #proof[
    TODO:

    前提として $#ref(<exp_converges>)$（exp 級数の収束）を用いる。

    証明の骨格:

    1. 二項定理（$A B = B A$ より）:
    $
      (A + B)^k = sum_(j=0)^k binom(k, j) A^j B^(k-j)
    $

    2. exp の定義を展開し、積 $exp(A) exp(B)$ の部分和と $exp(A+B)$ の部分和を比較する。

    3. $exp$ 級数がノルム収束することから、有限次元行列のノルムの劣乗法性
    $||X Y|| <= ||X|| ||Y||$
    を用いて、部分和の差がノルムで $0$ に収束することを示す。

    これらはすべて行列計算と級数のノルム収束のみで完結し、微分は不要。
  ]
]<theorem_exp_product>
