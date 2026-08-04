/-
# Newton 多面体の加法性（Ostrowski の定理）— cycle 39 step 1

対応する人手証明:

* 本文ブロック `paper_prop_G_prime`（命題 G′）の証明の「有限性」の段
  （「Laurent 多項式の Newton 多面体の加法性（Ostrowski の定理）より
  $\mathrm{Newt}(\bar{\tilde E})=[0,v]+\mathrm{Newt}(G)$ である」）
* 本文ブロック `paper_prop_K`（命題 K）の (K7) の証明
  （「分解に Newton 多面体の加法性（Ostrowski の定理）を使うと …」）

本文はこの定理を証明せず外部定理として引いている。外部定理の振り分けの基準
（`docs/external-theorem-criterion.md`）では、本文の証明が根拠として引いていて、
可算側の内容を担い、mathlib に無いので、自分で証明する側にある。

## この file が書くもの

$f,g$ を Laurent 多項式とするとき

$$\mathrm{Newt}(fg)=\mathrm{Newt}(f)+\mathrm{Newt}(g)$$

である（右辺は Minkowski 和）。Newton 多面体とは、台（係数が $0$ でない指数の集合）の凸包である。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

**この file は $\mathbb{R}$ へ 1 度も出ない。** 指数は $\mathbb{Z}\times\mathbb{Z}$ に住み、
凸包は $\mathbb{Q}\times\mathbb{Q}$ の中で $\mathbb{Q}$ 係数で取る。どちらも可算である。
凸包に要るのは順序体であることだけで、完備性も位相も使わないので、$\mathbb{R}$ を経由する必要はない。
係数環 $R$ は整域とだけ仮定する（本文が当てるのは $\mathbb{F}_\ell$）。

## 証明の骨格（4 段）

台を $A=\mathrm{supp}(f)$、$B=\mathrm{supp}(g)$、$S=A+B$、$T=\mathrm{supp}(fg)$ と書く。

1. **$T\subseteq S$**（`support_coeff_mul_subset`）。したがって $\mathrm{Newt}(fg)\subseteq\mathrm{conv}(S)$。
   逆向きは $\mathrm{conv}(S)\subseteq\mathrm{conv}(T)$、すなわち $\mathrm{conv}(S)=\mathrm{conv}(T)$ を言えばよい。
2. **分解が一意な点は $T$ に入る**（`mem_support_of_unique_add`）。
   $p=a+b$ と書く仕方が 1 通りしかなければ、$fg$ の $p$ の係数はその 1 項 $f_a g_b$ だけで、
   整域なので $0$ でない。**ここが整域を使う唯一の箇所である。**
3. **分解が一意でない点は、$S$ の相異なる 2 点の中点である**（`exists_midpoint_of_not_unique`）。
   $p=a+b=a'+b'$ かつ $(a,b)\neq(a',b')$ なら、$a\neq a'$ かつ $b\neq b'$ であり、
   $q=a+b'$ と $r=a'+b$ は $S$ の相異なる 2 点で $q+r=p+p$ を満たす。
   **これが分離定理の代わりである。** 頂点を取り出すのに超平面を作らず、
   「頂点でない点は中点として書ける」という組合せの事実だけで済ませる。
4. **中点として書ける点は凸包の生成に要らない**（`convexHull_eq_of_midpoint`）。
   凸包を与える部分集合のうち要素数が最小のものを取り、その各点が中点では書けないことを示す。
   段 2・3 と合わせて、最小のものは $T$ に含まれる。

段 4 は極小性を使うので、$\mathbb{R}$ 上の Krein–Milman（mathlib の `KreinMilman` は位相を要求する）を
経由しない。有限集合であることだけを使う。
-/
import Mathlib

namespace IntegrableLattice
namespace NewtonPolytope

open Finset Pointwise

/-! ## 1. 凸包の側（順序体の上の有限集合。位相も完備性も使わない）

ここは多項式と関係のない、有限集合の凸包についての事実だけを書く。
係数体 $\mathbb{k}$ は順序体とだけ仮定する（本文が当てるのは $\mathbb{Q}$）。 -/

section Convex

variable {𝕜 V : Type*} [Field 𝕜] [LinearOrder 𝕜] [IsStrictOrderedRing 𝕜]
variable [AddCommGroup V] [Module 𝕜 V] [DecidableEq V]

