import Mathlib

/-!
「有理点での四つの符号付き偶部分グラフ多項式の符号」（`claim_signed_even_subgraph_rational_sign`）の
軌道積の各因子の符号の段の必要十分版。

具体版 `Ising2DLambda.KacWard.orbitDispersion_pos_at_rationalPoint`・
`Ising2DLambda.KacWard.oneElementOrbitFactor_eval_at_rationalPoint` と同じ手順で示す。

分散因子の段（`orbit_dispersion_pos_necSuf`）が使うのは次だけである。
* 狭義順序 `lt` の推移律 `htrans`。これが無いと、`0 < P ≤ D` から `0 < D` が出ない（狭義の場合）。
* 値の埋め込み `emb : K → V` は任意の写像でよい（部分体の包含である必要は無い）。
* `hO`（軌道の因子が、ある元の因子に等しい。元の選択に依らないこと）と、
  `hpos`（各元で `0 < P ≤ D`）が無いと、軌道の因子に下界が付かない。
加法・乗法・平方の三分法・`P` が平方であることは使わない。

一元軌道の段（`one_element_factor_sign_necSuf`）が使うのは、狭義順序環（`Ring`＋`PartialOrder`＋
`IsStrictOrderedRing`）だけである。積の可換性は使わない（`1 − 2q − q² = −(q²+2q−1)` と
`(1 − q²) + 2q = 1 + 2q − q²` は加法群の等式、`q·q < q·1` は正の元を左から掛ける単調性）。
体である必要も無い（除法は使わない）。
-/

namespace Ising2DLambda.NecSuf.KacWard

/-- 必要十分版（分散因子の段）: 軌道の因子 `f O` が、ある元の因子 `g m` に等しく、各元で
`emb D = g m`、`z < P`、`P ≤ D` なら、`emb D = f O` かつ `z < D` となる `D` がある。 -/
theorem orbit_dispersion_pos_necSuf {ι μ K V : Type*} (lt : K → K → Prop)
    (htrans : ∀ a b c, lt a b → lt b c → lt a c) (emb : K → V) (z P : K)
    (f : ι → V) (g : μ → V) (O : ι) (hO : ∃ m, f O = g m)
    (hpos : ∀ m, ∃ D, emb D = g m ∧ lt z P ∧ (lt P D ∨ P = D)) :
    ∃ D, emb D = f O ∧ lt z D := by
  -- `O` の元 `m` を取る
  obtain ⟨m, hm⟩ := hO
  -- `z < P ≤ D`
  obtain ⟨D, hD, hp, hpD⟩ := hpos m
  refine ⟨D, ?_, ?_⟩
  · -- 元の因子は軌道の因子に等しい
    exact hD.trans hm.symm
  · rcases hpD with hlt | heq
    · -- 狭義なら推移律
      exact htrans _ _ _ hp hlt
    · -- 等号なら一つ目の不等式そのもの
      rw [← heq]
      exact hp

/-- 必要十分版（一元軌道の段）: 三つの場合で定めた因子
`F := if c₁ then 1 − 2q − q² else if c₂ then 1 + 2q − q² else 1 + q²` は、`0 < q < 1` のとき、
`c₁` なら `−(q² + 2q − 1)` に等しく、`¬c₁` なら正である。 -/
theorem one_element_factor_sign_necSuf {K : Type*} [Ring K] [PartialOrder K] [IsStrictOrderedRing K]
    (q : K) (hq0 : 0 < q) (hq1 : q < 1) (c₁ c₂ : Prop) [Decidable c₁] [Decidable c₂] :
    (c₁ ∧ (if c₁ then 1 - 2 * q - q ^ 2 else if c₂ then 1 + 2 * q - q ^ 2 else 1 + q ^ 2) =
        -(q ^ 2 + 2 * q - 1)) ∨
      (¬c₁ ∧ 0 < (if c₁ then 1 - 2 * q - q ^ 2 else if c₂ then 1 + 2 * q - q ^ 2 else 1 + q ^ 2)) := by
  by_cases h1 : c₁
  · -- `1 − 2q − q² = −(q² + 2q − 1)`（加法逆元）
    left
    refine ⟨h1, ?_⟩
    rw [if_pos h1]
    abel
  · right
    refine ⟨h1, ?_⟩
    rw [if_neg h1]
    by_cases h2 : c₂
    · -- `1 + 2q − q² = (1 − q²) + 2q > 0`
      rw [if_pos h2]
      have hq2 : q ^ 2 < 1 := by
        calc q ^ 2 = q * q := pow_two q
          _ < q * 1 := mul_lt_mul_of_pos_left hq1 hq0
          _ = q := mul_one q
          _ < 1 := hq1
      have hA : 0 < 1 - q ^ 2 := sub_pos.mpr hq2
      have hB : 0 < 2 * q := by
        rw [two_mul]
        exact add_pos hq0 hq0
      have hsum : (1 - q ^ 2) + 2 * q = 1 + 2 * q - q ^ 2 := by abel
      rw [← hsum]
      exact add_pos hA hB
    · -- `1 + q² > 0`
      rw [if_neg h2]
      have hq2 : 0 < q ^ 2 := by
        rw [pow_two]
        exact mul_pos hq0 hq0
      exact add_pos one_pos hq2

end Ising2DLambda.NecSuf.KacWard
