/-
人手証明「有限個の値しかとらない列が極限量を持つなら末尾定数である」
（ラベル `claim_finitely_many_values_gives_eventually_constant`）の Lean 具体版のうち、
第一段落にあたる一論法。

ある値 `v` をとる添字の集合が無限集合ならば、その添字に沿って部分列を取れるので
極限は `v` である。一方その部分列は元の列と同じ極限 `α` を持つ。
極限の一意性より `v = α` であり、対偶として `v ≠ α` なる値の添字集合は有限である。

部分列の抽出そのものは避け、無限集合から「いくらでも大きな添字で `f L = v` となる」ことを
取り出し（`Filter.frequently_atTop`）、極限の側から得られる「ある添字以後つねに `f L` は
`α` の近傍にある」と突き合わせる。使うのは ℝ の Hausdorff 性だけであり、
上限・下限・積分・微分・無限和は使わない。唯一の非可算への脱出は
極限量の定義に含まれる箱の大きさの極限である。
-/
import Ising3DCut.LimitQuantity.LimitQuantityDeterminedBySequence
import Ising3DCut.LimitQuantity.LimitQuantityAtOneEqualsTwo

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 実数列が `α` へ収束するとき、値 `v` をとる添字が無限個あれば `v = α` である。 -/
theorem eq_limit_of_infinite_level_set {f : ℕ → ℝ} {α v : ℝ}
    (hlimit : Tendsto f atTop (𝓝 α)) (hinf : {L : ℕ | f L = v}.Infinite) : v = α := by
  by_contra hne
  -- Hausdorff 性で `v` と `α` を交わらない開集合へ分ける。
  obtain ⟨U, V, hU, hV, hvU, haV, hdisj⟩ := t2_separation hne
  -- 収束から、ある添字以後つねに `f L ∈ V` である。
  have hev : ∀ᶠ L in atTop, f L ∈ V := hlimit (hV.mem_nhds haV)
  -- 無限集合から、いくらでも大きな添字で `f L = v` であることを取り出す。
  have hfr : ∃ᶠ L in atTop, f L = v := by
    rw [Filter.frequently_atTop]
    intro a
    obtain ⟨b, hb, hab⟩ := hinf.exists_gt a
    exact ⟨b, le_of_lt hab, hb⟩
  obtain ⟨L, hL1, hL2⟩ := (hfr.and_eventually hev).exists
  exact Set.disjoint_left.mp hdisj hvU (hL1 ▸ hL2)

/-- 有限箱の量の列に対する形。極限量を持つなら、無限回とる値は極限量に等しい。 -/
theorem ising_value_eq_limitQuantity_of_infinite_level_set (q : ℚ) {α v : ℝ}
    (hlimit : Tendsto (rootSeq (isingValueSeq q) siteCountSeq) atTop (𝓝 α))
    (hinf : {L : ℕ | rootSeq (isingValueSeq q) siteCountSeq L = v}.Infinite) : v = α :=
  eq_limit_of_infinite_level_set hlimit hinf

/-- とる値の集合が有限で極限へ収束するなら、ある閾値以後つねに極限に等しい。

    極限と異なる各値の添字集合は有限であり（`eq_limit_of_infinite_level_set` の対偶）、
    そのような値は有限個なので、合併も有限集合である。有限な自然数の集合には上界があるので、
    その上界に 1 を足したものを閾値に取ればよい。 -/
theorem eventually_constant_of_finite_range {f : ℕ → ℝ} {α : ℝ}
    (hlimit : Tendsto f atTop (𝓝 α)) (hfin : (Set.range f).Finite) :
    ∃ L0 : ℕ, ∀ L, L0 ≤ L → f L = α := by
  -- 極限と異なる値をとる添字の集合は、有限個の有限集合の合併に含まれる。
  have hE : {L : ℕ | f L ≠ α}.Finite := by
    have hsub : {L : ℕ | f L ≠ α} ⊆ ⋃ v ∈ (Set.range f \ {α}), {L : ℕ | f L = v} := by
      intro L hL
      exact Set.mem_biUnion ⟨⟨L, rfl⟩, hL⟩ rfl
    refine Set.Finite.subset (Set.Finite.biUnion hfin.diff (fun v hv => ?_)) hsub
    by_contra hinf
    exact hv.2 (by simpa using eq_limit_of_infinite_level_set hlimit hinf)
  -- 有限な自然数の集合の上界に 1 を足したものを閾値に取る。
  obtain ⟨M, hM⟩ := hE.bddAbove
  refine ⟨M + 1, fun L hL => ?_⟩
  by_contra hne
  have : L ≤ M := hM hne
  omega

/-- 有限箱の量の列に対する形。とる値が有限個で極限量を持つなら末尾定数である。 -/
theorem ising_eventually_constant_of_finite_range (q : ℚ) {α : ℝ}
    (hlimit : Tendsto (rootSeq (isingValueSeq q) siteCountSeq) atTop (𝓝 α))
    (hfin : (Set.range (rootSeq (isingValueSeq q) siteCountSeq)).Finite) :
    ∃ L0 : ℕ, ∀ L, L0 ≤ L → rootSeq (isingValueSeq q) siteCountSeq L = α :=
  eventually_constant_of_finite_range hlimit hfin

end Ising3DCut.LimitQuantity
