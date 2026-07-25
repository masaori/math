#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#claim([$"Mat"(2, CC)^(times.o M)$ の中で全元と可換な元はスカラー])[
  $M in ZZ_(>= 1)$ とする。$W in "Mat"(2, CC)^(times.o M)$ が、すべての
  $x in "Mat"(2, CC)^(times.o M)$ について
  $
    W x = x W
  $
  を満たすならば、ある $c in CC$ が存在して
  $
    W = c dot.op I_(("Mat"(2, CC))^(times.o M))
  $
  が成り立つ。

  #proof[
    === Step 1: $"Mat"(2, CC)^(times.o M)$ の行列単位

    $"Mat"(2, CC)$ の行列単位を
    $
      E_(1 1) = mat(1, 0; 0, 0),
      quad
      E_(1 2) = mat(0, 1; 0, 0),
      quad
      E_(2 1) = mat(0, 0; 1, 0),
      quad
      E_(2 2) = mat(0, 0; 0, 1)
    $
    とする。これらは $"Mat"(2, CC)$ の $CC$ 上の基底である。実際、任意の
    $
      A = mat(a_(1 1), a_(1 2); a_(2 1), a_(2 2)) in "Mat"(2, CC)
    $
    に対し成分比較により
    $
      A
      =
      a_(1 1) E_(1 1) + a_(1 2) E_(1 2) + a_(2 1) E_(2 1) + a_(2 2) E_(2 2)
      quad (because "成分比較")
    $
    が成り立つので $cal(E)_0 := { E_(1 1), E_(1 2), E_(2 1), E_(2 2) }$ は $"Mat"(2, CC)$ を張り、$dim_(CC) "Mat"(2, CC) = 4 = \# cal(E)_0$ であるから $cal(E)_0$ は $"Mat"(2, CC)$ の基底である。

    成分計算により、行列単位は積について次の関係を満たす。$i, j, k, l in {1, 2}$ について
    $
      E_(i j) E_(k l)
      =
      delta_(j k) E_(i l)
      quad (because "行列の積の成分計算")
    $
    ここで $delta_(j k)$ は Kronecker のデルタ（$j = k$ のとき $1$、そうでなければ $0$）である。特に
    $
      E_(1 1) + E_(2 2)
      =
      mat(1, 0; 0, 1)
      =
      I_("Mat"(2, CC))
      quad (because "成分計算")
    $
    である。

    多重添字 $I = (i_1, dots.c, i_M) in {1, 2}^M$、$J = (j_1, dots.c, j_M) in {1, 2}^M$ について
    $
      E_(I J) := E_(i_1 j_1) times.o E_(i_2 j_2) times.o dots.c times.o E_(i_M j_M)
      in "Mat"(2, CC)^(times.o M)
    $
    とおく。$cal(E)_0$ は $"Mat"(2, CC)$ の基底であるから、集合
    $
      cal(E) := { E_(I J) : I, J in {1, 2}^M }
    $
    は $"Mat"(2, CC)^(times.o M)$ の基底である
    $
      quad (because #ref(<tensor_basis>))
    $
    その元数は $\# cal(E) = (2^M)^2 = 4^M$ である。

    === Step 2: 行列単位 $E_(I J)$ の積公式

    $I = (i_1, dots.c, i_M)$, $J = (j_1, dots.c, j_M)$, $K = (k_1, dots.c, k_M)$, $L = (l_1, dots.c, l_M) in {1, 2}^M$ について、テンソル積上の積の定義と Step 1 の行列単位の積公式より
    $
      E_(I J) E_(K L)
      &=
      (E_(i_1 j_1) times.o dots.c times.o E_(i_M j_M))
      (E_(k_1 l_1) times.o dots.c times.o E_(k_M l_M))
      \
      &=
      (E_(i_1 j_1) E_(k_1 l_1)) times.o dots.c times.o (E_(i_M j_M) E_(k_M l_M))
      quad (because "テンソル積上の積の定義")
      \
      &=
      (delta_(j_1 k_1) E_(i_1 l_1)) times.o dots.c times.o (delta_(j_M k_M) E_(i_M l_M))
      quad (because E_(i j) E_(k l) = delta_(j k) E_(i l))
      \
      &=
      (product_(r=1)^M delta_(j_r k_r))
      E_(I L)
      quad (because "スカラーのテンソル多重線型性")
    $
    が成り立つ。ここで $delta_(J K) := product_(r=1)^M delta_(j_r k_r)$ とおくと、$delta_(J K)$ は $J = K$ のとき $1$、そうでなければ $0$ である（各成分が一致するときに限り積が $1$ となる）。したがって
    $
      E_(I J) E_(K L)
      =
      delta_(J K) E_(I L)
      quad (because delta_(J K) = product_(r=1)^M delta_(j_r k_r))
    $
    である。

    また、$I_(("Mat"(2, CC))^(times.o M)) = I_("Mat"(2, CC)) times.o dots.c times.o I_("Mat"(2, CC))$ であり、各因子に $I_("Mat"(2, CC)) = E_(1 1) + E_(2 2)$ を代入してテンソル積の多重線型性で展開すると
    $
      I_(("Mat"(2, CC))^(times.o M))
      =
      sum_(P in {1, 2}^M) E_(P P)
      quad (because I_("Mat"(2, CC)) = E_(1 1) + E_(2 2) "とテンソル積の多重線型性")
    $
    が成り立つ（各テンソル因子で $E_(1 1)$ または $E_(2 2)$ を選ぶすべての組合せの和）。

    === Step 3: $W$ を行列単位で展開し、可換性から係数を決定する

    $cal(E)$ は $"Mat"(2, CC)^(times.o M)$ の基底（Step 1）であるから、$W$ は一意に
    $
      W = sum_(I, J in {1, 2}^M) w_(I J) E_(I J)
      quad (w_(I J) in CC)
    $
    と展開できる。

    仮定より、$W$ はすべての $x in "Mat"(2, CC)^(times.o M)$ と可換である。特に各 $E_(K L)$（$K, L in {1, 2}^M$）について $W E_(K L) = E_(K L) W$ が成り立つ。両辺を Step 2 の積公式で計算する。左辺は
    $
      W E_(K L)
      &=
      (sum_(I, J) w_(I J) E_(I J)) E_(K L)
      \
      &=
      sum_(I, J) w_(I J) (E_(I J) E_(K L))
      quad (because "積の双線型性")
      \
      &=
      sum_(I, J) w_(I J) delta_(J K) E_(I L)
      quad (because #ref(<tensor_basis>) "に基づく Step 2 の積公式")
      \
      &=
      sum_(I in {1, 2}^M) w_(I K) E_(I L)
      quad (because delta_(J K) "は" J = K "でのみ非零")
    $
    である。右辺は
    $
      E_(K L) W
      &=
      E_(K L) (sum_(I, J) w_(I J) E_(I J))
      \
      &=
      sum_(I, J) w_(I J) (E_(K L) E_(I J))
      quad (because "積の双線型性")
      \
      &=
      sum_(I, J) w_(I J) delta_(L I) E_(K J)
      quad (because "Step 2 の積公式")
      \
      &=
      sum_(J in {1, 2}^M) w_(L J) E_(K J)
      quad (because delta_(L I) "は" I = L "でのみ非零")
    $
    である。$cal(E)$ は基底であるから、$W E_(K L) = E_(K L) W$ の両辺を $cal(E)$ で展開した係数は一致する。

    まず、固定した $K, L in {1, 2}^M$ について、左辺 $sum_(I) w_(I K) E_(I L)$ に現れる基底元は第 2 添字が $L$ のものに限り、右辺 $sum_(J) w_(L J) E_(K J)$ に現れる基底元は第 1 添字が $K$ のものに限る。

    任意に $P, Q in {1, 2}^M$ を固定し、基底元 $E_(P Q)$ の係数を両辺で比較する。

    場合 1: $Q = L$ かつ $P = K$ のとき。左辺で $E_(P L)$ の係数は $w_(P K) = w_(K K)$、右辺で $E_(K Q)$ の係数は $w_(L Q) = w_(L L)$ である。よって
    $
      w_(K K) = w_(L L)
      quad (because E_(K L) "の係数比較")
    $
    が成り立つ。これは任意の $K, L in {1, 2}^M$ について成立するから、対角係数 $w_(K K)$ は $K$ によらない定数である。これを $c := w_(K K)$（$K$ に依存しない）とおく。

    場合 2: $K != L$ とし、$P = K$, $Q = K$ のとき（$E_(K K)$ の係数比較）。第 2 添字が $K != L$ なので左辺 $sum_(I) w_(I K) E_(I L)$ には $E_(K K)$ は現れず、その係数は $0$ である。一方、右辺 $sum_(J) w_(L J) E_(K J)$ で $E_(K K)$ の係数は $w_(L K)$ である。よって
    $
      w_(L K) = 0
      quad (because E_(K K) "の係数比較、" K != L)
    $
    が成り立つ。すなわち $I != J$ なる非対角係数 $w_(I J)$ はすべて $0$ である（上で $L, K$ は任意の相異なる多重添字、$w_(L K)$ はその非対角成分）。

    === Step 4: 結論

    Step 3 より、$W$ の展開は対角項のみが残り、その係数はすべて共通の $c in CC$ に等しい。よって Step 2 の単位元の展開と合わせて
    $
      W
      &=
      sum_(I, J in {1, 2}^M) w_(I J) E_(I J)
      \
      &=
      sum_(P in {1, 2}^M) w_(P P) E_(P P)
      quad (because "Step 3: 非対角係数は" 0)
      \
      &=
      sum_(P in {1, 2}^M) c E_(P P)
      quad (because "Step 3: 対角係数は共通の " c)
      \
      &=
      c sum_(P in {1, 2}^M) E_(P P)
      quad (because "和のスカラー倍")
      \
      &=
      c dot.op I_(("Mat"(2, CC))^(times.o M))
      quad (because I_(("Mat"(2, CC))^(times.o M)) = sum_(P in {1, 2}^M) E_(P P))
    $
    が成り立つ。

    $qed$
  ]
]<centralizer_is_scalar>
