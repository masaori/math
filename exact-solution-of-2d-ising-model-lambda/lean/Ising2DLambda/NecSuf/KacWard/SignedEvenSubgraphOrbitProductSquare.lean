import Mathlib

/-!
「符号付き偶部分グラフ多項式の軌道ごとの明示積」（`claim_signed_even_subgraph_orbit_product`）の
証明のうち、明示積の平方が全モードの積に等しいことの必要十分版。

具体版 `Ising2DLambda.KacWard.orbitExplicitProduct_sq` と同じ手順（冪の法則 → 一元軌道の平方 →
軌道の元数と不変性 → 軌道が分割であること）を、次の仮定だけで行う。最後の
`claim_dispersion_mode_product` の一行は具体版の対象についての等式なので、導出版で合成する。

* 値の型 `R` は可換モノイドであればよい。積を軌道ごとに並べ替えるので可換性は削れない。
  加法・零・逆元は使わない。
* 添字の型 `α` には等号の判定だけを使う（軌道の集合 `K.image orbit` を作るため）。
* `hself`（`m ∈ O(m)`）が無いと軌道の和集合が `K` を覆わない。
* `hsub`（`O(m) ⊆ K`）が無いと軌道の和集合が `K` からはみ出す。
* `heq`（`p ∈ O(m)` なら `O(p) = O(m)`）が無いと二つの軌道が交わって積が重複する。
* `hconst`（`f` は軌道の上で一定）と `hg`（`g(O(m)) = f(m)`）が無いと `∏_{p ∈ O} f p = g(O)^{|O|}` にならない。
* `hcard`（`|O(m)| ∈ {1, 2, 4}`）が無いと、元数がそれ以外の軌道が三つの積から落ちる。
* `hone`（`|O(m)| = 1` なら `F(O(m))^2 = f m`）が無いと一元軌道の因子の平方が `Δ` にならない。
-/

namespace Ising2DLambda.NecSuf.KacWard

open scoped Classical

