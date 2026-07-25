/-
# `hat(Z)` と `hat(Y)` の反交換関係

対応する人手証明:
`parts/007_hatZとhatYの反交換関係/000_claim_hatZ同士_hatZとhatY_hatY同士の反交換関係.typ`
(`<anticommutator_of_hat_Z_and_hat_Y>`)

原文の主張（複号同順）:

  1. `[hat(Z)_μ^{(±)}, hat(Z)_ν^{(±)}]₊ = 2M δ^M_{μ+ν,0} I`
  2. `[hat(Z)_μ^{(±)}, hat(Z)_ν^{(∓)}]₊ = 2M δ^M_{μ+ν,0} I + (-2 exp(-√-1·2π(μ+ν)/M) · 2 I)`
  3. `[hat(Z)_μ^{(±)}, hat(Y)_ν]₊ = 0`
  4. `[hat(Y)_μ, hat(Y)_ν]₊ = 2M δ^M_{μ+ν,0} I`

原文は 1. と 2. の二重和展開を全ステップ書き下し、3. と 4. は「同様」として省略している。
Lean では 4 つとも証明する。

## 証明の構造（原文の計算をどう整理したか）

原文の計算は次の 3 段に分かれる。

1. 反交換子の中の 2 つの線型結合を二重和へ展開する
   → `Ising2D.acomm_sum_smul`（`Ising2D/Part000/Claim046_...`）
2. `[Z_j, Z_k]₊ = 2 I δ^M_{(j,k)}`（`<anticommutator_of_Z_and_Y>`）で `j = k` の項だけ残す
   → `acomm_sum_smul_clifford`（本ファイル）
3. 残った `∑_{j=1}^M exp(-√-1·2π j(μ+ν)/M) = M δ^M_{μ+ν,0}` を使う
   → `Ising2D.expPhase_sum`（`<exp_sum>`、`Ising2D/Part004/Claim008_ExpSum.lean`）

符号 `(±)` は `hat(Z)` の定義（`Ising2D/Part004/Definition009_HatZHatY.lean`）と同じく
引数 `η : ℂ`（原文の `∓1`、`j = 1` の項の係数）で表す。本質的に効くのは `η^2 = 1` だけで、
1. は「同じ `η`」、2. は「`η` と `-η`」の場合にあたる。
-/
import Ising2D.Part004.Claim012_HatPeriodicity

namespace Ising2D

variable {M : ℕ}

/-! ## 補助: Clifford 関係を満たす族の線型結合どうしの反交換子 -/

section Clifford

variable {A : Type*} [Ring A] [Algebra ℂ A]

/-- `[x_a, y_b]₊ = 2 δ_{ab} I` を満たす族の線型結合どうしの反交換子
（原文の「`δ` により `j = k` の項だけ残る」の行にあたる）。 -/
theorem acomm_sum_smul_clifford {ι : Type*} [Fintype ι] [DecidableEq ι]
    (c d : ι → ℂ) (x y : ι → A)
    (h : ∀ a b, acomm (x a) (y b) = (if a = b then (2 : ℂ) else 0) • (1 : A)) :
    acomm (∑ i, c i • x i) (∑ j, d j • y j) = (∑ i, c i * d i * 2) • (1 : A) := by
  classical
  rw [acomm_sum_smul, Finset.sum_smul]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.sum_eq_single_of_mem i (Finset.mem_univ i)]
  · rw [h, if_pos rfl, smul_smul]
  · intro j _ hji
    rw [h, if_neg (Ne.symm hji), zero_smul, smul_zero]

/-- 各成分どうしが反交換する（`[x_a, y_b]₊ = 0`）族の線型結合は反交換する。 -/
theorem acomm_sum_smul_zero {ι κ : Type*} [Fintype ι] [Fintype κ]
    (c : ι → ℂ) (d : κ → ℂ) (x : ι → A) (y : κ → A)
    (h : ∀ a b, acomm (x a) (y b) = 0) :
    acomm (∑ i, c i • x i) (∑ j, d j • y j) = 0 := by
  rw [acomm_sum_smul]
  exact Finset.sum_eq_zero fun i _ =>
    Finset.sum_eq_zero fun j _ => by rw [h, smul_zero]

