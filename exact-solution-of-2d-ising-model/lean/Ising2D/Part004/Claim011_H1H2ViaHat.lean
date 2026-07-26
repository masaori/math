/-
# `H_1^{(±)}, H_2` を `hat(Z), hat(Y)` で表す（**具体版**）

対応する人手証明のラベル: `<H1_H2_via_hatZ_hatY>`
（`structured-latex/content/004_transfer_matrix.mjs` の
`transfer_matrix_012_claim_H1_H2_via_hatZ_hatY`。
旧 Typst は `_old/typst/parts/004_転送行列/011_claim_H1_H2をZhat_Yhatで表す.typ`）

原文の主張:

  `H_1^{(±)} = (1/M) ∑_{j=1}^{M} hat(Y)_j hat(Z)^{(±)}_{-j} exp(-√-1 · 2πj/M)`
  `H_2       = (1/M) ∑_{j=1}^{M} hat(Z)^{(-)}_{-j} hat(Y)_j`

抽象版はこの主張には無い（この等式は `hat(Z), hat(Y)` の**具体形**＝離散フーリエ変換に
本質的に依存するので、抽象化する余地がない）。本ファイルの結果を使う交換関係の側は
具体版 `Ising2D/Part008/Claim001_CommutatorHZY.lean` と
抽象版 `Ising2D/Abstract/CommutatorClifford.lean` の 2 本立てになっている。

## 形式化の方針

* 添字 `μ` は `ℤ` のまま扱う（既存の `hatZ`, `hatY` と同じ）。原文の site 添字 `j ∈ {1,…,M}` は
  Lean では `j : Fin M` で `(j : ℕ) + 1` が原文の `j`。
* 原文の `(±)` の符号は、`H1 M η`（`Definition010_H1H2V1V2.lean`）と
  `hatZ M η μ`（`Definition009_HatZHatY.lean`）が**どちらも原文の `∓1` を `η` で持たせている**
  ので、`H_1^{(±)}` と `hat(Z)^{(±)}` は同じ `η` で対応する
  （`H1 M η` の最終項の係数 `∓1` と `hat(Z)^{(±)}` の `j = 1` の項の係数 `∓1` が
  原文で同じ記号だから）。この対応が正しいことは、下の `firstSign_nextSite`
  （`firstSign η (nextSite m) = lastSign η m`）が保証する。
* 原文は「`k_2 ≥ 2` の項」と「`k_2 = 1` の項」に分けて 2 通りの場合分けをしているが、
  Lean では `M ∣ (k_1 - k_2 + 1)` を満たす `k_2` が `nextSite k_1` に**一意に**決まること
  （`dvd_succ_sub_iff_eq_nextSite`）にまとめてある。原文の場合分けは、この一意性を
  `k_2 = k_1 + 1` と `k_1 = M, k_2 = 1` に手で分けたものにほかならない。
-/
import Ising2D.Part004.Definition010_H1H2V1V2

namespace Ising2D

variable {M : ℕ}

/-! ## 位相因子・`hat` の合同による一致（`M` 周期性の一般形）

`Claim012_HatPeriodicity.lean` の `hatZ_periodic` / `hatY_periodic` は「`+M` で不変」の形。
以下の計算では「添字が `M` を法として合同なら等しい」という形が要るので、定義から直接出す。 -/

/-- `M ∣ a - b` なら位相因子は等しい。 -/
theorem expPhase_congr (hM : M ≠ 0) {a b : ℤ} (h : (M : ℤ) ∣ a - b) :
    expPhase M a = expPhase M b := by
  have hab : a = b + (a - b) := by ring
  rw [hab, expPhase_add, (expPhase_eq_one_iff hM (a - b)).2 h, mul_one]