/-- 必要十分版: 軌道の集合 `M := K.image orbit` について
`(∏_{|O|=1} F O · ∏_{|O|=2} g O · ∏_{|O|=4} g O ^ 2)^2 = ∏_{m ∈ K} f m`。 -/
theorem orbit_explicit_product_sq_necSuf {α R : Type*} [CommMonoid R]
    (K : Finset α) (orbit : α → Finset α) (f : α → R) (g F : Finset α → R)
    (hself : ∀ m ∈ K, m ∈ orbit m)
    (hsub : ∀ m ∈ K, orbit m ⊆ K)
    (heq : ∀ m ∈ K, ∀ p ∈ orbit m, orbit p = orbit m)
    (hconst : ∀ m ∈ K, ∀ p ∈ orbit m, f p = f m)
    (hg : ∀ m ∈ K, g (orbit m) = f m)
    (hcard : ∀ m ∈ K, (orbit m).card = 1 ∨ (orbit m).card = 2 ∨ (orbit m).card = 4)
    (hone : ∀ m ∈ K, (orbit m).card = 1 → F (orbit m) ^ 2 = f m) :
    ((∏ O ∈ (K.image orbit).filter (fun O => O.card = 1), F O) *
        (∏ O ∈ (K.image orbit).filter (fun O => O.card = 2), g O) *
        (∏ O ∈ (K.image orbit).filter (fun O => O.card = 4), g O ^ 2)) ^ 2 =
      ∏ m ∈ K, f m := by
  set M := K.image orbit
  have hM : ∀ O ∈ M, ∃ m ∈ K, orbit m = O := fun O hO => by simpa [M] using hO
  -- 冪の法則
  have hA : (∏ O ∈ M.filter (fun O => O.card = 1), F O) ^ 2 =
      ∏ O ∈ M.filter (fun O => O.card = 1), F O ^ 2 := (Finset.prod_pow _ _ _).symm
  have hB : (∏ O ∈ M.filter (fun O => O.card = 2), g O) ^ 2 =
      ∏ O ∈ M.filter (fun O => O.card = 2), g O ^ 2 := (Finset.prod_pow _ _ _).symm
  have hC : (∏ O ∈ M.filter (fun O => O.card = 4), g O ^ 2) ^ 2 =
      ∏ O ∈ M.filter (fun O => O.card = 4), g O ^ 4 := by
    rw [← Finset.prod_pow]
    exact Finset.prod_congr rfl (fun O _ => by rw [← pow_mul])
  -- 一元軌道の平方
  have hF : (∏ O ∈ M.filter (fun O => O.card = 1), F O ^ 2) =
      ∏ O ∈ M.filter (fun O => O.card = 1), g O := by
    apply Finset.prod_congr rfl
    intro O hO
    obtain ⟨hOM, h1⟩ := Finset.mem_filter.mp hO
    obtain ⟨m, hm, rfl⟩ := hM O hOM
    rw [hone m hm h1, hg m hm]
  -- 軌道の元数と不変性
  have hpow : ∀ O ∈ M, (∏ p ∈ O, f p) = g O ^ O.card := by
    intro O hO
    obtain ⟨m, hm, rfl⟩ := hM O hO
    rw [hg m hm, ← Finset.prod_const]
    exact Finset.prod_congr rfl (fun p hp => hconst m hm p hp)
  have hcardM : ∀ O ∈ M, O.card = 1 ∨ O.card = 2 ∨ O.card = 4 := by
    intro O hO
    obtain ⟨m, hm, rfl⟩ := hM O hO
    exact hcard m hm
  have hgroup : (∏ O ∈ M.filter (fun O => O.card = 1), g O) *
      (∏ O ∈ M.filter (fun O => O.card = 2), g O ^ 2) *
      (∏ O ∈ M.filter (fun O => O.card = 4), g O ^ 4) = ∏ O ∈ M, ∏ p ∈ O, f p := by
    rw [Finset.prod_congr rfl hpow, ← Finset.prod_filter_mul_prod_filter_not M (fun O => O.card = 1),
      ← Finset.prod_filter_mul_prod_filter_not (M.filter (fun O => ¬ O.card = 1))
        (fun O => O.card = 2),
      Finset.filter_filter, Finset.filter_filter]
    have e1 : (∏ O ∈ M.filter (fun O => O.card = 1), g O ^ O.card) =
        ∏ O ∈ M.filter (fun O => O.card = 1), g O :=
      Finset.prod_congr rfl (fun O hO => by rw [(Finset.mem_filter.mp hO).2, pow_one])
    have f2 : M.filter (fun O => ¬ O.card = 1 ∧ O.card = 2) = M.filter (fun O => O.card = 2) :=
      Finset.filter_congr (fun O _ => by omega)
    have f4 : M.filter (fun O => ¬ O.card = 1 ∧ ¬ O.card = 2) = M.filter (fun O => O.card = 4) :=
      Finset.filter_congr (fun O hO => by have := hcardM O hO; omega)
    have e2 : (∏ O ∈ M.filter (fun O => O.card = 2), g O ^ O.card) =
        ∏ O ∈ M.filter (fun O => O.card = 2), g O ^ 2 :=
      Finset.prod_congr rfl (fun O hO => by rw [(Finset.mem_filter.mp hO).2])
    have e4 : (∏ O ∈ M.filter (fun O => O.card = 4), g O ^ O.card) =
        ∏ O ∈ M.filter (fun O => O.card = 4), g O ^ 4 :=
      Finset.prod_congr rfl (fun O hO => by rw [(Finset.mem_filter.mp hO).2])
    rw [f2, f4, e1, e2, e4, mul_assoc]
  -- 軌道は `K` の分割
  have hunion : M.biUnion id = K := by
    ext p
    simp only [Finset.mem_biUnion, id]
    constructor
    · rintro ⟨O, hO, hp⟩
      obtain ⟨m, hm, rfl⟩ := hM O hO
      exact hsub m hm hp
    · intro hp
      exact ⟨orbit p, Finset.mem_image_of_mem _ hp, hself p hp⟩
  have hdisj : Set.PairwiseDisjoint (↑M : Set (Finset α)) id := by
    intro O hO O' hO' hne
    obtain ⟨m, hm, rfl⟩ := hM O hO
    obtain ⟨m', hm', rfl⟩ := hM O' hO'
    rw [Function.onFun, Finset.disjoint_left]
    intro q hq hq'
    exact hne ((heq m hm q hq).symm.trans (heq m' hm' q hq'))
  have hpart : (∏ O ∈ M, ∏ p ∈ O, f p) = ∏ m ∈ K, f m := by
    rw [← hunion, Finset.prod_biUnion hdisj]
    rfl
  calc ((∏ O ∈ M.filter (fun O => O.card = 1), F O) *
        (∏ O ∈ M.filter (fun O => O.card = 2), g O) *
        (∏ O ∈ M.filter (fun O => O.card = 4), g O ^ 2)) ^ 2
      = (∏ O ∈ M.filter (fun O => O.card = 1), F O ^ 2) *
          (∏ O ∈ M.filter (fun O => O.card = 2), g O ^ 2) *
          (∏ O ∈ M.filter (fun O => O.card = 4), g O ^ 4) := by
        rw [mul_pow, mul_pow, hA, hB, hC]
    _ = (∏ O ∈ M.filter (fun O => O.card = 1), g O) *
          (∏ O ∈ M.filter (fun O => O.card = 2), g O ^ 2) *
          (∏ O ∈ M.filter (fun O => O.card = 4), g O ^ 4) := by rw [hF]
    _ = ∏ O ∈ M, ∏ p ∈ O, f p := hgroup
    _ = ∏ m ∈ K, f m := hpart

end Ising2DLambda.NecSuf.KacWard
