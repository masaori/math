/-
「Archimedes 性の倍率以上の自然数で割れば上界を超えない」の必要十分版。

具体版が使うのは次だけである。元の住処 `X` について零 `[Zero X]`（`0 ≤ ε` を述べる名前としてだけ要る）と ℚ の作用 `[SMul ℚ X]` と、
関係 `le` について
(1) 推移律（`claim_rational_log_order_group_linear_order` の推移律の部分）、
(2) 非負係数の作用が `le` を保つこと（`claim_rational_log_order_group_nonneg_scalar_monotone`）、
(3) 非負の元の作用は係数の大小で比べられること（`claim_rational_log_order_group_scalar_compare_nonneg`）、
そして作用の結合則 `(r*s) • x = r • (s • x)` と単位 `1 • x = x`（仮定として受ける）。
`X` の加法・逆元・群の公理・順序の線形性は使わない。係数は ℚ のまま（`0 ≤ 1/a`、`n/a ≤ 1` は
ℚ の順序の事実で、そこは一般化しない）。
-/
import Mathlib.Algebra.Order.Field.Basic
import Mathlib.Data.Rat.Cast.Order
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {X : Type*} [Zero X] [SMul ℚ X]

/-- `0 ≤ ε`（`le 0 ε`）、`μ ≤ n • ε`、`1 ≤ a`、`n ≤ a` から `le ((1/a) • μ) ε`。 -/
theorem inv_smul_le_of_le_smul_necSuf (le : X → X → Prop)
    (htrans : ∀ x y z : X, le x y → le y z → le x z)
    (hsmul : ∀ (c : ℚ), 0 ≤ c → ∀ x y : X, le x y → le (c • x) (c • y))
    (hcompare : ∀ (r s : ℚ), r ≤ s → ∀ ν : X, le 0 ν → le (r • ν) (s • ν))
    (hmul_smul : ∀ (r s : ℚ) (x : X), (r * s) • x = r • (s • x))
    (hone_smul : ∀ x : X, (1 : ℚ) • x = x)
    {μ ε : X} (hε : le 0 ε) {n a : ℕ} (ha : 1 ≤ a) (hna : n ≤ a)
    (hμ : le μ ((n : ℚ) • ε)) :
    le (((1 : ℚ) / a) • μ) ε := by
  -- 準備: 0 ≤ 1/a、n/a ≤ 1（ℚ の順序）
  have hapos : (0 : ℚ) < a := by exact_mod_cast ha
  have h0 : (0 : ℚ) ≤ 1 / a := le_of_lt (one_div_pos.mpr hapos)
  have h1 : (n : ℚ) / a ≤ 1 := by
    rw [div_le_one hapos]
    exact_mod_cast hna
  -- 第一段: (2)（c := 1/a）
  have s1 : le (((1 : ℚ) / a) • μ) (((1 : ℚ) / a) • ((n : ℚ) • ε)) :=
    hsmul _ h0 _ _ hμ
  -- 第二段・第三段: 結合則（右から左）、ℚ の四則
  have hcoef : (1 : ℚ) / a * n = n / a := by ring
  rw [← hmul_smul, hcoef] at s1
  -- 第四段: (3)（r := n/a、s := 1、ν := ε）
  have s2 : le (((n : ℚ) / a) • ε) ((1 : ℚ) • ε) := hcompare _ _ h1 _ hε
  -- 第五段: 1 • ε = ε
  rw [hone_smul] at s2
  -- (1) 推移律
  exact htrans _ _ _ s1 s2

end Ising2DLambda.NecSuf.ThermodynamicLimit