/-- **段 4 の芯。** `p` が `M` の点で、凸包の中の相異なる 2 点 `q, r` の中点（`q + r = p + p`）
であるならば、`p` は `M` から `p` を除いた集合の凸包に入る。

証明は `convexHull_insert`（凸包に 1 点を足すと、その点と元の凸包の点を結ぶ線分の合併になる）を
`q` と `r` に当て、`p` の係数を消去するだけである。消去できる（分母が $0$ でない）のは
`q ≠ r` があるからで、そこだけがこの仮定を使う。 -/
theorem mem_convexHull_erase_of_midpoint {M : Finset V} {p q r : V} (hp : p ∈ M)
    (hq : q ∈ convexHull 𝕜 (M : Set V)) (hr : r ∈ convexHull 𝕜 (M : Set V))
    (hqr : q ≠ r) (hsum : q + r = p + p) :
    p ∈ convexHull 𝕜 ((M.erase p : Finset V) : Set V) := by
  classical
  set s : Set V := ((M.erase p : Finset V) : Set V) with hs
  -- まず `s` が空でないこと。空なら `M = {p}` となり `q = r = p` で `q ≠ r` に反する。
  rcases Set.eq_empty_or_nonempty s with hsempty | hsne
  · exfalso
    have hM : (M : Set V) = {p} := by
      apply Set.Subset.antisymm
      · intro x hx
        by_contra hxp
        have : x ∈ s := by
          simp only [hs, Finset.coe_erase, Set.mem_sdiff, Set.mem_singleton_iff]
          exact ⟨hx, hxp⟩
        rw [hsempty] at this
        exact this
      · simpa using hp
    rw [hM, convexHull_singleton] at hq hr
    exact hqr (hq.trans hr.symm)
  -- `↑M = insert p s` に `convexHull_insert` を当てる。
  have hins : (M : Set V) = insert p s := by
    simp only [hs, Finset.coe_erase]
    rw [Set.insert_sdiff_singleton, Set.insert_eq_of_mem (by simpa using hp)]
  rw [hins, convexHull_insert hsne] at hq hr
  rw [mem_convexJoin] at hq hr
  obtain ⟨p₁, hp₁, zq, hzq, a, b, ha, hb, hab, hqeq⟩ := hq
  obtain ⟨p₂, hp₂, zr, hzr, c, d, hc, hd, hcd, hreq⟩ := hr
  rw [Set.mem_singleton_iff] at hp₁ hp₂
  rw [hp₁] at hqeq
  rw [hp₂] at hreq
  -- `b + d = 0` なら `q = r = p` で矛盾。
  have hbd : b + d ≠ 0 := by
    intro h
    have hb0 : b = 0 := le_antisymm (by linarith) hb
    have hd0 : d = 0 := le_antisymm (by linarith) hd
    have ha1 : a = 1 := by rw [hb0] at hab; linarith
    have hc1 : c = 1 := by rw [hd0] at hcd; linarith
    apply hqr
    rw [← hqeq, ← hreq, ha1, hb0, hc1, hd0]
    simp
  have hbdpos : 0 < b + d := lt_of_le_of_ne (by linarith) (Ne.symm hbd)
  -- 係数を消去して `p` を `zq, zr` の凸結合として書く。
  have hkey : b • zq + d • zr = (b + d) • p := by
    have h2 : (a • p + b • zq) + (c • p + d • zr) = p + p := by rw [hqeq, hreq]; exact hsum
    have : b • zq + d • zr = (p + p) - (a • p + c • p) := by
      rw [← h2]; abel
    rw [this, add_smul]
    have hac : a + c = (1 - b) + (1 - d) := by rw [show a = 1 - b by linarith, show c = 1 - d by linarith]
    have : a • p + c • p = ((1 - b) + (1 - d)) • p := by rw [← add_smul, hac]
    rw [this]
    rw [show ((1 : 𝕜) - b) + (1 - d) = 2 - (b + d) by ring, sub_smul, add_smul]
    have : (2 : 𝕜) • p = p + p := by
      rw [show (2 : 𝕜) = 1 + 1 by norm_num, add_smul, one_smul]
    rw [this]
    abel
  have hpe : p = (b / (b + d)) • zq + (d / (b + d)) • zr := by
    have : ((b + d)⁻¹ : 𝕜) • ((b + d) • p) = p := by
      rw [smul_smul, inv_mul_cancel₀ hbd, one_smul]
    rw [← this, ← hkey, smul_add, smul_smul, smul_smul]
    rw [div_eq_inv_mul, div_eq_inv_mul]
  rw [hpe]
  exact (convex_convexHull 𝕜 s) hzq hzr
    (by positivity) (by positivity)
    (by field_simp)

