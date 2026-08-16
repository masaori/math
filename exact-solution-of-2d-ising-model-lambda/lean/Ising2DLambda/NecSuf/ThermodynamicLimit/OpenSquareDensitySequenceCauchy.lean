/-
「開境界正方形の密度の列は Cauchy 列である」の必要十分版。

具体版が使うのは次だけである。元の住処 `X` について零 `[Zero X]`（`0 ≤ ε` を述べる名前としてだけ要る）、
逆元 `[Neg X]`、ℚ の作用 `[SMul ℚ X]` と、関係 `le` について
(1) 推移律（`claim_rational_log_order_group_linear_order` の推移律の部分）、
(2) 逆元の順序反転（`claim_rational_log_order_group_neg_reverses_order`）、
そして列の差 `d L M`（具体版では `Ψ_L + (−Ψ_M)`）と核 `Γ` と基準辺 `a` ごとの評価 `R a` について
(3) 核の等式 `(1/a) • Γ = R a`（`claim_open_square_density_difference_bound_is_core_over_base_side`）、
(4) 差の上からの一様な評価（`claim_open_square_large_sides_density_difference_upper_le_one`）、
(5) 差の下からの一様な評価（`claim_open_square_large_sides_density_difference_lower_le_one`）、
(6) 核についての Archimedes 性（`claim_rational_log_order_group_archimedean` を `μ := Γ` で読んだもの。
    核の非負はここに吸収される）、
(7) 倍率以上の自然数で割れば上界を超えないこと（`claim_rational_log_order_group_div_ge_multiplier_le`）。
`X` の加法・群の公理・順序の線形性は使わない。`a := n+2`、`N := a²` の選び方は ℕ の順序と四則だけで、そこは一般化しない。
-/
import Mathlib.Tactic.Linarith
import Mathlib.Algebra.Field.Rat

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {X : Type*} [Zero X] [Neg X] [SMul ℚ X]

/-- 差 `d L M` の一様な上下の評価と、核の Archimedes 性から、Cauchy 性（`N := (n+2)²`）。 -/
theorem cauchy_of_uniform_difference_bounds_necSuf (le : X → X → Prop)
    (htrans : ∀ x y z : X, le x y → le y z → le x z)
    (hneg : ∀ x y : X, le x y → le (-y) (-x))
    (d : ℕ → ℕ → X) (Γ : X) (R : ℕ → X)
    (hcore : ∀ a : ℕ, 1 ≤ a → ((1 : ℚ) / a) • Γ = R a)
    (hup : ∀ a L M : ℕ, 1 ≤ a → a < L → a < M → a ^ 2 ≤ L → a ^ 2 ≤ M → le (d L M) (R a))
    (hlow : ∀ a L M : ℕ, 1 ≤ a → a < L → a < M → a ^ 2 ≤ L → a ^ 2 ≤ M → le (-(R a)) (d L M))
    (harch : ∀ ε : X, le 0 ε → ε ≠ 0 → ∃ n : ℕ, le Γ ((n : ℚ) • ε))
    (hdiv : ∀ (ε : X) (n a : ℕ), le 0 ε → le Γ ((n : ℚ) • ε) → 1 ≤ a → n ≤ a →
      le (((1 : ℚ) / a) • Γ) ε)
    (ε : X) (hε : le 0 ε) (hne : ε ≠ 0) :
    ∃ N : ℕ, 1 ≤ N ∧ ∀ L M : ℕ, N ≤ L → N ≤ M → le (-ε) (d L M) ∧ le (d L M) ε := by
  -- 準備の第一: (6) の倍率 n、a := n+2、N := a²
  obtain ⟨n, hn⟩ := harch ε hε hne
  set a : ℕ := n + 2 with ha_def
  have ha1 : 1 ≤ a := by omega
  have hna : n ≤ a := by omega
  have haa : a < a ^ 2 := by nlinarith
  refine ⟨a ^ 2, le_trans ha1 (le_of_lt haa), ?_⟩
  intro L M hL hM
  -- 準備の第二: 辺の条件
  have haL : a < L := lt_of_lt_of_le haa hL
  have haM : a < M := lt_of_lt_of_le haa hM
  -- 準備の第三: (7)
  have hdivΓ : le (((1 : ℚ) / a) • Γ) ε := hdiv ε n a hε hn ha1 hna
  -- (3) で R a を (1/a) • Γ へ読み替える
  have hup' := hup a L M ha1 haL haM hL hM
  have hlow' := hlow a L M ha1 haL haM hL hM
  rw [← hcore a ha1] at hup' hlow'
  exact ⟨htrans _ _ _ (hneg _ _ hdivΓ) hlow', htrans _ _ _ hup' hdivΓ⟩

end Ising2DLambda.NecSuf.ThermodynamicLimit
