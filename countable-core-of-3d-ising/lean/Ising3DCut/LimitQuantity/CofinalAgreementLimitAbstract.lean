/-
「一致する添字が共終な正の実数列は箱サイズ極限を共有する」の Lean 必要十分版。

具体版が距離を使う理由は、二つの極限値を分離する近傍を作ることだけである。
そこで仮定を「Hausdorff な位相空間」まで落とす。手順は具体版と同じで、
二つの極限を分離してからそれぞれの収束で添字の下界を取り、共終性を
その最大値へ一度適用して一致する添字を一つ取り、分離した二つの近傍が
その添字の項を同時に含むことから矛盾を出す。

削れなかった仮定：`T2Space` は落とせない。落とすと二つの極限値を分離できず、
具体版の `ε := dist x x' / 2` に当たる段が作れない（実際、密着位相では
任意の二列が任意の点へ収束するので結論そのものが偽になる）。
`Monoid` などの代数構造は具体版の証明が使っていないので仮定しない。
-/
import Mathlib.Topology.Instances.Real.Lemmas

namespace Ising3DCut.LimitQuantity

open Filter Topology

variable {X : Type*}

/-- 必要十分版：一致する添字が共終な二列が Hausdorff 空間でそれぞれ収束するなら、
極限は等しい。 -/
theorem cofinalAgreement_limit_eq_abstract [TopologicalSpace X] [T2Space X] (a b : ℕ → X)
    (hCofinal : ∀ N : ℕ, ∃ n : ℕ, N ≤ n ∧ a n = b n) (x x' : X)
    (ha : Tendsto a atTop (𝓝 x)) (hb : Tendsto b atTop (𝓝 x')) : x = x' := by
  -- 具体版と同じ背理法の入口。`ε` による分離の代わりに Hausdorff 分離を使う。
  by_contra hne
  obtain ⟨U, V, hU, hV, hxU, hx'V, hUV⟩ := t2_separation hne
  -- 具体版の `N_a`, `N_b` に当たる添字の下界。
  obtain ⟨Na, hNa⟩ := eventually_atTop.1 (ha (hU.mem_nhds hxU))
  obtain ⟨Nb, hNb⟩ := eventually_atTop.1 (hb (hV.mem_nhds hx'V))
  -- 具体版と同じく `max` へ共終性を一度適用する。
  obtain ⟨n, hn, hab⟩ := hCofinal (max Na Nb)
  have h1 : a n ∈ U := hNa n (le_trans (le_max_left _ _) hn)
  -- 具体版の `a(L) = b(L)` の一度の代入。
  have h2 : a n ∈ V := by
    rw [hab]
    exact hNb n (le_trans (le_max_right _ _) hn)
  -- 具体版の三角不等式による矛盾に当たる段。
  exact Set.disjoint_left.1 hUV h1 h2

end Ising3DCut.LimitQuantity