end Clifford

/-! ## `Z, Y` の反交換関係を Clifford 形に書き直す -/

/-- `[Z_μ, Z_ν]₊ = 2 δ_{μν} I`（`anticomm_Z_Z` の言い換え）。 -/
theorem acomm_Z_Z_clifford (μ ν : Fin M) :
    acomm (Z μ) (Z ν) = (if μ = ν then (2 : ℂ) else 0) • (1 : TensorPow M) := by
  rw [anticomm_Z_Z, deltaM]
  by_cases h : μ = ν
  · rw [if_pos h, if_pos h, mul_one]
  · rw [if_neg h, if_neg h, mul_zero]

/-- `[Y_μ, Y_ν]₊ = 2 δ_{μν} I`（`anticomm_Y_Y` の言い換え）。 -/
theorem acomm_Y_Y_clifford (μ ν : Fin M) :
    acomm (Y μ) (Y ν) = (if μ = ν then (2 : ℂ) else 0) • (1 : TensorPow M) := by
  rw [anticomm_Y_Y, deltaM]
  by_cases h : μ = ν
  · rw [if_pos h, if_pos h, mul_one]
  · rw [if_neg h, if_neg h, mul_zero]

/-! ## 位相因子の積 -/

/-- 位相因子は掛けると添字が足される（原文の「exp をまとめる」の行）。 -/
theorem expPhase_site_mul (j : Fin M) (μ ν : ℤ) :
    expPhase M ((((j : ℕ) : ℤ) + 1) * μ) * expPhase M ((((j : ℕ) : ℤ) + 1) * ν)
      = expPhase M ((((j : ℕ) : ℤ) + 1) * (μ + ν)) := by
  rw [← expPhase_add]
  congr 1
  ring

/-! ## 原文の 4 つの反交換関係 -/

/-- **原文 1 の形式化**: `[hat(Z)_μ^{(±)}, hat(Z)_ν^{(±)}]₊ = 2M δ^M_{μ+ν,0} I`（複号同順）。

`η` は `j = 1` の項の係数（原文の `∓1`）で、必要なのは `η^2 = 1` だけである。 -/
theorem acomm_hatZ_hatZ_same (hM : M ≠ 0) {η : ℂ} (hη : η * η = 1) (μ ν : ℤ) :
    acomm (hatZ M η μ) (hatZ M η ν)
      = (2 * (M : ℂ) * deltaMod M (μ + ν) 0) • (1 : TensorPow M) := by
  rw [hatZ, hatZ, acomm_sum_smul_clifford _ _ _ _ acomm_Z_Z_clifford]
  congr 1
  have hterm : ∀ j : Fin M,
      (firstSign η j * expPhase M ((((j : ℕ) : ℤ) + 1) * μ)) *
          (firstSign η j * expPhase M ((((j : ℕ) : ℤ) + 1) * ν)) * 2
        = 2 * expPhase M ((((j : ℕ) : ℤ) + 1) * (μ + ν)) := by
    intro j
    have hs : firstSign η j * firstSign η j = 1 := by
      rw [firstSign]
      split
      · exact hη
      · rw [one_mul]
    calc (firstSign η j * expPhase M ((((j : ℕ) : ℤ) + 1) * μ)) *
          (firstSign η j * expPhase M ((((j : ℕ) : ℤ) + 1) * ν)) * 2
        = (firstSign η j * firstSign η j) *
            (expPhase M ((((j : ℕ) : ℤ) + 1) * μ) *
              expPhase M ((((j : ℕ) : ℤ) + 1) * ν)) * 2 := by ring
      _ = 1 * expPhase M ((((j : ℕ) : ℤ) + 1) * (μ + ν)) * 2 := by
            rw [hs, expPhase_site_mul]
      _ = 2 * expPhase M ((((j : ℕ) : ℤ) + 1) * (μ + ν)) := by ring
  rw [Finset.sum_congr rfl fun j _ => hterm j, ← Finset.mul_sum, expPhase_sum hM]
  ring

