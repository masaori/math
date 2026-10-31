/-
# 1 次元開鎖のスピン和（必要十分版）

具体版: `Ising2D/Part018/ClaimOpenChainSpinSums.lean`（人手 `open_chain_partition_sum`・
`open_chain_endpoint_product_sum` と 1 対 1）。具体版をこのファイルの系として導出するのは
`Ising2D/Part018/ClaimOpenChainSpinSumsFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| 二つのスピン和の Step 1（全単射 `Φ`）と Step 2 の「積の展開」「二元集合上の和」「同じ因子の積」 | `open_chain_weighted_sum` |
| `{-1,1}` 上の有限和 `sum_spinVal` | `sum_spinVal_addCommMonoid` |
| `open_chain_endpoint_product_sum` の Step 2 `∏_m s(m)s(m+1) = s(1)s(M_col)`（`prod_openChainBondSpin`） | `prod_mul_nextSite_eq_first_mul_last` |

## 何が効いているか / 効いていないか

- **スピン和の本体（`open_chain_weighted_sum`）。** 効いているのは、Step 1 の全単射 `Φ`（`M_col ≠ 0`）と、
  重みの値の側の可換半環の構造（有限積の有限和への展開、`1 + 1 = 2`）だけである。
  重みの値について、実数であること、指数関数、`cosh`・`sinh` は効いていない。
  スピンの側 `𝔐 = Map({1,…,M_col},{-1,1})` は、具体版の Step 1 の全単射 `Φ` をそのまま使うために人手の定義のまま固定した。
  そこで効くのは、`{-1,1}` が乗法で閉じることと `s·s = 1`（`Φ` の単射性）、`{-1,1}` の元の個数 `2` だけで、
  `ℝ` の加法と順序は効いていない。二つのスピン和は、重みを
  `g(t) = exp(Kt)` と `g(t) = t·exp(Kt)` に取った特殊化にすぎない。
  `M_col ≥ 2` も効いていない（`M_col = 1` でも `2 = 2·(g(1)+g(-1))^0` として成り立つ）。
- **端点因子の書き替え（`prod_mul_nextSite_eq_first_mul_last`）。** 効いているのは、値が可換モノイドに在ることと、
  中間のサイト `m = 2,…,M_col-1` での `x(m)x(m) = 1`（両端のサイトでは効いていない）、および両端の因子を別々に括り出すための `1 ≠ M_col`（`M_col ≥ 2`）だけである。
  `M_col = 1` では主張自体は成り立つ（空積 `1 = x(1)x(1)`）が、この証明手順は両端が相異なることを使うので、
  仮定に残す。実数であること、値が `±1` であることは効いていない。
- **正値性（`open_chain_spin_sums_positive`）。** `2(2cosh K)^{M_col-1} > 0` は `K` の符号によらず、
  `K > 0` が効くのは `2(2sinh K)^{M_col-1} > 0` の側だけである（具体版のコメントにも書いた）。
-/
import Ising2D.Part018.ClaimOpenChainSpinSums

namespace Ising2D.NecSuf

open Finset Ising2D

variable {M : ℕ}

/-- `{-1,1}` 上の有限和（値は任意の加法可換モノイド）: `∑_{t∈{-1,1}} f(t) = f(1) + f(-1)`。 -/
theorem sum_spinVal_addCommMonoid {R : Type*} [AddCommMonoid R] (f : SpinVal → R) :
    ∑ x : SpinVal, f x = f ⟨1, Or.inl rfl⟩ + f ⟨-1, Or.inr rfl⟩ := by
  rw [← spinIdxEquiv.symm.sum_comp, Fin.sum_univ_two]
  congr 2

/-- **必要十分版の本体**: 値が可換半環 `R` の重み `g : {-1,1} → R` について
`∑_{s∈𝔐} ∏_{m=1}^{M_col-1} g(s(m)s(m+1)) = 2(g(1)+g(-1))^{M_col-1}`。

具体版の二つのスピン和の Step 1（`Φ` の全単射）と Step 2 の「有限個の因子の積の展開」
「二元集合上の有限和」「同じ因子の積」を、この順に同じ段で踏む。 -/
theorem open_chain_weighted_sum {R : Type*} [CommSemiring R] (hM : M ≠ 0) (g : SpinVal → R) :
    ∑ s : SpinConf M, ∏ b : OpenChainBond M, g (openChainBondSpin s b)
      = 2 * (g ⟨1, Or.inl rfl⟩ + g ⟨-1, Or.inr rfl⟩) ^ (M - 1) :=
  calc ∑ s : SpinConf M, ∏ b : OpenChainBond M, g (openChainBondSpin s b)
      = ∑ s : SpinConf M, ∏ b : OpenChainBond M, g ((openChainChange hM s).2 b) := rfl
    -- Step 1 の全単射
    _ = ∑ y : SpinVal × (OpenChainBond M → SpinVal), ∏ b : OpenChainBond M, g (y.2 b) :=
        (Equiv.ofBijective _ (openChainChange_bijective hM)).sum_comp
          (fun y => ∏ b : OpenChainBond M, g (y.2 b))
    _ = ∑ a : SpinVal, ∑ t : OpenChainBond M → SpinVal, ∏ b : OpenChainBond M, g (t b) :=
        Fintype.sum_prod_type _
    -- 有限個の因子の積の展開（各 `t_m` は独立に走る）
    _ = (∑ _a : SpinVal, (1 : R)) * ∏ _b : OpenChainBond M, ∑ x : SpinVal, g x := by
        rw [Fintype.prod_sum, Finset.sum_mul]
        simp only [one_mul]
    -- 二元集合 `{-1,1}` 上の二つの有限和を計算
    _ = 2 * ∏ _b : OpenChainBond M, (g ⟨1, Or.inl rfl⟩ + g ⟨-1, Or.inr rfl⟩) := by
        rw [sum_spinVal_addCommMonoid, sum_spinVal_addCommMonoid, one_add_one_eq_two]
    -- 同じ因子の `M_col - 1` 個の積
    _ = 2 * (g ⟨1, Or.inl rfl⟩ + g ⟨-1, Or.inr rfl⟩) ^ (M - 1) := by
        rw [Finset.prod_const, Finset.card_univ, card_openChainBond hM]

/-- **必要十分版**: 値が可換モノイド `G` の `x : {1,…,M_col} → G` が中間のサイト `m = 2,…,M_col-1` で
`x(m)x(m) = 1` を満たせば
`∏_{m=1}^{M_col-1} x(m)x(m+1) = x(1)x(M_col)`。

具体版 `prod_openChainBondSpin` と同じ段（積を `∏_{m≠M_col} x(m)` と `∏_{m≠1} x(m)` に分け、
両側から `x(1)`・`x(M_col)` を括り出し、中間の `x(m)x(m) = 1` を消す）を踏む。 -/
theorem prod_mul_nextSite_eq_first_mul_last {G : Type*} [CommMonoid G] (hM : 2 ≤ M)
    (x : Fin M → G)
    (hx : ∀ m, m ≠ firstSite M (by omega) → m ≠ lastSite M (by omega) → x m * x m = 1) :
    ∏ m ∈ Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M), x m * x (nextSite m)
      = x (firstSite M (by omega)) * x (lastSite M (by omega)) := by
  have hM0 : M ≠ 0 := by omega
  have hfirst : ((firstSite M hM0 : Fin M) : ℕ) = 0 := rfl
  have hlast : ((lastSite M hM0 : Fin M) : ℕ) = M - 1 := rfl
  obtain ⟨F, hF⟩ : ∃ F : Finset (Fin M),
      F = Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M) := ⟨_, rfl⟩
  obtain ⟨G', hG'⟩ : ∃ G' : Finset (Fin M),
      G' = Finset.univ.filter (fun m : Fin M => m ≠ firstSite M hM0) := ⟨_, rfl⟩
  obtain ⟨I, hI⟩ : ∃ I : Finset (Fin M), I = Finset.univ.filter
      (fun m : Fin M => m ≠ firstSite M hM0 ∧ m ≠ lastSite M hM0) := ⟨_, rfl⟩
  have memF : ∀ m : Fin M, m ∈ F ↔ (m : ℕ) + 1 ≠ M := fun m => by simp [hF]
  have memG : ∀ m : Fin M, m ∈ G' ↔ (m : ℕ) ≠ 0 := fun m => by
    simp only [hG', Finset.mem_filter, Finset.mem_univ, true_and, Ne, Fin.ext_iff, hfirst]
  have memI : ∀ m : Fin M, m ∈ I ↔ (m : ℕ) ≠ 0 ∧ (m : ℕ) ≠ M - 1 := fun m => by
    simp only [hI, Finset.mem_filter, Finset.mem_univ, true_and, Ne, Fin.ext_iff, hfirst, hlast]
  have hfirstF : firstSite M hM0 ∈ F := by rw [memF, hfirst]; omega
  have hlastG : lastSite M hM0 ∈ G' := by rw [memG, hlast]; omega
  have hFI : F.erase (firstSite M hM0) = I := by
    ext m
    rw [Finset.mem_erase, memF, memI, Ne, Fin.ext_iff, hfirst]
    have := m.isLt
    omega
  have hGI : G'.erase (lastSite M hM0) = I := by
    ext m
    rw [Finset.mem_erase, memG, memI, Ne, Fin.ext_iff, hlast]
    tauto
  have hshift : ∏ m ∈ F, x (nextSite m) = ∏ m ∈ G', x m := by
    apply Finset.prod_nbij' nextSite prevSite
    · intro m hm
      rw [memF] at hm
      rw [memG, nextSite_val_of_bond hm]
      omega
    · intro m hm
      rw [memG] at hm
      rw [memF, prevSite_val_of_ne_zero hm]
      have := m.isLt
      omega
    · intro m hm
      rw [memF] at hm
      apply Fin.ext
      rw [prevSite_val_of_ne_zero (by rw [nextSite_val_of_bond hm]; omega), nextSite_val_of_bond hm]
      omega
    · intro m hm
      rw [memG] at hm
      have hb : ((prevSite m : Fin M) : ℕ) + 1 ≠ M := by
        rw [prevSite_val_of_ne_zero hm]
        have := m.isLt
        omega
      apply Fin.ext
      rw [nextSite_val_of_bond hb, prevSite_val_of_ne_zero hm]
      omega
    · intro m _
      rfl
  rw [← hF]
  calc ∏ m ∈ F, x m * x (nextSite m)
      = (∏ m ∈ F, x m) * ∏ m ∈ F, x (nextSite m) := Finset.prod_mul_distrib
    _ = (∏ m ∈ F, x m) * ∏ m ∈ G', x m := by rw [hshift]
    _ = (x (firstSite M hM0) * ∏ m ∈ I, x m) * (x (lastSite M hM0) * ∏ m ∈ I, x m) := by
        rw [Finset.mul_prod_erase F x hfirstF |>.symm, hFI,
          Finset.mul_prod_erase G' x hlastG |>.symm, hGI]
    _ = x (firstSite M hM0) * (∏ m ∈ I, x m * x m) * x (lastSite M hM0) := by
        rw [Finset.prod_mul_distrib, mul_mul_mul_comm, mul_right_comm]
    _ = x (firstSite M hM0) * (∏ _m ∈ I, (1 : G)) * x (lastSite M hM0) := by
        have hxI : ∀ m ∈ I, x m * x m = 1 := fun m hm => by
          rw [hI, Finset.mem_filter] at hm
          exact hx m hm.2.1 hm.2.2
        rw [Finset.prod_congr rfl hxI]
    _ = x (firstSite M hM0) * x (lastSite M hM0) := by
        rw [Finset.prod_const_one, mul_one]

end Ising2D.NecSuf