/-- **段 4。** `W ⊆ S` であって、`S` のうち `W` に入らない点がすべて
`S` の相異なる 2 点の中点として書けるならば、`S` の凸包は `W` の凸包に等しい。

凸包を与える部分集合のうち**要素数が最小のもの** `M` を取る。`M` の点が中点として書けると、
`mem_convexHull_erase_of_midpoint` により `M` から取り除けてしまい最小性に反する。
したがって `M ⊆ W` であり、`conv S = conv M ⊆ conv W ⊆ conv S` となる。

**位相も分離定理も使わない。** 使うのは `S` が有限であることだけである。 -/
theorem convexHull_eq_of_midpoint {S W : Finset V} (hWS : W ⊆ S)
    (hmid : ∀ p ∈ S, p ∉ W → ∃ q ∈ S, ∃ r ∈ S, q ≠ r ∧ q + r = p + p) :
    convexHull 𝕜 (S : Set V) = convexHull 𝕜 (W : Set V) := by
  classical
  -- 凸包を与える部分集合のうち要素数が最小のものを取る。
  obtain ⟨M, hMP, hmin⟩ :=
    Finset.exists_min_image
      (({M ∈ S.powerset | convexHull 𝕜 (M : Set V) = convexHull 𝕜 (S : Set V)}) :
        Finset (Finset V))
      Finset.card ⟨S, by simp⟩
  simp only [Finset.mem_filter, Finset.mem_powerset] at hMP hmin
  obtain ⟨hMS, hMhull⟩ := hMP
  -- `M ⊆ W` を示す。
  have hMW : M ⊆ W := by
    intro p hpM
    by_contra hpW
    -- `p` は中点として書ける。
    obtain ⟨q, hqS, r, hrS, hqr, hsum⟩ := hmid p (hMS hpM) hpW
    have hq : q ∈ convexHull 𝕜 (M : Set V) := by
      rw [hMhull]; exact subset_convexHull 𝕜 _ (by simpa using hqS)
    have hr : r ∈ convexHull 𝕜 (M : Set V) := by
      rw [hMhull]; exact subset_convexHull 𝕜 _ (by simpa using hrS)
    have hperase : p ∈ convexHull 𝕜 ((M.erase p : Finset V) : Set V) :=
      mem_convexHull_erase_of_midpoint hpM hq hr hqr hsum
    -- すると `M.erase p` も同じ凸包を与えるので、`M` の最小性に反する。
    have hEhull : convexHull 𝕜 ((M.erase p : Finset V) : Set V) = convexHull 𝕜 (S : Set V) := by
      apply Set.Subset.antisymm
      · rw [← hMhull]
        exact convexHull_mono (by simp)
      · rw [← hMhull]
        apply convexHull_min _ (convex_convexHull 𝕜 _)
        intro x hx
        rcases eq_or_ne x p with rfl | hxp
        · exact hperase
        · refine subset_convexHull 𝕜 _ ?_
          simp only [Finset.coe_erase, Set.mem_sdiff, Set.mem_singleton_iff]
          exact ⟨by simpa using hx, hxp⟩
    have hcard := hmin _ ⟨(Finset.erase_subset p M).trans hMS, hEhull⟩
    have : (M.erase p).card < M.card := Finset.card_erase_lt_of_mem hpM
    omega
  -- 仕上げ。
  apply Set.Subset.antisymm
  · rw [← hMhull]; exact convexHull_mono (by simpa using hMW)
  · exact convexHull_mono (by simpa using hWS)

end Convex

/-! ## 2. 台の側（一意な分解と、一意でない点の中点表示）

ここは凸性を使わない。整域であることを使うのは `mem_support_of_unique_add` の 1 箇所だけである。 -/

section Support

variable {R : Type*} [CommRing R] [IsDomain R]

/-- **段 2。** `p = a + b` と書く仕方が台の中で 1 通りしかないならば、`p` は積の台に入る。

