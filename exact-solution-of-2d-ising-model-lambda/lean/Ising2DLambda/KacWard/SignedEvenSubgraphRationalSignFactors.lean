/-
「有理点での四つの符号付き偶部分グラフ多項式の符号」（`claim_signed_even_subgraph_rational_sign`）の
具体版のうち、軌道積の各因子を有理点 `q`（`0 < q < 1`）で評価したときの符号の段。
`(1,1)` がモード集合に属する条件と、積の符号の合成は別のファイルで行う。

  人手証明                                                    このファイル・引く具体版
  `O ∈ 𝔐` の元 `(ϖ, ς) ∈ 𝒦` を取る                             `mem_modeInversionOrbits`
  `0 <_R (q²+2q−1)² ≤_R Δ(q; ϖ, ς)`                            `dispersion_positive_at_rationalPoint`
  `Δ(q; ϖ, ς) = Δ_O(q)`（元の選択に依らない）                   `orbitDispersion_eq`
  等号なら一つ目の不等式、狭義なら推移律で `0 <_R Δ_O(q)`       `realAlgebraicLt_trans`
  一元軌道の因子 `F_O` は定義から三種類                         `oneElementOrbitFactor` の場合分け
    `1 + q² > 0`（`0 < q` と ℚ の順序）
    `1 + 2q − q² = (1 − q²) + 2q > 0`（`0 < q < 1`）
    `1 − 2q − q² = −(q² + 2q − 1)`（ℚ の加法逆元）

必要十分版の定理・定義は使わない。住処は Q と Qbar（実閉部分体 R ⊂ Qbar）。実数体・複素数体は現れない。
-/
import Ising2DLambda.KacWard.SignedEvenSubgraphOrbitProductSquare
import Ising2DLambda.KacWard.DispersionPositiveAtRationalPoint
import Ising2DLambda.FisherZero.RealAlgebraicOrderTransitive

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero
open Ising2DLambda.CriticalExponent
open Classical

/-- 軌道 `O ∈ 𝔐` の分散因子は有理点で `R` の正の元である: `Δ_O(q) ∈ R` かつ `0 <_R Δ_O(q)`。 -/
theorem orbitDispersion_pos_at_rationalPoint (data : RealClosedSubfieldData) {L : ℕ} [NeZero L]
    {s : SpinStructure} {O : Finset (Qbar × Qbar)} (hO : O ∈ modeInversionOrbits L s)
    (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) :
    ∃ D : data.carrier,
      (D : Qbar) = (orbitDispersion O).eval (q : Qbar) ∧ realAlgebraicLt data 0 D := by
  have hL : 1 ≤ L := Nat.one_le_iff_ne_zero.mpr (NeZero.ne L)
  -- `O` の元 `(ϖ, ς) ∈ 𝒦` を取る
  obtain ⟨m, rfl⟩ := mem_modeInversionOrbits hO
  -- `0 <_R (q²+2q−1)² ≤_R Δ(q; ϖ, ς)`（`claim_dispersion_positive_at_rational_point`）
  obtain ⟨D, hD, hp, hpD⟩ :=
    dispersion_positive_at_rationalPoint data L hL s m.1.1 m.1.2 m.2.1 m.2.2 q hq0 hq1
  refine ⟨D, ?_, ?_⟩
  · -- `Δ(q; ϖ, ς) = Δ_O(q)`（元の選択に依らない）
    rw [hD, orbitDispersion_eq m]
  · rcases hpD with hlt | heq
    · -- 狭義なら推移律（`claim_real_algebraic_order_transitive`）
      exact realAlgebraicLt_trans data _ _ _ hp hlt
    · -- 等号なら一つ目の不等式そのもの
      rw [← heq]
      exact hp

/-- 一元軌道の因子 `F_O` の有理点での値: 代表元が `(1,1)` なら `−(q²+2q−1)`、
それ以外なら正の有理数。 -/
theorem oneElementOrbitFactor_eval_at_rationalPoint (O : Finset (Qbar × Qbar)) (q : ℚ)
    (hq0 : 0 < q) (hq1 : q < 1) :
    (orbitRepresentative O = (1, 1) ∧
        (oneElementOrbitFactor O).eval (q : Qbar) = ((-(q ^ 2 + 2 * q - 1) : ℚ) : Qbar)) ∨
      (orbitRepresentative O ≠ (1, 1) ∧
        ∃ r : ℚ, 0 < r ∧ (oneElementOrbitFactor O).eval (q : Qbar) = (r : Qbar)) := by
  unfold oneElementOrbitFactor
  by_cases h11 : orbitRepresentative O = (1, 1)
  · -- `F_O = 1 − 2x − x²`: `1 − 2q − q² = −(q² + 2q − 1)`（ℚ の加法逆元）
    left
    refine ⟨h11, ?_⟩
    rw [if_pos h11]
    simp only [eval_sub, eval_mul, eval_pow, eval_X, eval_one, eval_ofNat]
    push_cast
    ring
  · right
    refine ⟨h11, ?_⟩
    rw [if_neg h11]
    by_cases hmm : orbitRepresentative O = (-1, -1)
    · -- `F_O = 1 + 2x − x²`: `1 + 2q − q² = (1 − q²) + 2q > 0`（`0 < q < 1`）
      rw [if_pos hmm]
      refine ⟨(1 - q ^ 2) + 2 * q, ?_, ?_⟩
      · have hq2 : q ^ 2 < 1 := by
          calc q ^ 2 = q * q := by ring
            _ < q * 1 := mul_lt_mul_of_pos_left hq1 hq0
            _ = q := by ring
            _ < 1 := hq1
        have h1 : 0 < 1 - q ^ 2 := by linarith
        have h2 : 0 < 2 * q := by linarith
        exact add_pos h1 h2
      · simp only [eval_sub, eval_add, eval_mul, eval_pow, eval_X, eval_one, eval_ofNat]
        push_cast
        ring
    · -- `F_O = 1 + x²`: `1 + q² > 0`（`0 < q` と ℚ の順序）
      rw [if_neg hmm]
      refine ⟨1 + q ^ 2, ?_, ?_⟩
      · have h2 : 0 < q ^ 2 := pow_pos hq0 2
        linarith
      · simp only [eval_add, eval_pow, eval_X, eval_one]
        push_cast
        ring

end Ising2DLambda.KacWard