/-- **`hat(Z)` の合同不変性**: `M ∣ μ - ν` なら `hat(Z)_μ^{(η)} = hat(Z)_ν^{(η)}`。 -/
theorem hatZ_congr (hM : M ≠ 0) (η : ℂ) {μ ν : ℤ} (h : (M : ℤ) ∣ μ - ν) :
    hatZ M η μ = hatZ M η ν := by
  rw [hatZ, hatZ]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [expPhase_congr hM (a := (((j : ℕ) : ℤ) + 1) * μ) (b := (((j : ℕ) : ℤ) + 1) * ν)
    (by rw [← mul_sub]; exact Dvd.dvd.mul_left h _)]

/-- **`hat(Y)` の合同不変性**: `M ∣ μ - ν` なら `hat(Y)_μ = hat(Y)_ν`。 -/
theorem hatY_congr (hM : M ≠ 0) {μ ν : ℤ} (h : (M : ℤ) ∣ μ - ν) :
    hatY M μ = hatY M ν := by
  rw [hatY, hatY]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [expPhase_congr hM (a := (((j : ℕ) : ℤ) + 1) * μ) (b := (((j : ℕ) : ℤ) + 1) * ν)
    (by rw [← mul_sub]; exact Dvd.dvd.mul_left h _)]

/-! ## `δ^M` による添字の決定 -/

theorem nextSite_val (m : Fin M) : ((nextSite m : Fin M) : ℕ) = ((m : ℕ) + 1) % M := rfl

/-- 原文の「`k_1 ≡ k_2 - 1 (mod M)` を満たす `k_2` は一意」の形式化:
`M ∣ (k_1 - k_2 + 1) ⟺ k_2 = nextSite k_1`（`Fin M` の値で述べる）。 -/
theorem dvd_succ_sub_iff_eq_nextSite (k₁ k₂ : Fin M) :
    ((M : ℤ) ∣ (((k₁ : ℕ) : ℤ) - ((k₂ : ℕ) : ℤ) + 1)) ↔ k₂ = nextSite k₁ := by
  have hMpos : 0 < M := k₁.pos
  constructor
  · intro h
    have hlt : ((k₁ : ℕ) + 1) % M < M := Nat.mod_lt _ hMpos
    have hk₂ : (k₂ : ℕ) < M := k₂.isLt
    -- `r := ((k₁ : ℕ) + 1) % M` も `M ∣ (k₁ + 1 - r)` を満たす
    have hr : (M : ℤ) ∣ (((k₁ : ℕ) : ℤ) + 1 - ((((k₁ : ℕ) + 1) % M : ℕ) : ℤ)) := by
      have hnat : M * (((k₁ : ℕ) + 1) / M) + ((k₁ : ℕ) + 1) % M = (k₁ : ℕ) + 1 :=
        Nat.div_add_mod _ _
      have hz : (M : ℤ) * ((((k₁ : ℕ) + 1) / M : ℕ) : ℤ) + ((((k₁ : ℕ) + 1) % M : ℕ) : ℤ)
          = ((k₁ : ℕ) : ℤ) + 1 := by exact_mod_cast hnat
      exact ⟨((((k₁ : ℕ) + 1) / M : ℕ) : ℤ), by linarith⟩
    have hdiff : (M : ℤ) ∣ (((((k₁ : ℕ) + 1) % M : ℕ) : ℤ) - ((k₂ : ℕ) : ℤ)) := by
      have := dvd_sub hr h
      have heq : (((k₁ : ℕ) : ℤ) + 1 - ((((k₁ : ℕ) + 1) % M : ℕ) : ℤ))
          - (((k₁ : ℕ) : ℤ) - ((k₂ : ℕ) : ℤ) + 1)
          = -((((((k₁ : ℕ) + 1) % M : ℕ) : ℤ)) - ((k₂ : ℕ) : ℤ)) := by ring
      rw [heq] at this
      exact (dvd_neg).1 this
    have habs : |(((((k₁ : ℕ) + 1) % M : ℕ) : ℤ)) - ((k₂ : ℕ) : ℤ)| < (M : ℤ) := by
      have h1 : ((((k₁ : ℕ) + 1) % M : ℕ) : ℤ) < (M : ℤ) := by exact_mod_cast hlt
      have h2 : ((k₂ : ℕ) : ℤ) < (M : ℤ) := by exact_mod_cast hk₂
      have h3 : (0 : ℤ) ≤ ((((k₁ : ℕ) + 1) % M : ℕ) : ℤ) := Int.natCast_nonneg _
      have h4 : (0 : ℤ) ≤ ((k₂ : ℕ) : ℤ) := Int.natCast_nonneg _
      rw [abs_lt]; constructor <;> omega
    have := Int.eq_zero_of_abs_lt_dvd hdiff habs
    refine Fin.val_injective ?_
    rw [nextSite_val]
    omega
  · rintro rfl
    have hnat : M * (((k₁ : ℕ) + 1) / M) + ((k₁ : ℕ) + 1) % M = (k₁ : ℕ) + 1 :=
      Nat.div_add_mod _ _
    have hz : (M : ℤ) * ((((k₁ : ℕ) + 1) / M : ℕ) : ℤ) + ((((k₁ : ℕ) + 1) % M : ℕ) : ℤ)
        = ((k₁ : ℕ) : ℤ) + 1 := by exact_mod_cast hnat
    refine ⟨((((k₁ : ℕ) + 1) / M : ℕ) : ℤ), ?_⟩
    rw [nextSite_val]
    linarith