積の係数は台の上の二重和で、一意性の仮定によりその中の 1 項 `f a * g b` だけが残る。
それが `0` でないのは整域だからである。**この file で整域を使うのはここだけである。** -/
theorem mem_support_of_unique_add {f g : AddMonoidAlgebra R (ℤ × ℤ)} {a b : ℤ × ℤ}
    (ha : a ∈ f.coeff.support) (hb : b ∈ g.coeff.support)
    (huniq : ∀ a' ∈ f.coeff.support, ∀ b' ∈ g.coeff.support, a' + b' = a + b → a' = a) :
    a + b ∈ (f * g).coeff.support := by
  classical
  have hcoeff : (f * g).coeff (a + b) = f.coeff a * g.coeff b := by
    rw [AddMonoidAlgebra.coeff_mul]
    rw [Finsupp.sum]
    -- 外側の和は `a` の項だけが残る。
    rw [Finset.sum_eq_single a]
    · -- 内側の和は `b` の項だけが残る。
      rw [Finsupp.sum, Finset.sum_eq_single b]
      · simp
      · intro b' hb' hne
        have : a + b' ≠ a + b := by
          intro h; exact hne (add_left_cancel h)
        simp [this]
      · intro hbn; exact absurd hb hbn
    · intro a' ha' hne
      rw [Finsupp.sum]
      apply Finset.sum_eq_zero
      intro b' hb'
      have : a' + b' ≠ a + b := by
        intro h; exact hne (huniq a' ha' b' hb' h)
      simp [this]
    · intro han; exact absurd ha han
  rw [Finsupp.mem_support_iff, hcoeff]
  exact mul_ne_zero (Finsupp.mem_support_iff.mp ha) (Finsupp.mem_support_iff.mp hb)

/-- **段 3。** `p = a + b = a' + b'` で `a ≠ a'` ならば、`q = a + b'` と `r = a' + b` は
台の和の相異なる 2 点で `q + r = p + p` を満たす。

`q ≠ r` は $\mathbb{Z}\times\mathbb{Z}$ に捻れが無いことから出る（$2(b'-b)=0\Rightarrow b'=b$）。
**この段が、分離定理を使わずに頂点を取り出すための代わりである。** -/
theorem midpoint_of_two_decompositions {a b a' b' : ℤ × ℤ}
    (hne : a ≠ a') (heq : a' + b' = a + b) :
    (a + b') ≠ (a' + b) ∧ (a + b') + (a' + b) = (a + b) + (a + b) := by
  constructor
  · intro h
    -- `a + b' = a' + b` と `a' + b' = a + b` を足すと `2(a + b') = 2(a' + b')` ではなく
    -- 引くと `a - a' = a' - a`、すなわち `2(a - a') = 0`。
    have h1 : a + b' + (a + b) = a' + b + (a' + b') := by rw [h, heq]
    have h2 : a + a = a' + a' := by
      have : a + b' + (a + b) = (a + a) + (b + b') := by abel
      have h3 : a' + b + (a' + b') = (a' + a') + (b + b') := by abel
      rw [this, h3] at h1
      exact add_right_cancel h1
    apply hne
    have : (2 : ℤ) • a = (2 : ℤ) • a' := by
      simp only [two_smul]; exact h2
    exact smul_right_injective (ℤ × ℤ) (by norm_num) this
  · rw [show (a + b') + (a' + b) = (a + b) + (a' + b') from by abel, heq]

end Support

/-! ## 3. Newton 多面体とその加法性

指数 $\mathbb{Z}\times\mathbb{Z}$ を $\mathbb{Q}\times\mathbb{Q}$ へ埋め込んで凸包を取る。
埋め込みは単射な加法準同型なので、台の和は像の和へそのまま移る。 -/

section Additivity

variable {R : Type*} [CommRing R] [IsDomain R]

/-- 指数 $\mathbb{Z}\times\mathbb{Z}$ を $\mathbb{Q}\times\mathbb{Q}$ へ入れる加法準同型。 -/
def emb : (ℤ × ℤ) →+ (ℚ × ℚ) := (Int.castAddHom ℚ).prodMap (Int.castAddHom ℚ)

theorem emb_injective : Function.Injective (emb : (ℤ × ℤ) → (ℚ × ℚ)) := by
  intro x y h
  have h1 : (x.1 : ℚ) = (y.1 : ℚ) := congrArg Prod.fst h
  have h2 : (x.2 : ℚ) = (y.2 : ℚ) := congrArg Prod.snd h
  exact Prod.ext (by exact_mod_cast h1) (by exact_mod_cast h2)

/-- **Newton 多面体。** 台の像の凸包（$\mathbb{Q}$ 係数。$\mathbb{R}$ は使わない）。 -/
noncomputable def newt (f : AddMonoidAlgebra R (ℤ × ℤ)) : Set (ℚ × ℚ) :=
  convexHull ℚ ((f.coeff.support.image emb : Finset (ℚ × ℚ)) : Set (ℚ × ℚ))

/-- **Newton 多面体の加法性（Ostrowski の定理）。**
$\mathrm{Newt}(fg)=\mathrm{Newt}(f)+\mathrm{Newt}(g)$（右辺は Minkowski 和）。

`f` や `g` が `0` の場合も込みで成り立つ（両辺とも空集合になる）。 -/
theorem newt_mul (f g : AddMonoidAlgebra R (ℤ × ℤ)) :
    newt (f * g) = newt f + newt g := by
  classical
  set A : Finset (ℚ × ℚ) := f.coeff.support.image emb with hA
  set B : Finset (ℚ × ℚ) := g.coeff.support.image emb with hB
  set T : Finset (ℚ × ℚ) := (f * g).coeff.support.image emb with hT
  -- 右辺を `conv (A + B)` に直す（`convexHull_add`）。
  have hright : newt f + newt g = convexHull ℚ ((A + B : Finset (ℚ × ℚ)) : Set (ℚ × ℚ)) := by
    rw [newt, newt, ← convexHull_add, ← hA, ← hB, Finset.coe_add]
  rw [hright, newt, ← hT]
  -- `T ⊆ A + B` と、`A + B` の点がすべて `conv T` に入ることを言う。
  have hTS : T ⊆ A + B := by
    intro x hx
    simp only [hT, Finset.mem_image] at hx
    obtain ⟨p, hp, rfl⟩ := hx
    have hp' : p ∈ f.coeff.support + g.coeff.support :=
      AddMonoidAlgebra.support_coeff_mul_subset f g hp
    rw [Finset.mem_add] at hp'
    obtain ⟨a, ha, b, hb, rfl⟩ := hp'
    rw [Finset.mem_add]
    exact ⟨emb a, Finset.mem_image_of_mem _ ha, emb b, Finset.mem_image_of_mem _ hb,
      (map_add emb a b).symm⟩
  refine (convexHull_eq_of_midpoint hTS ?_).symm
  -- `A + B` の点で `T` に入らないものは、`A + B` の相異なる 2 点の中点である。
  intro x hx hxT
  rw [Finset.mem_add] at hx
  obtain ⟨u, hu, v, hv, rfl⟩ := hx
  simp only [hA, Finset.mem_image] at hu
  simp only [hB, Finset.mem_image] at hv
  obtain ⟨a, ha, rfl⟩ := hu
  obtain ⟨b, hb, rfl⟩ := hv
  -- 分解が一意なら段 2 で `T` に入ってしまうので、一意でない。
  have hnotuniq : ¬ (∀ a' ∈ f.coeff.support, ∀ b' ∈ g.coeff.support, a' + b' = a + b → a' = a) := by
    intro huniq
    apply hxT
    have := mem_support_of_unique_add ha hb huniq
    simp only [hT, Finset.mem_image]
    exact ⟨a + b, this, (map_add emb a b)⟩
  push Not at hnotuniq
  obtain ⟨a', ha', b', hb', hsum, hane⟩ := hnotuniq
  -- 段 3 の 2 点を像へ移す。
  obtain ⟨hqr, hmid⟩ := midpoint_of_two_decompositions (Ne.symm hane) hsum
  refine ⟨emb (a + b'), ?_, emb (a' + b), ?_, ?_, ?_⟩
  · rw [Finset.mem_add]
    exact ⟨emb a, Finset.mem_image_of_mem _ ha, emb b', Finset.mem_image_of_mem _ hb',
      (map_add emb a b').symm⟩
  · rw [Finset.mem_add]
    exact ⟨emb a', Finset.mem_image_of_mem _ ha', emb b, Finset.mem_image_of_mem _ hb,
      (map_add emb a' b).symm⟩
  · intro h; exact hqr (emb_injective h)
  · have h := congrArg emb hmid
    simpa [map_add] using h

end Additivity

end NewtonPolytope
end IntegrableLattice
