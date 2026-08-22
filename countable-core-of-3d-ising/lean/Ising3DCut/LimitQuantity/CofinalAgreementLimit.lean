/-
「一致する添字が共終な正の実数列は箱サイズ極限を共有する」の Lean 具体版。

人手証明と 1 対 1 に対応させる。すなわち任意の `ε > 0` に対して両列の収束から
添字の下界を二つ取り、共終性をその最大値へ一度適用して一致する添字を一つ取り、
三角不等式で `dist x x' < 2 * ε` を得て、`ε := dist x x' / 2` の取り方から矛盾を出す。
尾部一致の場合と違い、他方の収束そのものは導けないので仮定に置く。
-/
import Mathlib.Topology.Instances.Real.Lemmas

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 一致する添字が共終な二つの実数列がそれぞれ収束するなら、極限は等しい。 -/
theorem cofinalAgreement_limit_eq (a b : ℕ → ℝ)
    (hCofinal : ∀ N : ℕ, ∃ n : ℕ, N ≤ n ∧ a n = b n) (x x' : ℝ)
    (ha : Tendsto a atTop (𝓝 x)) (hb : Tendsto b atTop (𝓝 x')) : x = x' := by
  -- 人手証明の背理法の入口：`x ≠ x'` を仮定して `ε := dist x x' / 2` を取る。
  by_contra hne
  have hpos : 0 < dist x x' := dist_pos.2 hne
  set ε : ℝ := dist x x' / 2 with hε_def
  have hε : 0 < ε := by
    rw [hε_def]
    linarith
  -- 人手証明の `N_a`, `N_b`（収束の定義の書き換え）。
  obtain ⟨Na, hNa⟩ := (Metric.tendsto_atTop.1 ha) ε hε
  obtain ⟨Nb, hNb⟩ := (Metric.tendsto_atTop.1 hb) ε hε
  -- 人手証明の `L_1 := max{N_a, N_b}` への共終性の一度の適用。
  obtain ⟨n, hn, hab⟩ := hCofinal (max Na Nb)
  have h1 : dist (a n) x < ε := hNa n (le_trans (le_max_left _ _) hn)
  have h2 : dist (b n) x' < ε := hNb n (le_trans (le_max_right _ _) hn)
  -- 人手証明の `a(L) = b(L)` の一度の代入。
  have h2' : dist (a n) x' < ε := by
    rw [hab]
    exact h2
  -- 人手証明の三角不等式と `|-t| = |t|` の書き換え。
  have htri : dist x x' ≤ dist x (a n) + dist (a n) x' := dist_triangle x (a n) x'
  have hcomm : dist x (a n) = dist (a n) x := dist_comm x (a n)
  -- `dist x x' < 2 * ε = dist x x'` の矛盾。
  rw [hε_def] at h1 h2'
  linarith

end Ising3DCut.LimitQuantity
