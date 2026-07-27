/-
# `H_1^{(+)}, H_2` と `check(Z)_μ, check(Y)_μ` の交換関係（**具体版**）

対応する人手証明のラベル: `commutator_of_H_and_check_Z_Y`
（`structured-latex/content/013_even_sector_modes.ts` の
`evensector_004_claim_commutator_H_check_Z_Y`）

**抽象版**は既存の `Ising2D/Abstract/CommutatorClifford.lean`
（`Ising2D.Abstract.CliffordTriple.lie_sum_yz_z` ほか）。
本ファイルの 4 本 (A)〜(D) はすべてその系として導く。
すなわち**整数運動量の 6 本（`Part008/Claim001_CommutatorHZY.lean`）と
半整数運動量の 4 本は、同じ抽象版の別の特殊化である**。
違いは `CliffordTriple` に渡す反交換子の値 `D` だけで、
整数運動量では `2M δ^M_{μ+ν,0}`、半整数運動量では `2M δ^M_{μ+ν,1}` である。

## 原文の主張（`μ ∈ 𝓜̌`）

  (A) `[H_1^{(+)}, check(Z)_μ] = 2 e^{-iθ~_μ} check(Y)_μ`
  (B) `[H_1^{(+)}, check(Y)_μ] = -2 e^{iθ~_μ} check(Z)_μ`
  (C) `[H_2, check(Z)_μ]       = -2 check(Y)_μ`
  (D) `[H_2, check(Y)_μ]       = 2 check(Z)_μ`

これは `commutator_of_H_and_Z_Y` の (A)〜(D) と同じ形である
（`θ_μ → θ~_μ`、`hat(Z)^{(±)}, hat(Y) → check(Z), check(Y)`）。

**とくに (C) が `hat(Z)^{(+)}` では壊れていた**（`why_008_applies_only_to_minus_sector`:
`[H_2, hat(Z)^{(+)}_μ] = -2 hat(Y)_μ + 4 e^{-iθ_μ} Y_1`）のに対し、
`check(Z)` では余分な項が出ない。抽象版の言葉では
「`hat(Z)^{(±)}` は `Dz ≠ Dz'` の 3 族だったが、`check(Z)` は 1 つの族で `Dz = Dz'` である」
ということであり、その根拠は `check` の係数に例外項が無いこと
（境界の符号を位相の反周期性が担っていること）である。

## 添字の扱い

添字 `μ` は `ℤ` のまま扱う。原文は `μ ∈ 𝓜̌` に絞っているが、
本ファイルの 4 本は `μ ∈ ℤ` 全体で成り立つ（`𝓜̌` に絞る必要があるのは
反交換関係を `δ_{ν,M+1-μ}` の形で述べるときだけである）。
-/
import Ising2D.Part013.Claim005_AnticommutatorCheckZY
import Ising2D.Part013.Claim007_H1H2ViaCheck
import Ising2D.Part008.Claim001_CommutatorHZY

namespace Ising2D

variable {M : ℕ}

/-! ## `δ^M` の添字の書き換え -/

/-- 共役添字を入れた `δ`: `δ^M_{((M+1-a)+ν, 1)} = δ^M_{(ν-a, 0)}`。 -/
theorem deltaMod_conj_shift (M : ℕ) (a ν : ℤ) :
    deltaMod M (((M : ℤ) + 1 - a) + ν) 1 = deltaMod M (ν - a) 0 := by
  rw [deltaMod, deltaMod, sub_zero,
    show ((M : ℤ) + 1 - a + ν) - 1 = (M : ℤ) + (ν - a) by ring]
  by_cases hd : (M : ℤ) ∣ (ν - a)
  · rw [if_pos (Dvd.dvd.add (dvd_refl _) hd), if_pos hd]
  · rw [if_neg ?_, if_neg hd]
    intro hc
    have h := dvd_sub hc (dvd_refl (M : ℤ))
    rw [show (M : ℤ) + (ν - a) - (M : ℤ) = ν - a by ring] at h
    exact hd h

/-- 対の `δ` の書き換え: `δ^M_{(a+ν, 1)} = δ^M_{((1-ν)-a, 0)}`。 -/
theorem deltaMod_pair_shift (M : ℕ) (a ν : ℤ) :
    deltaMod M (a + ν) 1 = deltaMod M ((1 - ν) - a) 0 := by
  rw [deltaMod, deltaMod, sub_zero, show a + ν - 1 = -((1 - ν) - a) by ring]
  simp only [dvd_neg]

