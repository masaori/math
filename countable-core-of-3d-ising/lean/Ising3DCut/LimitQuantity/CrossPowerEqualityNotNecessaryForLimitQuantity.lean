/-
人手証明の主張「ずらした自由族は評価点 2 の箱 L=2 で交差べき等式が破れる」
（ラベル `claim_shifted_free_family_cross_power_equality_fails_at_two`）と
「ずらした自由族は交差べき等式が極限量に対して必要でないことの反例である」
（ラベル `claim_shifted_free_family_cross_power_equality_is_not_necessary_for_limit_quantity`）
の Lean 具体版。

SageMath の厳密計算で得た二つの値 `Z₂(2)=36450`、`Z'₂(2)=Z₃(2)=942223653336523266` を
そのまま置く。人手証明は素因数 2 の指数（27 と 8）の不一致で交差べき等式の破れを示すが、
ここでは同じ内容を「2 で割った奇数部分」への分解と、27 乗・8 乗のあとの偶奇の食い違いで示す
（`padicValNat` の well-founded 再帰は `decide` で展開しないため、奇数判定だけで済む形に直した）。
極限量の一致は既存の末尾ずらし極限定理から従う。ℝ への脱出は仮定・結論の箱の大きさの極限だけである。
-/
import Ising3DCut.LimitQuantity.TailShiftLimit

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 自由境界の `Z₂` の評価点 2 での値。 -/
def freeBoxTwoValueAtTwo : ℕ := 36450

/-- ずらした自由族の `Z'₂ = Z₃` の評価点 2 での値。 -/
def shiftedFreeBoxTwoValueAtTwo : ℕ := 942223653336523266

/-- `Z₂(2)` を 2 で割った奇数部分。 -/
def freeBoxTwoValueAtTwoOddPart : ℕ := 18225

/-- `Z'₂(2) = Z₃(2)` を 2 で割った奇数部分。 -/
def shiftedFreeBoxTwoValueAtTwoOddPart : ℕ := 471111826668261633

/-- `Z₂(2) = 2 · 18225`（有限計算）。 -/
theorem freeBoxTwoValueAtTwo_eq_two_mul :
    freeBoxTwoValueAtTwo = 2 * freeBoxTwoValueAtTwoOddPart := by decide

/-- `Z'₂(2) = 2 · 471111826668261633`（有限計算）。 -/
theorem shiftedFreeBoxTwoValueAtTwo_eq_two_mul :
    shiftedFreeBoxTwoValueAtTwo = 2 * shiftedFreeBoxTwoValueAtTwoOddPart := by decide

/-- `471111826668261633` は奇数（一の位が `3`）。 -/
theorem shiftedFreeBoxTwoValueAtTwoOddPart_odd :
    Odd shiftedFreeBoxTwoValueAtTwoOddPart := by
  rw [Nat.odd_iff]; decide

/-- 交差べき等式 `Z₂(2)^27 = Z'₂(2)^8` は破れる。
両辺を `2 · (奇数)` の 27 乗・8 乗として展開すると、`2^27` と `2^8 = 2^8 · 2^19` の比較から
`2^19 · 18225^27 = (奇数部分)^8` が従うことになるが、左辺は偶数、右辺は奇数の冪で奇数なので
矛盾する。用いた根拠は算術の基本定理と同値な、有限自然数の偶奇の一意性だけである。 -/
theorem crossPowerEquality_fails_at_two :
    freeBoxTwoValueAtTwo ^ 27 ≠ shiftedFreeBoxTwoValueAtTwo ^ 8 := by
  intro heq
  rw [freeBoxTwoValueAtTwo_eq_two_mul, shiftedFreeBoxTwoValueAtTwo_eq_two_mul,
    mul_pow, mul_pow, show (27 : ℕ) = 8 + 19 from rfl, pow_add, mul_assoc] at heq
  have hcancel :
      2 ^ 19 * freeBoxTwoValueAtTwoOddPart ^ 27 =
        shiftedFreeBoxTwoValueAtTwoOddPart ^ 8 :=
    Nat.eq_of_mul_eq_mul_left (show 0 < (2 : ℕ) ^ 8 by norm_num) heq
  have hdvd : (2 : ℕ) ∣ shiftedFreeBoxTwoValueAtTwoOddPart ^ 8 :=
    ⟨2 ^ 18 * freeBoxTwoValueAtTwoOddPart ^ 27, hcancel.symm.trans (by ring)⟩
  obtain ⟨k, hk⟩ := shiftedFreeBoxTwoValueAtTwoOddPart_odd.pow (n := 8)
  obtain ⟨c, hc⟩ := hdvd
  omega

/-- ずらした自由族の判定枠で、交差べき等式は極限量に対して必要でない。
交差べき等式の破れは有限整数算術の証明書であり、極限量の一致は既存の末尾ずらし極限定理
（`shiftedFreeFiniteBoxQuantitySeq_limit_eq`）から従う。 -/
theorem cross_power_equality_is_not_necessary_for_limit_quantity
    (N : ℕ → ℕ) (α α' : ℝ)
    (h : Tendsto (rootSeq (finiteBoxValueSeq (2 : ℚ)) N) atTop (𝓝 α))
    (h' : Tendsto (shiftedFreeFiniteBoxQuantitySeq (2 : ℚ) N) atTop (𝓝 α')) :
    freeBoxTwoValueAtTwo ^ 27 ≠ shiftedFreeBoxTwoValueAtTwo ^ 8 ∧ α' = α :=
  ⟨crossPowerEquality_fails_at_two, shiftedFreeFiniteBoxQuantitySeq_limit_eq (2 : ℚ) N α α' h h'⟩

end Ising3DCut.LimitQuantity
