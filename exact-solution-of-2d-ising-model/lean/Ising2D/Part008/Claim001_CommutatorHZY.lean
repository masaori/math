/-
# `H_1^{(±)}, H_2` と `hat(Z)_μ^{(±)}, hat(Y)_μ` の交換関係（**具体版**）

対応する人手証明のラベル: `<commutator_of_H_and_Z_Y>`
（`structured-latex/content/008_TV1_hatZ_hatY_part1.mjs` の
`TV1_hatZ_hatY_001_claim_commutator_H_Z_Y`。
旧 Typst は `_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/000_claim_H1_H2とhatZ_hatYの交換関係.typ`）

**抽象版**は `Ising2D/Abstract/CommutatorClifford.lean`（名前空間 `Ising2D.Abstract`、
同じラベル `<commutator_of_H_and_Z_Y>`）。本ファイルの 6 本はすべて抽象版
`Ising2D.Abstract.CliffordTriple.lie_sum_*` の系として導く。

## 原文の主張（`μ ∈ ℳ`、`θ_μ := 2πμ/M`）

  (1) `[H_1^{(±)}, hat(Z)_μ^{(±)}] = 2 e^{-iθ_μ} hat(Y)_μ`
  (2) `[H_1^{(±)}, hat(Z)_μ^{(∓)}] = 2 e^{-iθ_μ} hat(Y)_μ`
  (3) `[H_1^{(±)}, hat(Y)_μ]       = -2 e^{iθ_μ} hat(Z)_μ^{(±)}`
  (4) `[H_2, hat(Z)_μ^{(-)}]       = -2 hat(Y)_μ`
  (5) `[H_2, hat(Z)_μ^{(+)}]       = -2 hat(Y)_μ + (1/M) ∑_j (-2 e^{-i(2π/M)(-j+μ)} hat(Y)_j)`
  (6) `[H_2, hat(Y)_μ]             = 2 hat(Z)_μ^{(-)}`

## 形式化の過程で見つかった原文の誤り（**(2) と (5) は偽**）

`hat(Z)^{(±)}` どうしの反交換関係は符号が同じときと違うときで値が違う
（`<anticommutator_of_hat_Z_and_hat_Y>` の 1 と 2）:

  `[hat(Z)_μ^{(±)}, hat(Z)_ν^{(±)}]₊ = 2M δ^M_{μ+ν,0} I`
  `[hat(Z)_μ^{(±)}, hat(Z)_ν^{(∓)}]₊ = 2M δ^M_{μ+ν,0} I - 4 e^{-i2π(μ+ν)/M} I`

