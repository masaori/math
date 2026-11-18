/-
節「多変数多項式と基本対称式」の主張「末尾の変数に零を代入すると基本対称式は一つ少ない変数の基本対称式になる」
（`claim_last_variable_zero_elementary_symmetric`）の必要十分版。

具体版と同じ段（基本対称式の定義 → 末尾を含む部分集合 B_1 と含まない B_0 への分割 → 代入は和と積を保つ →
B_1 の項は零を因子に持つ → B_0 は残りの添字の j 元部分集合）で示し、各段が実際に使う性質だけを仮定に置く。

- 変数の添字は有限集合でなくてよい。使うのは、有限部分集合 `t` の埋め込み `g` による像と、その外の一点 `a` だけである
  （具体版の `ℕ_{<n+1} = ℕ_{<n} ∪ {n}`）。
- 多項式環の構造は使わない。`X : ι → A` は可換半環 `A` の任意の元の族でよく、代入 `φ` は半環の準同型であればよい。
  `φ` について使うのは、有限和と有限積を保つことだけである。
- `φ (X a) = 0`（末尾の変数への零代入）と、`t` の上の値 `y` が `φ (X (g k)) = y k` であることだけを使う。
  変数の代入先が変数であること（具体版の `lz_n(X_k) = X_k`）は要らない。
- `A` と `R` の分配則は使わない。可換半環を仮定するのは、有限積が並びによらないこと（可換性）と、
  零を因子に持つ有限積が和の単位元であること（積の零と和の零が同じ元であること）が要るからで、Lean でこの二つを
  一つの台の上で同時に与える最小の型クラスとして可換半環を置いた。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Data.Finset.Powerset

namespace Ising2DLambda.NecSuf.FisherZero

/-- 主張（具体版 `lastVariableZero_elementarySymmetric` と同じ段）。 -/
theorem elementarySymmetric_insert_zero_necSuf {ι κ A R : Type} [DecidableEq ι]
    [CommSemiring A] [CommSemiring R] (φ : A →+* R) (X : ι → A) (g : κ ↪ ι) (t : Finset κ)
    (a : ι) (ha : a ∉ t.map g) (y : κ → R) (hy : ∀ k : κ, φ (X (g k)) = y k)
    (hzero : φ (X a) = 0) (j : ℕ) :
    φ (∑ S ∈ Finset.powersetCard j (insert a (t.map g)), ∏ k ∈ S, X k) =
      ∑ T ∈ Finset.powersetCard j t, ∏ k ∈ T, y k := by
  classical
  -- B_1（a を含む）と B_0（a を含まない）に分ける。
  rw [← Finset.sum_filter_add_sum_filter_not _ (fun S => a ∈ S)]
  -- φ は和と積を保つ。
  rw [map_add, map_sum, map_sum]
  simp_rw [map_prod]
  -- B_1 の各項は因子 φ(X a) = 0 を持つので零。
  have hB1 : ∑ S ∈ (Finset.powersetCard j (insert a (t.map g))).filter (fun S => a ∈ S),
      ∏ k ∈ S, φ (X k) = 0 := by
    apply Finset.sum_eq_zero
    intro S hS
    exact Finset.prod_eq_zero (Finset.mem_filter.mp hS).2 hzero
  rw [hB1, zero_add]
  -- B_0 は `t.map g` の j 元部分集合であり、それは `t` の j 元部分集合の像である。
  have hB0 : (Finset.powersetCard j (insert a (t.map g))).filter (fun S => a ∉ S) =
      Finset.powersetCard j (t.map g) := by
    ext S
    simp only [Finset.mem_filter, Finset.mem_powersetCard]
    constructor
    · rintro ⟨⟨hsub, hcard⟩, haS⟩
      refine ⟨fun x hx => ?_, hcard⟩
      rcases Finset.mem_insert.mp (hsub hx) with rfl | h
      · exact absurd hx haS
      · exact h
    · rintro ⟨hsub, hcard⟩
      exact ⟨⟨hsub.trans (Finset.subset_insert _ _), hcard⟩, fun h => ha (hsub h)⟩
  rw [hB0, Finset.powersetCard_map, Finset.sum_map]
  refine Finset.sum_congr rfl (fun T _ => ?_)
  rw [RelEmbedding.coe_toEmbedding, Finset.mapEmbedding_apply, Finset.prod_map]
  exact Finset.prod_congr rfl (fun k _ => hy k)

end Ising2DLambda.NecSuf.FisherZero
