/-
「粗視化 $q\mapsto\varepsilon_{L,q}(\mathcal Z_L)$ は極限量に対して十分である」の Lean 具体版。

$\pi_L(q):=Z_L(q)$（多変数分配多項式の全辺変数を $q$ に置いた値は分配多項式の値に等しい）。
粗視化であること：$\pi_L(q)$ は列 $S_q$ の第 $L$ 項の第二成分（素指数データ、ここでは各素数の $p$ 進付値）
から定まる（`rat_eq_of_prime_exponents_eq` の再利用）。
十分性：全 $L\ge1$ で $\pi_L(q)=\pi_L(q')$ なら極限量が等しい（`limitQuantity_eq_of_finiteBox_eq` の合成）。
実数の等式は結論の極限量の等式だけである。
-/
import Ising3DCut.LimitQuantity.FiniteBoxEqualitiesTransfer

namespace Ising3DCut.LimitQuantity

open NullModel Filter Topology

/-- 粗視化 `π_L(q) := Z_L(q)`（有理数値）。 -/
noncomputable def partitionValueCoarseGraining (L : ℕ) (q : ℚ) : ℚ :=
  evalAtRational q (partitionPolynomial L)

/-- 粗視化であること：正の有理点 `q q'` について、第 `L` 項の素指数データが一致すれば
`π_L(q) = π_L(q')`。 -/
theorem partitionValueCoarseGraining_eq_of_prime_exponents_eq
    {q q' : ℚ} (hq : 0 < q) (hq' : 0 < q') {L : ℕ} (hL : 0 < L)
    (h : ∀ p : ℕ, p.Prime →
      padicValRat p (evalAtRational q (partitionPolynomial L)) =
        padicValRat p (evalAtRational q' (partitionPolynomial L))) :
    partitionValueCoarseGraining L q = partitionValueCoarseGraining L q' :=
  rat_eq_of_prime_exponents_eq
    (partitionPolynomial_evalAtRational_pos hL hq)
    (partitionPolynomial_evalAtRational_pos hL hq') h

/-- 十分性：全 `L ≥ 1` で `π_L(q) = π_L(q')` なら、両側の極限量が存在すれば等しい。 -/
theorem limitQuantity_eq_of_partitionValueCoarseGraining_eq {q q' : ℚ} (N : ℕ → ℕ)
    (h : ∀ L : ℕ, 0 < L → partitionValueCoarseGraining L q = partitionValueCoarseGraining L q')
    (ℓ ℓ' : ℝ) (hq : Tendsto (rootSeq (finiteBoxValueSeq q) N) atTop (𝓝 ℓ))
    (hq' : Tendsto (rootSeq (finiteBoxValueSeq q') N) atTop (𝓝 ℓ')) : ℓ = ℓ' :=
  limitQuantity_eq_of_finiteBox_eq N h ℓ ℓ' hq hq'

end Ising3DCut.LimitQuantity