/-! ## 合同不変性（`sum_deltaMod_select` に渡す `F` たち） -/

theorem congr_checkY (hM : M ≠ 0) : ∀ a b : ℤ, (M : ℤ) ∣ a - b → checkY M a = checkY M b :=
  fun _ _ h => checkY_congr hM h

theorem congr_checkPhase_smul_checkY (hM : M ≠ 0) :
    ∀ a b : ℤ, (M : ℤ) ∣ a - b →
      checkPhase M 1 a • checkY M a = checkPhase M 1 b • checkY M b :=
  fun _ _ h => by rw [checkPhase_congr hM 1 h, checkY_congr hM h]

theorem congr_checkZ_conj (hM : M ≠ 0) :
    ∀ a b : ℤ, (M : ℤ) ∣ a - b → checkZ M ((M : ℤ) + 1 - a) = checkZ M ((M : ℤ) + 1 - b) :=
  fun a b h =>
    checkZ_congr hM (by
      rw [show ((M : ℤ) + 1 - a) - ((M : ℤ) + 1 - b) = -(a - b) by ring]
      exact (dvd_neg).2 h)

theorem congr_checkPhase_smul_checkZ_conj (hM : M ≠ 0) :
    ∀ a b : ℤ, (M : ℤ) ∣ a - b →
      checkPhase M 1 a • checkZ M ((M : ℤ) + 1 - a)
        = checkPhase M 1 b • checkZ M ((M : ℤ) + 1 - b) :=
  fun a b h => by rw [checkPhase_congr hM 1 h, congr_checkZ_conj hM a b h]

/-! ## 抽象版への橋渡し: `check(Z), check(Y)` は Clifford 型の 3 族をなす -/

/-- `check(Z)`, `check(Y)` を抽象版 `Ising2D.Abstract.CliffordTriple` の 3 族として与える。

整数運動量版 `Ising2D.hatCliffordTriple` と違い、**`z` と `z'` が同じ族**である
（`hat(Z)^{(±)}` のような符号違いの相棒が存在しない）。
これが (C) の余分な項が出ない理由そのものである。 -/
noncomputable def checkCliffordTriple (M : ℕ) (hM : M ≠ 0) :
    Abstract.CliffordTriple ℂ (TensorPow M) ℤ where
  z := fun μ => checkZ M μ
  z' := fun μ => checkZ M μ
  y := fun μ => checkY M μ
  Dz := fun μ ν => 2 * (M : ℂ) * deltaMod M (μ + ν) 1
  Dz' := fun μ ν => 2 * (M : ℂ) * deltaMod M (μ + ν) 1
  Dy := fun μ ν => 2 * (M : ℂ) * deltaMod M (μ + ν) 1
  acomm_z_z := fun a b => acomm_checkZ_checkZ hM a b
  acomm_z_z' := fun a b => acomm_checkZ_checkZ hM a b
  acomm_z_y := fun a b => acomm_checkZ_checkY a b
  acomm_z'_y := fun a b => acomm_checkZ_checkY a b
  acomm_y_y := fun a b => acomm_checkY_checkY hM a b

@[simp] theorem checkCliffordTriple_z (hM : M ≠ 0) :
    (checkCliffordTriple M hM).z = fun μ => checkZ M μ := rfl

@[simp] theorem checkCliffordTriple_y (hM : M ≠ 0) :
    (checkCliffordTriple M hM).y = fun μ => checkY M μ := rfl

@[simp] theorem checkCliffordTriple_Dz (hM : M ≠ 0) :
    (checkCliffordTriple M hM).Dz = fun μ ν => 2 * (M : ℂ) * deltaMod M (μ + ν) 1 := rfl

@[simp] theorem checkCliffordTriple_Dy (hM : M ≠ 0) :
    (checkCliffordTriple M hM).Dy = fun μ ν => 2 * (M : ℂ) * deltaMod M (μ + ν) 1 := rfl

/-! ## 原文 (A)〜(D) -/