/-- **原文 2 の形式化**: `[hat(Z)_μ^{(±)}, hat(Z)_ν^{(∓)}]₊`。

原文は `2M δ^M_{μ+ν,0} I + (-2 exp(-√-1·2π(μ+ν)/M) · 2 I)` と書いている。
`I` の係数をまとめれば `2M δ^M_{μ+ν,0} - 4 exp(-√-1·2π(μ+ν)/M)` であり、下記はその形。
`j = 1` の項の符号積だけが `-1` になり（他は `+1`）、その分 `j = 1` の項を 2 回引く、
という原文の説明そのものである。 -/
theorem acomm_hatZ_hatZ_opp (hM : M ≠ 0) {η : ℂ} (hη : η * η = 1) (μ ν : ℤ) :
    acomm (hatZ M η μ) (hatZ M (-η) ν)
      = (2 * (M : ℂ) * deltaMod M (μ + ν) 0 - 4 * expPhase M (μ + ν)) • (1 : TensorPow M) := by
  set z : Fin M := ⟨0, Nat.pos_of_ne_zero hM⟩ with hz
  have hzval : (z : ℕ) = 0 := rfl
  rw [hatZ, hatZ, acomm_sum_smul_clifford _ _ _ _ acomm_Z_Z_clifford]
  congr 1
  have hterm : ∀ j : Fin M,
      (firstSign η j * expPhase M ((((j : ℕ) : ℤ) + 1) * μ)) *
          (firstSign (-η) j * expPhase M ((((j : ℕ) : ℤ) + 1) * ν)) * 2
        = 2 * expPhase M ((((j : ℕ) : ℤ) + 1) * (μ + ν))
          + (if (j : ℕ) = 0 then -(4 * expPhase M (μ + ν)) else 0) := by
    intro j
    by_cases hj : (j : ℕ) = 0
    · have hphase : (((j : ℕ) : ℤ) + 1) = 1 := by rw [hj]; norm_num
      rw [firstSign_of_val_eq_zero hj, firstSign_of_val_eq_zero hj, if_pos hj, hphase,
        one_mul, one_mul, one_mul]
      have : η * expPhase M μ * (-η * expPhase M ν) * 2
          = -(η * η) * (expPhase M μ * expPhase M ν) * 2 := by ring
      rw [this, hη]
      have hmul : expPhase M μ * expPhase M ν = expPhase M (μ + ν) := (expPhase_add M μ ν).symm
      rw [hmul]
      ring
    · rw [firstSign_of_val_ne_zero hj, firstSign_of_val_ne_zero hj, if_neg hj, one_mul, one_mul,
        add_zero]
      calc expPhase M ((((j : ℕ) : ℤ) + 1) * μ) * expPhase M ((((j : ℕ) : ℤ) + 1) * ν) * 2
          = (expPhase M ((((j : ℕ) : ℤ) + 1) * μ) *
              expPhase M ((((j : ℕ) : ℤ) + 1) * ν)) * 2 := by ring
        _ = 2 * expPhase M ((((j : ℕ) : ℤ) + 1) * (μ + ν)) := by
              rw [expPhase_site_mul]; ring
  rw [Finset.sum_congr rfl fun j _ => hterm j, Finset.sum_add_distrib, ← Finset.mul_sum,
    expPhase_sum hM]
  have hsingle : ∑ j : Fin M, (if (j : ℕ) = 0 then -(4 * expPhase M (μ + ν)) else 0)
      = -(4 * expPhase M (μ + ν)) := by
    rw [Finset.sum_eq_single_of_mem z (Finset.mem_univ z)]
    · rw [if_pos hzval]
    · intro j _ hj
      rw [if_neg (fun h => hj (Fin.val_injective (by rw [h, hzval])))]
  rw [hsingle]
  ring