(2) と (5) はこの第 2 式を使う場合であり、余分な項 `-4 e^{-i2π(μ+ν)/M} I` が残る。
本ファイルの計算では次が正しい（`Y_1, Y_M` は Jordan–Wigner 文字列そのもの。
`hat(Y)` ではないことに注意）:

  (2') `[H_1^{(±)}, hat(Z)_μ^{(∓)}] = 2 e^{-iθ_μ} hat(Y)_μ - 4 e^{-iθ_μ} Y_M`
  (5') `[H_2, hat(Z)_μ^{(+)}]       = -2 hat(Y)_μ + 4 e^{-iθ_μ} Y_1`

* (2) について: 原文自身が最終段まで余分な項
  `-(4/M) e^{-iθ_μ} ∑_{k=1}^M Y_k M δ^M_{(k,0)}` を持っており、そこで**この項を `0` と置いて**
  結論している（`structured-latex` の当該ブロックの `conversion.notes` にもその旨が記録されている）。
  しかし `k ∈ {1,…,M}` の範囲で `δ^M_{(k,0)} = 1` になるのは `k = M` であって、この項は
  `-4 e^{-iθ_μ} Y_M` に等しく、消えない。
* (5) について: 原文は `-[hat(Z)_μ^{(+)}, hat(Z)_{-j}^{(-)}]₊` を展開するとき、
  マイナス符号を第 1 項にしか分配しておらず（第 2 項が `-4e` のまま符号が変わっていない）、
  さらに次の行で係数 `4` が `2` になっている。正しく分配すると `+4 e^{-i(2π/M)(-j+μ)}` で、
  和を実行すると `+4 e^{-iθ_μ} Y_1` になる。原文の値とは符号も係数も異なる。

いずれも Lean 側で**原文の主張が偽であること**を証明した
（`lie_H1_hatZ_opp_ne_orig`, `lie_H2_hatZPlus_ne_orig`。`Y_m` は `Y_m^2 = 1` より `0` でない）。

なお、後段（`<nesting_of_commutator_of_H_and_Z>` 以降）が使うのは (1)(3)(4)(6) の 4 本だけで
（当該ブロックの proof が (A)(B)(C)(D) として明示している）、誤っている (2)(5) は使われていない。
したがってこの誤りは後段の結論には波及しない。

## 添字の扱い

添字 `μ` は `ℤ` のまま扱う（既存の `hatZ`, `hatY` と同じ方針）。
原文は `δ^M_{-j+μ,0}` を満たす `j ∈ {1,…,M}` を 3 通りに場合分けして決定しているが、
Lean では「`M` を法として合同なら `hat(Z)`, `hat(Y)`, 位相因子はすべて等しい」
（`hatZ_congr`, `hatY_congr`, `expPhase_congr`）にまとめてある。
原文の 3 通りの場合分けは、この合同不変性を `μ` の範囲ごとに手で書き下したものにほかならない。
-/
import Ising2D.Part004.Claim011_H1H2ViaHat
import Ising2D.Part007.Claim000_AnticommutatorHatZHatY
import Ising2D.Abstract.CommutatorClifford

namespace Ising2D

variable {M : ℕ}

/-! ## site 添字 `1` と `M` -/

/-- 原文の site 添字 `1`（Lean の `Fin M` では `0`）。 -/
def firstSite (M : ℕ) (hM : M ≠ 0) : Fin M := ⟨0, Nat.pos_of_ne_zero hM⟩

/-- 原文の site 添字 `M`（Lean の `Fin M` では `M - 1`）。 -/
def lastSite (M : ℕ) (hM : M ≠ 0) : Fin M :=
  ⟨M - 1, Nat.sub_lt (Nat.pos_of_ne_zero hM) Nat.one_pos⟩

/-! ## 補助: `δ^M` と位相因子 -/

theorem expPhase_ne_zero (M : ℕ) (k : ℤ) : expPhase M k ≠ 0 := Complex.exp_ne_zero _

theorem deltaMod_neg (M : ℕ) (x : ℤ) : deltaMod M (-x) 0 = deltaMod M x 0 := by
  simp only [deltaMod, sub_zero, dvd_neg]

/-- `j ∈ {1,…,M}` の範囲で `δ^M_{(j,0)} = 1` になるのは `j = M` だけ。 -/
theorem deltaMod_succ_eq (hM : M ≠ 0) (k : Fin M) :
    deltaMod M (((k : ℕ) : ℤ) + 1) 0 = if k = lastSite M hM then 1 else 0 := by
  have hcast : (((k : ℕ) : ℤ) + 1) = (((k : ℕ) + 1 : ℕ) : ℤ) := by push_cast; ring
  have hiff : ((M : ℤ) ∣ (((k : ℕ) : ℤ) + 1)) ↔ k = lastSite M hM := by
    rw [hcast, Int.natCast_dvd_natCast]
    constructor
    · intro h
      have := Nat.le_of_dvd (Nat.succ_pos _) h
      have hk : (k : ℕ) + 1 = M := Nat.le_antisymm k.isLt this
      exact Fin.val_injective (by simp [lastSite]; omega)
    · intro h
      have hk : (k : ℕ) = M - 1 := by rw [h]; rfl
      have : (k : ℕ) + 1 = M := by
        have := Nat.pos_of_ne_zero hM
        omega
      exact ⟨1, by omega⟩
  rw [deltaMod, sub_zero]
  by_cases h : k = lastSite M hM
  · rw [if_pos (hiff.2 h), if_pos h]
  · rw [if_neg (fun hd => h (hiff.1 hd)), if_neg h]

/-- `j ∈ {1,…,M}` の範囲（Lean では `0,…,M-1`）で `δ^M_{(j-1,0)} = 1` になるのは `j = 1` だけ。 -/
theorem deltaMod_val_eq (hM : M ≠ 0) (k : Fin M) :
    deltaMod M ((k : ℕ) : ℤ) 0 = if k = firstSite M hM then 1 else 0 := by
  have hiff : ((M : ℤ) ∣ ((k : ℕ) : ℤ)) ↔ k = firstSite M hM := by
    rw [Int.natCast_dvd_natCast]
    constructor
    · intro h
      have hk0 : (k : ℕ) = 0 := Nat.eq_zero_of_dvd_of_lt h k.isLt
      exact Fin.val_injective (by simp [firstSite, hk0])
    · intro h
      have : (k : ℕ) = 0 := by rw [h]; rfl
      exact ⟨0, by omega⟩
  rw [deltaMod, sub_zero]
  by_cases h : k = firstSite M hM
  · rw [if_pos (hiff.2 h), if_pos h]
  · rw [if_neg (fun hd => h (hiff.1 hd)), if_neg h]

/-! ## 補助: `δ^M` による添字の選択（原文の場合分けの代わり）

原文は `δ^M_{-j+μ,0}` を満たす `j ∈ {1,…,M}` を `μ` の範囲で 3 通りに分けて決定し、
そのあと `M` 周期性で 3 つの場合を 1 つにまとめている。ここでは
「`M` を法として合同なら値が等しい」関数 `F` に対して、和が `F(μ)` になることを一度に示す。 -/

theorem sum_deltaMod_select {A : Type*} [AddCommMonoid A] [Module ℂ A]
    (hM : M ≠ 0) (μ : ℤ) (F : ℤ → A)
    (hF : ∀ a b : ℤ, (M : ℤ) ∣ a - b → F a = F b) :
    ∑ j : Fin M, deltaMod M (μ - (((j : ℕ) : ℤ) + 1)) 0 • F (((j : ℕ) : ℤ) + 1) = F μ := by
  classical
  have hM0 : (0 : ℤ) < (M : ℤ) := by exact_mod_cast Nat.pos_of_ne_zero hM
  have hr0 : 0 ≤ (μ - 1) % (M : ℤ) := Int.emod_nonneg _ (ne_of_gt hM0)
  have hrM : (μ - 1) % (M : ℤ) < (M : ℤ) := Int.emod_lt_of_pos _ hM0
  have hrtoNat : (((μ - 1) % (M : ℤ)).toNat : ℤ) = (μ - 1) % (M : ℤ) := Int.toNat_of_nonneg hr0
  have hlt : ((μ - 1) % (M : ℤ)).toNat < M := by omega
  set j₀ : Fin M := ⟨((μ - 1) % (M : ℤ)).toNat, hlt⟩ with hj₀
  have hj₀val : ((j₀ : ℕ) : ℤ) = (μ - 1) % (M : ℤ) := hrtoNat
  have hdvd₀ : (M : ℤ) ∣ (μ - (((j₀ : ℕ) : ℤ) + 1)) := by
    rw [hj₀val,
      show μ - ((μ - 1) % (M : ℤ) + 1) = (μ - 1) - (μ - 1) % (M : ℤ) from by ring]
    exact dvd_sub_comm.mp Int.dvd_emod_sub_self
  rw [Finset.sum_eq_single_of_mem j₀ (Finset.mem_univ _)]
  · rw [deltaMod, sub_zero, if_pos hdvd₀, one_smul]
    exact hF _ _ (by
      have : (((j₀ : ℕ) : ℤ) + 1) - μ = -(μ - (((j₀ : ℕ) : ℤ) + 1)) := by ring
      rw [this]
      exact (dvd_neg).2 hdvd₀)
  · intro j _ hj
    rw [deltaMod, sub_zero, if_neg, zero_smul]
    intro hdvd
    apply hj
    have hsub : (M : ℤ) ∣ (((j₀ : ℕ) : ℤ) - ((j : ℕ) : ℤ)) := by
      have h := dvd_sub hdvd hdvd₀
      have heq : (μ - (((j : ℕ) : ℤ) + 1)) - (μ - (((j₀ : ℕ) : ℤ) + 1))
          = ((j₀ : ℕ) : ℤ) - ((j : ℕ) : ℤ) := by ring
      rwa [heq] at h
    exact ((dvd_sub_iff_eq j₀ j).1 hsub).symm

/-! ## 合同不変性（`sum_deltaMod_select` に渡す `F` たち） -/

theorem congr_hatY (hM : M ≠ 0) : ∀ a b : ℤ, (M : ℤ) ∣ a - b → hatY M a = hatY M b :=
  fun _ _ h => hatY_congr hM h

theorem congr_expPhase_smul_hatY (hM : M ≠ 0) :
    ∀ a b : ℤ, (M : ℤ) ∣ a - b → expPhase M a • hatY M a = expPhase M b • hatY M b :=
  fun _ _ h => by rw [expPhase_congr hM h, hatY_congr hM h]

theorem congr_hatZ_neg (hM : M ≠ 0) (η : ℂ) :
    ∀ a b : ℤ, (M : ℤ) ∣ a - b → hatZ M η (-a) = hatZ M η (-b) :=
  fun a b h => hatZ_congr hM η (by rw [show -a - -b = -(a - b) from by ring]; exact (dvd_neg).2 h)

theorem congr_expPhase_smul_hatZ_neg (hM : M ≠ 0) (η : ℂ) :
    ∀ a b : ℤ, (M : ℤ) ∣ a - b →
      expPhase M a • hatZ M η (-a) = expPhase M b • hatZ M η (-b) :=
  fun a b h => by rw [expPhase_congr hM h, congr_hatZ_neg hM η a b h]

/-! ## 補助: `hat(Y)` の総和（原文が `0` と置いた項の正体） -/

/-- `∑_{j=1}^{M} hat(Y)_j = M Y_M`。

原文 (2) の最終段に現れる `∑_k Y_k M δ^M_{(k,0)}` がこれにあたる（`k = M` の項だけ残る）。 -/
theorem sum_hatY (hM : M ≠ 0) :
    ∑ j : Fin M, hatY M (((j : ℕ) : ℤ) + 1) = (M : ℂ) • Y (lastSite M hM) := by
  have hswap : ∑ j : Fin M, hatY M (((j : ℕ) : ℤ) + 1)
      = ∑ k : Fin M, (∑ j : Fin M,
          expPhase M ((((j : ℕ) : ℤ) + 1) * (((k : ℕ) : ℤ) + 1))) • Y k := by
    simp only [hatY]
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [Finset.sum_smul]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [show ((((k : ℕ) : ℤ) + 1) * (((j : ℕ) : ℤ) + 1))
        = ((((j : ℕ) : ℤ) + 1) * (((k : ℕ) : ℤ) + 1)) from by ring]
  rw [hswap]
  have : ∀ k : Fin M, (∑ j : Fin M,
      expPhase M ((((j : ℕ) : ℤ) + 1) * (((k : ℕ) : ℤ) + 1))) • Y k
      = ((M : ℂ) * (if k = lastSite M hM then 1 else 0)) • Y k := by
    intro k
    rw [expPhase_sum hM, deltaMod_succ_eq hM]
  rw [Finset.sum_congr rfl fun k _ => this k,
    Finset.sum_eq_single_of_mem (lastSite M hM) (Finset.mem_univ _)]
  · rw [if_pos rfl, mul_one]
  · intro k _ hk
    rw [if_neg hk, mul_zero, zero_smul]

/-- `∑_{j=1}^{M} e^{i 2πj/M} hat(Y)_j = M Y_1`。

原文 (5) に現れる `∑_j e^{-i(2π/M)(-j+μ)} hat(Y)_j` の `e^{-iθ_μ}` を除いた部分。 -/
theorem sum_expPhase_neg_smul_hatY (hM : M ≠ 0) :
    ∑ j : Fin M, expPhase M (-(((j : ℕ) : ℤ) + 1)) • hatY M (((j : ℕ) : ℤ) + 1)
      = (M : ℂ) • Y (firstSite M hM) := by
  have hswap : ∑ j : Fin M, expPhase M (-(((j : ℕ) : ℤ) + 1)) • hatY M (((j : ℕ) : ℤ) + 1)
      = ∑ k : Fin M, (∑ j : Fin M,
          expPhase M ((((j : ℕ) : ℤ) + 1) * ((k : ℕ) : ℤ))) • Y k := by
    simp only [hatY, Finset.smul_sum, smul_smul]
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [Finset.sum_smul]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [← expPhase_add, show (-(((j : ℕ) : ℤ) + 1) + ((((k : ℕ) : ℤ) + 1) * (((j : ℕ) : ℤ) + 1)))
        = ((((j : ℕ) : ℤ) + 1) * ((k : ℕ) : ℤ)) from by ring]
  rw [hswap]
  have : ∀ k : Fin M, (∑ j : Fin M,
      expPhase M ((((j : ℕ) : ℤ) + 1) * ((k : ℕ) : ℤ))) • Y k
      = ((M : ℂ) * (if k = firstSite M hM then 1 else 0)) • Y k := by
    intro k
    rw [expPhase_sum hM, deltaMod_val_eq hM]
  rw [Finset.sum_congr rfl fun k _ => this k,
    Finset.sum_eq_single_of_mem (firstSite M hM) (Finset.mem_univ _)]
  · rw [if_pos rfl, mul_one]
  · intro k _ hk
    rw [if_neg hk, mul_zero, zero_smul]

/-! ## 抽象版への橋渡し: `hat(Z)^{(±)}, hat(Y)` は Clifford 型の 3 族をなす -/

/-- `hat(Z)^{(η)}`, `hat(Z)^{(-η)}`, `hat(Y)` を抽象版
`Ising2D.Abstract.CliffordTriple` の 3 族として与える
（反交換関係は `<anticommutator_of_hat_Z_and_hat_Y>` の 4 式）。 -/
noncomputable def hatCliffordTriple (M : ℕ) (hM : M ≠ 0) (η : ℂ) (hη : η * η = 1) :
    Abstract.CliffordTriple ℂ (TensorPow M) ℤ where
  z := fun μ => hatZ M η μ
  z' := fun μ => hatZ M (-η) μ
  y := fun μ => hatY M μ
  Dz := fun μ ν => 2 * (M : ℂ) * deltaMod M (μ + ν) 0
  Dz' := fun μ ν => 2 * (M : ℂ) * deltaMod M (μ + ν) 0 - 4 * expPhase M (μ + ν)
  Dy := fun μ ν => 2 * (M : ℂ) * deltaMod M (μ + ν) 0
  acomm_z_z := fun a b => acomm_hatZ_hatZ_same hM hη a b
  acomm_z_z' := fun a b => acomm_hatZ_hatZ_opp hM hη a b
  acomm_z_y := fun a b => acomm_hatZ_hatY η a b
  acomm_z'_y := fun a b => acomm_hatZ_hatY (-η) a b
  acomm_y_y := fun a b => acomm_hatY_hatY hM a b

@[simp] theorem hatCliffordTriple_z (hM : M ≠ 0) (η : ℂ) (hη : η * η = 1) :
    (hatCliffordTriple M hM η hη).z = fun μ => hatZ M η μ := rfl

@[simp] theorem hatCliffordTriple_z' (hM : M ≠ 0) (η : ℂ) (hη : η * η = 1) :
    (hatCliffordTriple M hM η hη).z' = fun μ => hatZ M (-η) μ := rfl

@[simp] theorem hatCliffordTriple_y (hM : M ≠ 0) (η : ℂ) (hη : η * η = 1) :
    (hatCliffordTriple M hM η hη).y = fun μ => hatY M μ := rfl

@[simp] theorem hatCliffordTriple_Dz (hM : M ≠ 0) (η : ℂ) (hη : η * η = 1) :
    (hatCliffordTriple M hM η hη).Dz
      = fun μ ν => 2 * (M : ℂ) * deltaMod M (μ + ν) 0 := rfl

@[simp] theorem hatCliffordTriple_Dz' (hM : M ≠ 0) (η : ℂ) (hη : η * η = 1) :
    (hatCliffordTriple M hM η hη).Dz'
      = fun μ ν => 2 * (M : ℂ) * deltaMod M (μ + ν) 0 - 4 * expPhase M (μ + ν) := rfl

@[simp] theorem hatCliffordTriple_Dy (hM : M ≠ 0) (η : ℂ) (hη : η * η = 1) :
    (hatCliffordTriple M hM η hη).Dy
      = fun μ ν => 2 * (M : ℂ) * deltaMod M (μ + ν) 0 := rfl

/-! ## 原文 (1)〜(6) -/

/-- **原文 (1) の形式化**: `[H_1^{(±)}, hat(Z)_μ^{(±)}] = 2 e^{-iθ_μ} hat(Y)_μ`。 -/
theorem lie_H1_hatZ_same (hM : M ≠ 0) {η : ℂ} (hη : η * η = 1) (μ : ℤ) :
    ⁅H1 M η, hatZ M η μ⁆ = (2 * expPhase M μ) • hatY M μ := by
  have hMC : (M : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr hM
  have key := (hatCliffordTriple M hM η hη).lie_sum_yz_z
      (fun j : Fin M => expPhase M (((j : ℕ) : ℤ) + 1))
      (fun j : Fin M => ((j : ℕ) : ℤ) + 1)
      (fun j : Fin M => -(((j : ℕ) : ℤ) + 1)) μ
  simp only [hatCliffordTriple_z, hatCliffordTriple_y, hatCliffordTriple_Dz] at key
  rw [H1_eq_hat_sum hM, Abstract.lie_smul_left, key]
  have hterm : ∀ j : Fin M,
      (expPhase M (((j : ℕ) : ℤ) + 1) *
        (2 * (M : ℂ) * deltaMod M (-(((j : ℕ) : ℤ) + 1) + μ) 0)) • hatY M (((j : ℕ) : ℤ) + 1)
      = (2 * (M : ℂ)) • (deltaMod M (μ - (((j : ℕ) : ℤ) + 1)) 0 •
          (expPhase M (((j : ℕ) : ℤ) + 1) • hatY M (((j : ℕ) : ℤ) + 1))) := by
    intro j
    simp only [show -(((j : ℕ) : ℤ) + 1) + μ = μ - (((j : ℕ) : ℤ) + 1) from by ring, smul_smul]
    congr 1
    ring
  rw [Finset.sum_congr rfl fun j _ => hterm j, ← Finset.smul_sum,
    sum_deltaMod_select hM μ (fun k => expPhase M k • hatY M k) (congr_expPhase_smul_hatY hM)]
  simp only [smul_smul]
  congr 1
  field_simp

/-- **原文 (3) の形式化**: `[H_1^{(±)}, hat(Y)_μ] = -2 e^{iθ_μ} hat(Z)_μ^{(±)}`
（`e^{iθ_μ} = expPhase M (-μ)`）。 -/
theorem lie_H1_hatY (hM : M ≠ 0) {η : ℂ} (hη : η * η = 1) (μ : ℤ) :
    ⁅H1 M η, hatY M μ⁆ = (-2 * expPhase M (-μ)) • hatZ M η μ := by
  have hMC : (M : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr hM
  have key := (hatCliffordTriple M hM η hη).lie_sum_yz_y
      (fun j : Fin M => expPhase M (((j : ℕ) : ℤ) + 1))
      (fun j : Fin M => ((j : ℕ) : ℤ) + 1)
      (fun j : Fin M => -(((j : ℕ) : ℤ) + 1)) μ
  simp only [hatCliffordTriple_z, hatCliffordTriple_y, hatCliffordTriple_Dy] at key
  rw [H1_eq_hat_sum hM, Abstract.lie_smul_left, key]
  have hterm : ∀ j : Fin M,
      (expPhase M (((j : ℕ) : ℤ) + 1) *
        (2 * (M : ℂ) * deltaMod M ((((j : ℕ) : ℤ) + 1) + μ) 0)) •
          hatZ M η (-(((j : ℕ) : ℤ) + 1))
      = (2 * (M : ℂ)) • (deltaMod M (-μ - (((j : ℕ) : ℤ) + 1)) 0 •
          (expPhase M (((j : ℕ) : ℤ) + 1) • hatZ M η (-(((j : ℕ) : ℤ) + 1)))) := by
    intro j
    rw [show (((j : ℕ) : ℤ) + 1) + μ = -(-μ - (((j : ℕ) : ℤ) + 1)) from by ring, deltaMod_neg]
    simp only [smul_smul]
    congr 1
    ring
  rw [Finset.sum_congr rfl fun j _ => hterm j, ← Finset.smul_sum,
    sum_deltaMod_select hM (-μ) (fun k => expPhase M k • hatZ M η (-k))
      (congr_expPhase_smul_hatZ_neg hM η), neg_neg]
  simp only [smul_smul, ← neg_smul]
  congr 1
  field_simp

/-- **原文 (2) の訂正版**: `[H_1^{(±)}, hat(Z)_μ^{(∓)}] = 2 e^{-iθ_μ} hat(Y)_μ - 4 e^{-iθ_μ} Y_M`。

原文は右辺第 2 項を `0` と置いているが、消えない（冒頭コメント参照）。 -/
theorem lie_H1_hatZ_opp (hM : M ≠ 0) {η : ℂ} (hη : η * η = 1) (μ : ℤ) :
    ⁅H1 M η, hatZ M (-η) μ⁆
      = (2 * expPhase M μ) • hatY M μ - (4 * expPhase M μ) • Y (lastSite M hM) := by
  have hMC : (M : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr hM
  have key := (hatCliffordTriple M hM η hη).lie_sum_yz_z'
      (fun j : Fin M => expPhase M (((j : ℕ) : ℤ) + 1))
      (fun j : Fin M => ((j : ℕ) : ℤ) + 1)
      (fun j : Fin M => -(((j : ℕ) : ℤ) + 1)) μ
  simp only [hatCliffordTriple_z, hatCliffordTriple_z', hatCliffordTriple_y,
    hatCliffordTriple_Dz'] at key
  rw [H1_eq_hat_sum hM, Abstract.lie_smul_left, key]
  have hterm : ∀ j : Fin M,
      (expPhase M (((j : ℕ) : ℤ) + 1) *
        (2 * (M : ℂ) * deltaMod M (-(((j : ℕ) : ℤ) + 1) + μ) 0
          - 4 * expPhase M (-(((j : ℕ) : ℤ) + 1) + μ))) • hatY M (((j : ℕ) : ℤ) + 1)
      = (2 * (M : ℂ)) • (deltaMod M (μ - (((j : ℕ) : ℤ) + 1)) 0 •
          (expPhase M (((j : ℕ) : ℤ) + 1) • hatY M (((j : ℕ) : ℤ) + 1)))
        - (4 * expPhase M μ) • hatY M (((j : ℕ) : ℤ) + 1) := by
    intro j
    have hp : expPhase M (((j : ℕ) : ℤ) + 1) * expPhase M (-(((j : ℕ) : ℤ) + 1) + μ)
        = expPhase M μ := by
      rw [← expPhase_add]
      congr 1
      ring
    rw [show -(((j : ℕ) : ℤ) + 1) + μ = μ - (((j : ℕ) : ℤ) + 1) from by ring] at hp ⊢
    simp only [smul_smul]
    rw [← sub_smul]
    congr 1
    linear_combination (-4 : ℂ) * hp
  rw [Finset.sum_congr rfl fun j _ => hterm j, Finset.sum_sub_distrib, ← Finset.smul_sum,
    sum_deltaMod_select hM μ (fun k => expPhase M k • hatY M k) (congr_expPhase_smul_hatY hM),
    ← Finset.smul_sum, sum_hatY hM]
  simp only [smul_sub, smul_smul]
  congr 1
  · congr 1
    field_simp
  · congr 1
    field_simp

/-- **原文 (4) の形式化**: `[H_2, hat(Z)_μ^{(-)}] = -2 hat(Y)_μ`。 -/
theorem lie_H2_hatZMinus (hM : M ≠ 0) (μ : ℤ) :
    ⁅H2 M, hatZ M 1 μ⁆ = (-2 : ℂ) • hatY M μ := by
  have hMC : (M : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr hM
  have key := (hatCliffordTriple M hM 1 (by norm_num)).lie_sum_zy_z
      (fun _ : Fin M => (1 : ℂ))
      (fun j : Fin M => ((j : ℕ) : ℤ) + 1)
      (fun j : Fin M => -(((j : ℕ) : ℤ) + 1)) μ
  simp only [hatCliffordTriple_z, hatCliffordTriple_y, hatCliffordTriple_Dz] at key
  rw [H2_eq_hat_sum hM, Abstract.lie_smul_left,
    Finset.sum_congr rfl fun j (_ : j ∈ Finset.univ) => (one_smul ℂ _).symm, key]
  have hterm : ∀ j : Fin M,
      ((1 : ℂ) * (2 * (M : ℂ) * deltaMod M (-(((j : ℕ) : ℤ) + 1) + μ) 0)) •
          hatY M (((j : ℕ) : ℤ) + 1)
      = (2 * (M : ℂ)) • (deltaMod M (μ - (((j : ℕ) : ℤ) + 1)) 0 •
          hatY M (((j : ℕ) : ℤ) + 1)) := by
    intro j
    rw [show -(((j : ℕ) : ℤ) + 1) + μ = μ - (((j : ℕ) : ℤ) + 1) from by ring]
    simp only [smul_smul]
    congr 1
    ring
  rw [Finset.sum_congr rfl fun j _ => hterm j, ← Finset.smul_sum,
    sum_deltaMod_select hM μ (fun k => hatY M k) (congr_hatY hM)]
  simp only [smul_smul, ← neg_smul]
  congr 1
  field_simp

/-- **原文 (6) の形式化**: `[H_2, hat(Y)_μ] = 2 hat(Z)_μ^{(-)}`。 -/
theorem lie_H2_hatY (hM : M ≠ 0) (μ : ℤ) :
    ⁅H2 M, hatY M μ⁆ = (2 : ℂ) • hatZ M 1 μ := by
  have hMC : (M : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr hM
  have key := (hatCliffordTriple M hM 1 (by norm_num)).lie_sum_zy_y
      (fun _ : Fin M => (1 : ℂ))
      (fun j : Fin M => ((j : ℕ) : ℤ) + 1)
      (fun j : Fin M => -(((j : ℕ) : ℤ) + 1)) μ
  simp only [hatCliffordTriple_z, hatCliffordTriple_y, hatCliffordTriple_Dy] at key
  rw [H2_eq_hat_sum hM, Abstract.lie_smul_left,
    Finset.sum_congr rfl fun j (_ : j ∈ Finset.univ) => (one_smul ℂ _).symm, key]
  have hterm : ∀ j : Fin M,
      ((1 : ℂ) * (2 * (M : ℂ) * deltaMod M ((((j : ℕ) : ℤ) + 1) + μ) 0)) •
          hatZ M 1 (-(((j : ℕ) : ℤ) + 1))
      = (2 * (M : ℂ)) • (deltaMod M (-μ - (((j : ℕ) : ℤ) + 1)) 0 •
          hatZ M 1 (-(((j : ℕ) : ℤ) + 1))) := by
    intro j
    rw [show (((j : ℕ) : ℤ) + 1) + μ = -(-μ - (((j : ℕ) : ℤ) + 1)) from by ring, deltaMod_neg]
    simp only [smul_smul]
    congr 1
    ring
  rw [Finset.sum_congr rfl fun j _ => hterm j, ← Finset.smul_sum,
    sum_deltaMod_select hM (-μ) (fun k => hatZ M 1 (-k)) (congr_hatZ_neg hM 1), neg_neg]
  simp only [smul_smul]
  congr 1
  field_simp

/-- **原文 (5) の訂正版**: `[H_2, hat(Z)_μ^{(+)}] = -2 hat(Y)_μ + 4 e^{-iθ_μ} Y_1`。

原文は `-2 hat(Y)_μ + (1/M) ∑_j (-2 e^{-i(2π/M)(-j+μ)} hat(Y)_j)`（= `-2 hat(Y)_μ - 2 e^{-iθ_μ} Y_1`）
としているが、符号も係数も誤り（冒頭コメント参照）。 -/
theorem lie_H2_hatZPlus (hM : M ≠ 0) (μ : ℤ) :
    ⁅H2 M, hatZ M (-1) μ⁆
      = (-2 : ℂ) • hatY M μ + (4 * expPhase M μ) • Y (firstSite M hM) := by
  have hMC : (M : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr hM
  have key := (hatCliffordTriple M hM 1 (by norm_num)).lie_sum_zy_z'
      (fun _ : Fin M => (1 : ℂ))
      (fun j : Fin M => ((j : ℕ) : ℤ) + 1)
      (fun j : Fin M => -(((j : ℕ) : ℤ) + 1)) μ
  simp only [hatCliffordTriple_z, hatCliffordTriple_z', hatCliffordTriple_y,
    hatCliffordTriple_Dz'] at key
  rw [H2_eq_hat_sum hM, Abstract.lie_smul_left,
    Finset.sum_congr rfl fun j (_ : j ∈ Finset.univ) => (one_smul ℂ _).symm, key]
  have hterm : ∀ j : Fin M,
      ((1 : ℂ) * (2 * (M : ℂ) * deltaMod M (-(((j : ℕ) : ℤ) + 1) + μ) 0
        - 4 * expPhase M (-(((j : ℕ) : ℤ) + 1) + μ))) • hatY M (((j : ℕ) : ℤ) + 1)
      = (2 * (M : ℂ)) • (deltaMod M (μ - (((j : ℕ) : ℤ) + 1)) 0 •
          hatY M (((j : ℕ) : ℤ) + 1))
        - (4 * expPhase M μ) •
            (expPhase M (-(((j : ℕ) : ℤ) + 1)) • hatY M (((j : ℕ) : ℤ) + 1)) := by
    intro j
    have hp : expPhase M (-(((j : ℕ) : ℤ) + 1) + μ)
        = expPhase M μ * expPhase M (-(((j : ℕ) : ℤ) + 1)) := by
      rw [← expPhase_add]
      congr 1
      ring
    rw [hp, show -(((j : ℕ) : ℤ) + 1) + μ = μ - (((j : ℕ) : ℤ) + 1) from by ring]
    simp only [smul_smul]
    rw [← sub_smul]
    congr 1
    ring
  rw [Finset.sum_congr rfl fun j _ => hterm j, Finset.sum_sub_distrib, ← Finset.smul_sum,
    sum_deltaMod_select hM μ (fun k => hatY M k) (congr_hatY hM), ← Finset.smul_sum,
    sum_expPhase_neg_smul_hatY hM]
  rw [neg_sub, smul_sub]
  simp only [smul_smul]
  rw [sub_eq_add_neg, ← neg_smul, add_comm]
  congr 1
  · congr 1
    field_simp
  · congr 1
    field_simp

/-! ## 原文 (2), (5) が偽であることの証明

`Y_m` は `Y_m^2 = I` を満たすので `0` でない。したがって原文の主張との差
（`4 e^{-iθ_μ} Y_M`、`6 e^{-iθ_μ} Y_1`）は `0` にならない。 -/

/-- `Y_m ≠ 0`（`Y_m^2 = I`（`Ising2D.Y_mul_self`）より）。 -/
theorem Y_ne_zero (m : Fin M) : Y m ≠ (0 : TensorPow M) := by
  intro h
  have h1 := Y_mul_self m
  rw [h, zero_mul] at h1
  exact zero_ne_one h1

/-- **原文 (2) は偽**: `[H_1^{(±)}, hat(Z)_μ^{(∓)}] ≠ 2 e^{-iθ_μ} hat(Y)_μ`。 -/
theorem lie_H1_hatZ_opp_ne_orig (hM : M ≠ 0) {η : ℂ} (hη : η * η = 1) (μ : ℤ) :
    ⁅H1 M η, hatZ M (-η) μ⁆ ≠ (2 * expPhase M μ) • hatY M μ := by
  rw [lie_H1_hatZ_opp hM hη μ]
  intro h
  have hz : (4 * expPhase M μ) • Y (lastSite M hM) = 0 := sub_eq_self.1 h
  rcases smul_eq_zero.1 hz with hc | hy
  · exact (mul_ne_zero (by norm_num) (expPhase_ne_zero M μ)) hc
  · exact Y_ne_zero _ hy

/-- **原文 (5) は偽**:
`[H_2, hat(Z)_μ^{(+)}] ≠ -2 hat(Y)_μ + (1/M) ∑_j (-2 e^{-i(2π/M)(-j+μ)}) hat(Y)_j`。

右辺は原文の式そのもの。左辺との差は `6 e^{-iθ_μ} Y_1 ≠ 0`。 -/
theorem lie_H2_hatZPlus_ne_orig (hM : M ≠ 0) (μ : ℤ) :
    ⁅H2 M, hatZ M (-1) μ⁆
      ≠ (-2 : ℂ) • hatY M μ
        + ((M : ℂ))⁻¹ • ∑ j : Fin M,
            (-2 * expPhase M (-(((j : ℕ) : ℤ) + 1) + μ)) • hatY M (((j : ℕ) : ℤ) + 1) := by
  have hMC : (M : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr hM
  have horig : ((M : ℂ))⁻¹ • ∑ j : Fin M,
      (-2 * expPhase M (-(((j : ℕ) : ℤ) + 1) + μ)) • hatY M (((j : ℕ) : ℤ) + 1)
      = (-2 * expPhase M μ) • Y (firstSite M hM) := by
    have hterm : ∀ j : Fin M,
        (-2 * expPhase M (-(((j : ℕ) : ℤ) + 1) + μ)) • hatY M (((j : ℕ) : ℤ) + 1)
        = (-2 * expPhase M μ) •
            (expPhase M (-(((j : ℕ) : ℤ) + 1)) • hatY M (((j : ℕ) : ℤ) + 1)) := by
      intro j
      have hp : expPhase M (-(((j : ℕ) : ℤ) + 1) + μ)
          = expPhase M μ * expPhase M (-(((j : ℕ) : ℤ) + 1)) := by
        rw [← expPhase_add]
        congr 1
        ring
      rw [smul_smul]
      congr 1
      rw [hp]
      ring
    rw [Finset.sum_congr rfl fun j _ => hterm j, ← Finset.smul_sum,
      sum_expPhase_neg_smul_hatY hM]
    simp only [smul_smul]
    congr 1
    field_simp
  rw [horig, lie_H2_hatZPlus hM μ]
  intro h
  have hz : (4 * expPhase M μ) • Y (firstSite M hM)
      = (-2 * expPhase M μ) • Y (firstSite M hM) := add_left_cancel h
  have hdiff : ((4 * expPhase M μ) - (-2 * expPhase M μ)) • Y (firstSite M hM) = 0 := by
    rw [sub_smul, hz, sub_self]
  rcases smul_eq_zero.1 hdiff with hc | hy
  · have : (6 : ℂ) * expPhase M μ = 0 := by linear_combination hc
    exact (mul_ne_zero (by norm_num) (expPhase_ne_zero M μ)) this
  · exact Y_ne_zero _ hy

/-! ## 原文の `(±)` 記法での言い換え -/

/-- (1) を `hat(Z)^{(+)}`（`η = -1`）で述べた形。 -/
theorem lie_H1Plus_hatZPlus (hM : M ≠ 0) (μ : ℤ) :
    ⁅H1 M (-1), hatZPlus M μ⁆ = (2 * expPhase M μ) • hatY M μ :=
  lie_H1_hatZ_same hM (by norm_num) μ

/-- (1) を `hat(Z)^{(-)}`（`η = 1`）で述べた形。 -/
theorem lie_H1Minus_hatZMinus (hM : M ≠ 0) (μ : ℤ) :
    ⁅H1 M 1, hatZMinus M μ⁆ = (2 * expPhase M μ) • hatY M μ :=
  lie_H1_hatZ_same hM (by norm_num) μ

/-- (3) を `hat(Z)^{(+)}` で述べた形。 -/
theorem lie_H1Plus_hatY (hM : M ≠ 0) (μ : ℤ) :
    ⁅H1 M (-1), hatY M μ⁆ = (-2 * expPhase M (-μ)) • hatZPlus M μ :=
  lie_H1_hatY hM (by norm_num) μ

/-- (3) を `hat(Z)^{(-)}` で述べた形。 -/
theorem lie_H1Minus_hatY (hM : M ≠ 0) (μ : ℤ) :
    ⁅H1 M 1, hatY M μ⁆ = (-2 * expPhase M (-μ)) • hatZMinus M μ :=
  lie_H1_hatY hM (by norm_num) μ

/-- (4) を `hat(Z)^{(-)}` の記法で述べた形。 -/
theorem lie_H2_hatZMinus' (hM : M ≠ 0) (μ : ℤ) :
    ⁅H2 M, hatZMinus M μ⁆ = (-2 : ℂ) • hatY M μ :=
  lie_H2_hatZMinus hM μ

/-- (6) を `hat(Z)^{(-)}` の記法で述べた形。 -/
theorem lie_H2_hatY' (hM : M ≠ 0) (μ : ℤ) :
    ⁅H2 M, hatY M μ⁆ = (2 : ℂ) • hatZMinus M μ :=
  lie_H2_hatY hM μ

/-- (5) の訂正版を `hat(Z)^{(+)}` の記法で述べた形。 -/
theorem lie_H2_hatZPlus' (hM : M ≠ 0) (μ : ℤ) :
    ⁅H2 M, hatZPlus M μ⁆
      = (-2 : ℂ) • hatY M μ + (4 * expPhase M μ) • Y (firstSite M hM) :=
  lie_H2_hatZPlus hM μ

end Ising2D