/-- **原文 (A) の形式化**: `[H_1^{(+)}, check(Z)_μ] = 2 e^{-iθ~_μ} check(Y)_μ`。 -/
theorem lie_H1Plus_checkZ (hM : M ≠ 0) (ν : ℤ) :
    ⁅H1 M (-1), checkZ M ν⁆ = (2 * checkPhase M 1 ν) • checkY M ν := by
  have hMC : (M : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr hM
  have key := (checkCliffordTriple M hM).lie_sum_yz_z
      (fun i : Fin M => checkPhase M 1 (((i : ℕ) : ℤ) + 1))
      (fun i : Fin M => ((i : ℕ) : ℤ) + 1)
      (fun i : Fin M => (M : ℤ) + 1 - (((i : ℕ) : ℤ) + 1)) ν
  simp only [checkCliffordTriple_z, checkCliffordTriple_y, checkCliffordTriple_Dz] at key
  rw [H1Plus_eq_check_sum hM, Abstract.lie_smul_left, key]
  have hterm : ∀ i : Fin M,
      (checkPhase M 1 (((i : ℕ) : ℤ) + 1) *
        (2 * (M : ℂ) *
          deltaMod M (((M : ℤ) + 1 - (((i : ℕ) : ℤ) + 1)) + ν) 1)) • checkY M (((i : ℕ) : ℤ) + 1)
        = (2 * (M : ℂ)) • (deltaMod M (ν - (((i : ℕ) : ℤ) + 1)) 0 •
            (checkPhase M 1 (((i : ℕ) : ℤ) + 1) • checkY M (((i : ℕ) : ℤ) + 1))) := by
    intro i
    rw [deltaMod_conj_shift]
    simp only [smul_smul]
    congr 1
    ring
  rw [Finset.sum_congr rfl fun i _ => hterm i, ← Finset.smul_sum,
    sum_deltaMod_select hM ν (fun k => checkPhase M 1 k • checkY M k)
      (congr_checkPhase_smul_checkY hM)]
  simp only [smul_smul]
  congr 1
  field_simp

/-- **原文 (B) の形式化**: `[H_1^{(+)}, check(Y)_μ] = -2 e^{iθ~_μ} check(Z)_μ`
（`e^{iθ~_μ} = checkPhase M (-1) μ`）。 -/
theorem lie_H1Plus_checkY (hM : M ≠ 0) (ν : ℤ) :
    ⁅H1 M (-1), checkY M ν⁆ = (-2 * checkPhase M (-1) ν) • checkZ M ν := by
  have hMC : (M : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr hM
  have key := (checkCliffordTriple M hM).lie_sum_yz_y
      (fun i : Fin M => checkPhase M 1 (((i : ℕ) : ℤ) + 1))
      (fun i : Fin M => ((i : ℕ) : ℤ) + 1)
      (fun i : Fin M => (M : ℤ) + 1 - (((i : ℕ) : ℤ) + 1)) ν
  simp only [checkCliffordTriple_z, checkCliffordTriple_y, checkCliffordTriple_Dy] at key
  rw [H1Plus_eq_check_sum hM, Abstract.lie_smul_left, key]
  have hterm : ∀ i : Fin M,
      (checkPhase M 1 (((i : ℕ) : ℤ) + 1) *
        (2 * (M : ℂ) * deltaMod M ((((i : ℕ) : ℤ) + 1) + ν) 1)) •
          checkZ M ((M : ℤ) + 1 - (((i : ℕ) : ℤ) + 1))
        = (2 * (M : ℂ)) • (deltaMod M ((1 - ν) - (((i : ℕ) : ℤ) + 1)) 0 •
            (checkPhase M 1 (((i : ℕ) : ℤ) + 1) •
              checkZ M ((M : ℤ) + 1 - (((i : ℕ) : ℤ) + 1)))) := by
    intro i
    rw [deltaMod_pair_shift]
    simp only [smul_smul]
    congr 1
    ring
  rw [Finset.sum_congr rfl fun i _ => hterm i, ← Finset.smul_sum,
    sum_deltaMod_select hM (1 - ν) (fun k => checkPhase M 1 k • checkZ M ((M : ℤ) + 1 - k))
      (congr_checkPhase_smul_checkZ_conj hM)]
  have hZ : checkZ M ((M : ℤ) + 1 - (1 - ν)) = checkZ M ν :=
    checkZ_congr hM ⟨1, by ring⟩
  have hP : checkPhase M 1 (1 - ν) = checkPhase M (-1) ν := by
    rw [checkPhase, checkPhase]
    congr 1
    ring
  rw [hZ, hP]
  simp only [smul_smul, ← neg_smul]
  congr 1
  field_simp

/-- **原文 (C) の形式化**: `[H_2, check(Z)_μ] = -2 check(Y)_μ`。

整数運動量の `hat(Z)^{(+)}` では余分な項 `4 e^{-iθ_μ} Y_1` が出た
（`why_008_applies_only_to_minus_sector`）が、`check(Z)` では出ない。 -/
theorem lie_H2_checkZ (hM : M ≠ 0) (ν : ℤ) :
    ⁅H2 M, checkZ M ν⁆ = (-2 : ℂ) • checkY M ν := by
  have hMC : (M : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr hM
  have key := (checkCliffordTriple M hM).lie_sum_zy_z
      (fun _ : Fin M => (1 : ℂ))
      (fun i : Fin M => ((i : ℕ) : ℤ) + 1)
      (fun i : Fin M => (M : ℤ) + 1 - (((i : ℕ) : ℤ) + 1)) ν
  simp only [checkCliffordTriple_z, checkCliffordTriple_y, checkCliffordTriple_Dz] at key
  rw [H2_eq_check_sum hM, Abstract.lie_smul_left,
    Finset.sum_congr rfl fun i (_ : i ∈ Finset.univ) => (one_smul ℂ _).symm, key]
  have hterm : ∀ i : Fin M,
      ((1 : ℂ) *
        (2 * (M : ℂ) *
          deltaMod M (((M : ℤ) + 1 - (((i : ℕ) : ℤ) + 1)) + ν) 1)) • checkY M (((i : ℕ) : ℤ) + 1)
        = (2 * (M : ℂ)) • (deltaMod M (ν - (((i : ℕ) : ℤ) + 1)) 0 •
            checkY M (((i : ℕ) : ℤ) + 1)) := by
    intro i
    rw [deltaMod_conj_shift]
    simp only [smul_smul]
    congr 1
    ring
  rw [Finset.sum_congr rfl fun i _ => hterm i, ← Finset.smul_sum,
    sum_deltaMod_select hM ν (fun k => checkY M k) (congr_checkY hM)]
  simp only [smul_smul, ← neg_smul]
  congr 1
  field_simp

/-- **原文 (D) の形式化**: `[H_2, check(Y)_μ] = 2 check(Z)_μ`。 -/
theorem lie_H2_checkY (hM : M ≠ 0) (ν : ℤ) :
    ⁅H2 M, checkY M ν⁆ = (2 : ℂ) • checkZ M ν := by
  have hMC : (M : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr hM
  have key := (checkCliffordTriple M hM).lie_sum_zy_y
      (fun _ : Fin M => (1 : ℂ))
      (fun i : Fin M => ((i : ℕ) : ℤ) + 1)
      (fun i : Fin M => (M : ℤ) + 1 - (((i : ℕ) : ℤ) + 1)) ν
  simp only [checkCliffordTriple_z, checkCliffordTriple_y, checkCliffordTriple_Dy] at key
  rw [H2_eq_check_sum hM, Abstract.lie_smul_left,
    Finset.sum_congr rfl fun i (_ : i ∈ Finset.univ) => (one_smul ℂ _).symm, key]
  have hterm : ∀ i : Fin M,
      ((1 : ℂ) * (2 * (M : ℂ) * deltaMod M ((((i : ℕ) : ℤ) + 1) + ν) 1)) •
          checkZ M ((M : ℤ) + 1 - (((i : ℕ) : ℤ) + 1))
        = (2 * (M : ℂ)) • (deltaMod M ((1 - ν) - (((i : ℕ) : ℤ) + 1)) 0 •
            checkZ M ((M : ℤ) + 1 - (((i : ℕ) : ℤ) + 1))) := by
    intro i
    rw [deltaMod_pair_shift]
    simp only [smul_smul]
    congr 1
    ring
  rw [Finset.sum_congr rfl fun i _ => hterm i, ← Finset.smul_sum,
    sum_deltaMod_select hM (1 - ν) (fun k => checkZ M ((M : ℤ) + 1 - k)) (congr_checkZ_conj hM)]
  have hZ : checkZ M ((M : ℤ) + 1 - (1 - ν)) = checkZ M ν :=
    checkZ_congr hM ⟨1, by ring⟩
  rw [hZ]
  simp only [smul_smul]
  congr 1
  field_simp

end Ising2D