/-- **原文 3 の形式化**: `[hat(Z)_μ^{(±)}, hat(Y)_ν]₊ = 0`（原文は「同様」として省略）。

`[Z_j, Y_k]₊ = 0` がすべての `j, k` で成り立つ（`anticomm_Z_Y`）ので、
係数によらず二重和の各項が消える。 -/
theorem acomm_hatZ_hatY (η : ℂ) (μ ν : ℤ) : acomm (hatZ M η μ) (hatY M ν) = 0 := by
  rw [hatZ, hatY]
  exact acomm_sum_smul_zero _ _ _ _ anticomm_Z_Y

/-- `[hat(Y)_μ, hat(Z)_ν^{(±)}]₊ = 0`（上の対称版）。 -/
theorem acomm_hatY_hatZ (η : ℂ) (μ ν : ℤ) : acomm (hatY M μ) (hatZ M η ν) = 0 := by
  rw [acomm_comm]
  exact acomm_hatZ_hatY η ν μ

/-- **原文 4 の形式化**: `[hat(Y)_μ, hat(Y)_ν]₊ = 2M δ^M_{μ+ν,0} I`（原文は「同様」として省略）。 -/
theorem acomm_hatY_hatY (hM : M ≠ 0) (μ ν : ℤ) :
    acomm (hatY M μ) (hatY M ν)
      = (2 * (M : ℂ) * deltaMod M (μ + ν) 0) • (1 : TensorPow M) := by
  rw [hatY, hatY, acomm_sum_smul_clifford _ _ _ _ acomm_Y_Y_clifford]
  congr 1
  have hterm : ∀ j : Fin M,
      expPhase M ((((j : ℕ) : ℤ) + 1) * μ) * expPhase M ((((j : ℕ) : ℤ) + 1) * ν) * 2
        = 2 * expPhase M ((((j : ℕ) : ℤ) + 1) * (μ + ν)) := by
    intro j
    rw [expPhase_site_mul]
    ring
  rw [Finset.sum_congr rfl fun j _ => hterm j, ← Finset.mul_sum, expPhase_sum hM]
  ring

/-! ## 原文の `(±)` 記法での言い換え -/

/-- 原文 1 を `hat(Z)^{(+)}` で述べた形。 -/
theorem acomm_hatZPlus_hatZPlus (hM : M ≠ 0) (μ ν : ℤ) :
    acomm (hatZPlus M μ) (hatZPlus M ν)
      = (2 * (M : ℂ) * deltaMod M (μ + ν) 0) • (1 : TensorPow M) :=
  acomm_hatZ_hatZ_same hM (by norm_num) μ ν

/-- 原文 1 を `hat(Z)^{(-)}` で述べた形。 -/
theorem acomm_hatZMinus_hatZMinus (hM : M ≠ 0) (μ ν : ℤ) :
    acomm (hatZMinus M μ) (hatZMinus M ν)
      = (2 * (M : ℂ) * deltaMod M (μ + ν) 0) • (1 : TensorPow M) :=
  acomm_hatZ_hatZ_same hM (by norm_num) μ ν

/-- 原文 2 を `hat(Z)^{(+)}, hat(Z)^{(-)}` で述べた形。 -/
theorem acomm_hatZPlus_hatZMinus (hM : M ≠ 0) (μ ν : ℤ) :
    acomm (hatZPlus M μ) (hatZMinus M ν)
      = (2 * (M : ℂ) * deltaMod M (μ + ν) 0 - 4 * expPhase M (μ + ν)) • (1 : TensorPow M) := by
  have h := acomm_hatZ_hatZ_opp (M := M) hM (η := -1) (by norm_num) μ ν
  rw [neg_neg] at h
  exact h

end Ising2D