/-- **原文の `(±)` の対応の根拠**: `hat(Z)^{(±)}` の「`j = 1` の項の係数」と
`H_1^{(±)}` の「`m = M` の項の係数」は同じ `η` で一致する:
`firstSign η (nextSite m) = lastSign η m`。 -/
theorem firstSign_nextSite (η : ℂ) (m : Fin M) : firstSign η (nextSite m) = lastSign η m := by
  have hMpos : 0 < M := m.pos
  have h : ((m : ℕ) + 1) % M = 0 ↔ (m : ℕ) + 1 = M := by
    constructor
    · intro h0
      exact Nat.le_antisymm m.isLt (Nat.le_of_dvd (Nat.succ_pos _) (Nat.dvd_of_mod_eq_zero h0))
    · intro h0; rw [h0, Nat.mod_self]
  rw [firstSign, lastSign, nextSite_val]
  by_cases hc : (m : ℕ) + 1 = M
  · rw [if_pos (h.2 hc), if_pos hc]
  · rw [if_neg (fun hh => hc (h.1 hh)), if_neg hc]

/-! ## `<H1_H2_via_hatZ_hatY>` 本体 -/

/-- **原文第 1 式の形式化**:
`H_1^{(±)} = (1/M) ∑_{j=1}^{M} hat(Y)_j hat(Z)^{(±)}_{-j} exp(-√-1 · 2πj/M)`。 -/
theorem H1_eq_hat_sum (hM : M ≠ 0) (η : ℂ) :
    H1 M η = ((M : ℂ))⁻¹ • ∑ j : Fin M,
      expPhase M (((j : ℕ) : ℤ) + 1) •
        (hatY M (((j : ℕ) : ℤ) + 1) * hatZ M η (-(((j : ℕ) : ℤ) + 1))) := by
  have hMC : (M : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr hM
  -- (1) 各 `j` の項を `Y_{k₁} Z_{k₂}` の二重和へ展開する（原文の 2〜5 行目）
  have hterm : ∀ j : Fin M,
      expPhase M (((j : ℕ) : ℤ) + 1) •
          (hatY M (((j : ℕ) : ℤ) + 1) * hatZ M η (-(((j : ℕ) : ℤ) + 1)))
        = ∑ k₁ : Fin M, ∑ k₂ : Fin M,
            (firstSign η k₂ *
              expPhase M ((((j : ℕ) : ℤ) + 1) *
                (((k₁ : ℕ) : ℤ) - ((k₂ : ℕ) : ℤ) + 1))) • (Y k₁ * Z k₂) := by
    intro j
    rw [hatY, hatZ, sum_smul_mul_sum_smul, Finset.smul_sum]
    refine Finset.sum_congr rfl fun k₁ _ => ?_
    rw [Finset.smul_sum]
    refine Finset.sum_congr rfl fun k₂ _ => ?_
    rw [smul_smul]
    congr 1
    have hcomm : expPhase M (((j : ℕ) : ℤ) + 1) *
        (expPhase M ((((k₁ : ℕ) : ℤ) + 1) * (((j : ℕ) : ℤ) + 1)) *
          (firstSign η k₂ * expPhase M ((((k₂ : ℕ) : ℤ) + 1) * (-(((j : ℕ) : ℤ) + 1)))))
        = firstSign η k₂ *
          (expPhase M (((j : ℕ) : ℤ) + 1) *
            expPhase M ((((k₁ : ℕ) : ℤ) + 1) * (((j : ℕ) : ℤ) + 1)) *
            expPhase M ((((k₂ : ℕ) : ℤ) + 1) * (-(((j : ℕ) : ℤ) + 1)))) := by ring
    rw [hcomm, ← expPhase_add, ← expPhase_add]
    congr 2
    ring
  -- (2) 和の順序を入れ替え、`j` の和を最内へ（原文の「exp をまとめる」以降）
  have hinner : ∀ k₁ k₂ : Fin M,
      ∑ j : Fin M,
          (firstSign η k₂ *
            expPhase M ((((j : ℕ) : ℤ) + 1) *
              (((k₁ : ℕ) : ℤ) - ((k₂ : ℕ) : ℤ) + 1))) • (Y k₁ * Z k₂)
        = (firstSign η k₂ *
            ((M : ℂ) * deltaMod M (((k₁ : ℕ) : ℤ) - ((k₂ : ℕ) : ℤ) + 1) 0)) • (Y k₁ * Z k₂) := by
    intro k₁ k₂
    rw [← Finset.sum_smul, ← Finset.mul_sum, expPhase_sum hM]
  -- (3) `δ` により `k₂ = nextSite k₁` の項だけが残る（原文の場合分けに対応）
  have houter : ∀ k₁ : Fin M,
      ∑ k₂ : Fin M,
          (firstSign η k₂ *
            ((M : ℂ) * deltaMod M (((k₁ : ℕ) : ℤ) - ((k₂ : ℕ) : ℤ) + 1) 0)) • (Y k₁ * Z k₂)
        = (M : ℂ) • (lastSign η k₁ • (Y k₁ * Z (nextSite k₁))) := by
    intro k₁
    rw [Finset.sum_eq_single_of_mem (nextSite k₁) (Finset.mem_univ _)]
    · rw [deltaMod, sub_zero,
        if_pos ((dvd_succ_sub_iff_eq_nextSite k₁ (nextSite k₁)).2 rfl),
        firstSign_nextSite, smul_smul]
      congr 1
      ring
    · intro k₂ _ hk₂
      rw [deltaMod, sub_zero,
        if_neg (fun hd => hk₂ ((dvd_succ_sub_iff_eq_nextSite k₁ k₂).1 hd))]
      simp
  symm
  rw [Finset.sum_congr rfl fun j _ => hterm j, Finset.sum_comm,
    Finset.sum_congr rfl fun k₁ (_ : k₁ ∈ Finset.univ) => Finset.sum_comm,
    Finset.sum_congr rfl fun k₁ (_ : k₁ ∈ Finset.univ) =>
      (Finset.sum_congr rfl fun k₂ (_ : k₂ ∈ Finset.univ) => hinner k₁ k₂).trans (houter k₁),
    ← Finset.smul_sum, smul_smul, inv_mul_cancel₀ hMC, one_smul, H1]

/-- **原文第 2 式の形式化**:
`H_2 = (1/M) ∑_{j=1}^{M} hat(Z)^{(-)}_{-j} hat(Y)_j`。 -/
theorem H2_eq_hat_sum (hM : M ≠ 0) :
    H2 M = ((M : ℂ))⁻¹ • ∑ j : Fin M,
      (hatZ M 1 (-(((j : ℕ) : ℤ) + 1)) * hatY M (((j : ℕ) : ℤ) + 1)) := by
  have hMC : (M : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr hM
  have hterm : ∀ j : Fin M,
      hatZ M 1 (-(((j : ℕ) : ℤ) + 1)) * hatY M (((j : ℕ) : ℤ) + 1)
        = ∑ k₁ : Fin M, ∑ k₂ : Fin M,
            (expPhase M ((((j : ℕ) : ℤ) + 1) *
              (((k₂ : ℕ) : ℤ) - ((k₁ : ℕ) : ℤ)))) • (Z k₁ * Y k₂) := by
    intro j
    rw [hatZ, hatY, sum_smul_mul_sum_smul]
    refine Finset.sum_congr rfl fun k₁ _ => ?_
    refine Finset.sum_congr rfl fun k₂ _ => ?_
    congr 1
    rw [firstSign_one, one_mul, ← expPhase_add]
    congr 1
    ring
  have hinner : ∀ k₁ k₂ : Fin M,
      ∑ j : Fin M,
          (expPhase M ((((j : ℕ) : ℤ) + 1) *
            (((k₂ : ℕ) : ℤ) - ((k₁ : ℕ) : ℤ)))) • (Z k₁ * Y k₂)
        = ((M : ℂ) * deltaMod M (((k₂ : ℕ) : ℤ) - ((k₁ : ℕ) : ℤ)) 0) • (Z k₁ * Y k₂) := by
    intro k₁ k₂
    rw [← Finset.sum_smul, expPhase_sum hM]
  have houter : ∀ k₁ : Fin M,
      ∑ k₂ : Fin M,
          ((M : ℂ) * deltaMod M (((k₂ : ℕ) : ℤ) - ((k₁ : ℕ) : ℤ)) 0) • (Z k₁ * Y k₂)
        = (M : ℂ) • (Z k₁ * Y k₁) := by
    intro k₁
    rw [Finset.sum_eq_single_of_mem k₁ (Finset.mem_univ _)]
    · rw [deltaMod, sub_zero, if_pos ((dvd_sub_iff_eq k₁ k₁).2 rfl), mul_one]
    · intro k₂ _ hk₂
      rw [deltaMod, sub_zero, if_neg (fun hd => hk₂ ((dvd_sub_iff_eq k₂ k₁).1 hd)), mul_zero,
        zero_smul]
  symm
  rw [Finset.sum_congr rfl fun j _ => hterm j, Finset.sum_comm,
    Finset.sum_congr rfl fun k₁ (_ : k₁ ∈ Finset.univ) => Finset.sum_comm,
    Finset.sum_congr rfl fun k₁ (_ : k₁ ∈ Finset.univ) =>
      (Finset.sum_congr rfl fun k₂ (_ : k₂ ∈ Finset.univ) => hinner k₁ k₂).trans (houter k₁),
    ← Finset.smul_sum, smul_smul, inv_mul_cancel₀ hMC, one_smul, H2]

/-- 原文の `(-)` 記法（`hat(Z)^{(-)}`）で述べた第 2 式。 -/
theorem H2_eq_hatZMinus_sum (hM : M ≠ 0) :
    H2 M = ((M : ℂ))⁻¹ • ∑ j : Fin M,
      (hatZMinus M (-(((j : ℕ) : ℤ) + 1)) * hatY M (((j : ℕ) : ℤ) + 1)) :=
  H2_eq_hat_sum hM

end Ising2D
