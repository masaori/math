/-
# セクター上での `V_1` の置き換え

対応する人手証明（正本は `structured-latex/content/010_transfer_matrix_bridge.ts`）:

* `bridge_011_claim_sector_replacement`（ラベル **`sector_replacement_of_V1`**）
* `bridge_011a_claim_sector_replacement_pow`（ラベル **`sector_replacement_pow`**）

人手本文の二つの主張（複号同順）は、`sector_replacement_of_V1` の
`V_1 P^{(±)} = V_1^{(±)} P^{(±)}` と、`sector_replacement_pow` の
`(V_1V_2)^n P^{(±)} = (V_1^{(±)}V_2)^n P^{(±)}` である。

## `sector_replacement_of_V1` の根拠となる命題

人手本文は `sector_replacement_of_V1` を **004 章の `V1_restriction_to_eigenspaces`**
（`structured-latex/content/004_transfer_matrix.ts` の
`transfer_matrix_006_claim_V1_restriction_to_eigenspaces`）から導いている。
`V1_restrictsOnSector_of_opposite_sign` は、形式化済みの
`V1pauli_eq_jordanWigner` からこの命題を導く。Lean の符号引数では
`ηsign = -η` であり、偶セクターは `(η, ηsign) = (1, -1)`、
奇セクターは `(-1, 1)` である。

以下のセクター置換定理は `M ≥ 2` を受け取り、
`V1_restrictsOnSector_of_opposite_sign` から制限の事実を直接供給する。
したがって下流へ `RestrictsOnSector` を仮定として渡さない。
`sector_replacement_pow` は `sector_replacement_of_V1` から純代数的に従い、そこは無条件に証明してある
（必要十分版 `Ising2D.NecSuf.pow_mul_proj`）。

## 必要十分版

`Ising2D/NecSuf/Projector.lean`（人手本文のラベル `sector_replacement_pow` に対応）。
冪の置き換えに効いているのは「`P` が冪等」「`P` が `V_1, V_2, V_1^{(±)}` と可換」
「`V_1 P = V_1^{(±)} P`」の 3 点だけで、`P` が射影子の形をしていることすら
使わないことを確認した。
-/
import Ising2D.Part010.Claim010_EpsilonCommutes
import Ising2D.Part010.V1JordanWigner

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- 原文 004 章 `V1_restriction_to_eigenspaces` の主張:
`ε` の固有値 `η` の固有ベクトルの上では `V_1` と `V_1^{(η)}` の作用が一致する。 -/
def RestrictsOnSector (M : ℕ) (K1 ηsign η : ℂ) : Prop :=
  ∀ f : Conf M → ℂ, epsilon M *ᵥ f = η • f →
    V1pauli M K1 *ᵥ f = V1 M K1 ηsign *ᵥ f

/-! ## `V_1` の固有空間への制限

以下は人手本文 `V1_restriction_to_eigenspaces` の Step 3--6 を、同じ順序で
固有ベクトルへの行列作用として具体化する。冪の一致を射影子の一般定理へ委ねない。 -/

/-- 人手本文 Step 3: `εA=Aε` なら、`A` は `η`-固有空間を保つ。 -/
theorem mulVec_mem_sector_of_commute_epsilon {A : TensorPow M} {η : ℂ}
    (hA : Commute (epsilon M) A) {f : Conf M → ℂ}
    (hf : epsilon M *ᵥ f = η • f) :
    epsilon M *ᵥ (A *ᵥ f) = η • (A *ᵥ f) := by
  calc
    epsilon M *ᵥ (A *ᵥ f) = (epsilon M * A) *ᵥ f := by rw [Matrix.mulVec_mulVec]
    _ = (A * epsilon M) *ᵥ f := by rw [hA.eq]
    _ = A *ᵥ (epsilon M *ᵥ f) := by rw [Matrix.mulVec_mulVec]
    _ = A *ᵥ (η • f) := by rw [hf]
    _ = η • (A *ᵥ f) := by rw [Matrix.mulVec_smul]

/-- 人手本文 Step 3 の `W`: 各 `Y_m Z_{m+1}` は `η`-固有空間を保つ。 -/
theorem Y_mul_Z_next_mulVec_mem_sector (m : Fin M) {η : ℂ} {f : Conf M → ℂ}
    (hf : epsilon M *ᵥ f = η • f) :
    epsilon M *ᵥ ((Y m * Z (nextSite m)) *ᵥ f)
      = η • ((Y m * Z (nextSite m)) *ᵥ f) := by
  exact mulVec_mem_sector_of_commute_epsilon
    (commute_of_two_anticomm (epsilon_anticomm_Y m) (epsilon_anticomm_Z (nextSite m))) hf

/-- 人手本文 Step 3 の `G`: Jordan--Wigner 生成子は `η`-固有空間を保つ。 -/
theorem V1JordanWigner_generator_mulVec_mem_sector {K1 η : ℂ} (hM : 2 ≤ M)
    {f : Conf M → ℂ} (hf : epsilon M *ᵥ f = η • f) :
    epsilon M *ᵥ (((Complex.I * K1) • H1JordanWigner M) *ᵥ f)
      = η • (((Complex.I * K1) • H1JordanWigner M) *ᵥ f) := by
  have hgenerator :
      (Complex.I * K1) • H1JordanWigner M
        = K1 • (∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)) := by
    rw [sum_sigmaZ_sigmaZ_eq_jordanWigner hM, smul_smul]
    change (Complex.I * K1) • H1JordanWigner M =
      (K1 * Complex.I) • H1JordanWigner M
    rw [mul_comm Complex.I K1]
  apply mulVec_mem_sector_of_commute_epsilon
  rw [hgenerator]
  exact (epsilon_commute_sum_sigmaZ_sigmaZ M).smul_right K1
  exact hf

/-- 人手本文 Step 3 の `G^{(±)}`: 境界符号を固定した生成子も
`η`-固有空間を保つ。 -/
theorem V1fixed_generator_mulVec_mem_sector {K1 ηsign η : ℂ}
    {f : Conf M → ℂ} (hf : epsilon M *ᵥ f = η • f) :
    epsilon M *ᵥ (((Complex.I * K1) • H1 M ηsign) *ᵥ f)
      = η • (((Complex.I * K1) • H1 M ηsign) *ᵥ f) := by
  exact mulVec_mem_sector_of_commute_epsilon
    ((epsilon_commute_H1 ηsign).smul_right (Complex.I * K1)) hf

/-- 人手本文 Step 4: 固有ベクトル上では Jordan--Wigner 生成子の境界行列 `ε` を
固有値 `η` へ置き換えられる。 -/
theorem H1JordanWigner_mulVec_eq_H1 {ηsign η : ℂ} (hηsign : ηsign = -η)
    {f : Conf M → ℂ} (hf : epsilon M *ᵥ f = η • f) :
    H1JordanWigner M *ᵥ f = H1 M ηsign *ᵥ f := by
  rw [H1JordanWigner, H1, Matrix.sum_mulVec, Matrix.sum_mulVec]
  refine Finset.sum_congr rfl fun m _ => ?_
  by_cases hm : (m : ℕ) + 1 = M
  · rw [if_pos hm, lastSign_of_last hm, hηsign]
    have hWf := Y_mul_Z_next_mulVec_mem_sector m hf
    calc
      (-(epsilon M * Y m * Z (nextSite m))) *ᵥ f
          = -((epsilon M * (Y m * Z (nextSite m))) *ᵥ f) := by
              rw [Matrix.neg_mulVec, mul_assoc]
      _ = -(epsilon M *ᵥ ((Y m * Z (nextSite m)) *ᵥ f)) := by
              rw [Matrix.mulVec_mulVec]
      _ = -(η • ((Y m * Z (nextSite m)) *ᵥ f)) := by rw [hWf]
      _ = (-η) • ((Y m * Z (nextSite m)) *ᵥ f) := by rw [neg_smul]
      _ = ((-η) • (Y m * Z (nextSite m))) *ᵥ f := by rw [Matrix.smul_mulVec]
  · rw [if_neg hm, lastSign_of_not_last hm, one_smul]

/-- 人手本文 Step 4: 二つの指数生成子は `η`-固有ベクトルへの作用が一致する。 -/
theorem V1_generators_mulVec_eq {K1 ηsign η : ℂ} (hηsign : ηsign = -η)
    {f : Conf M → ℂ} (hf : epsilon M *ᵥ f = η • f) :
    ((Complex.I * K1) • H1JordanWigner M) *ᵥ f
      = ((Complex.I * K1) • H1 M ηsign) *ᵥ f := by
  rw [Matrix.smul_mulVec, Matrix.smul_mulVec, H1JordanWigner_mulVec_eq_H1 hηsign hf]

/-- 人手本文 Step 5: 固有空間の不変性と Step 4 を使い、作用する冪の一致を
`n` の帰納法で直接示す。 -/
theorem V1_generators_pow_mulVec_eq {K1 ηsign η : ℂ} (hM : 2 ≤ M)
    (hηsign : ηsign = -η) {f : Conf M → ℂ}
    (hf : epsilon M *ᵥ f = η • f) (n : ℕ) :
    (((Complex.I * K1) • H1JordanWigner M) ^ n) *ᵥ f
      = (((Complex.I * K1) • H1 M ηsign) ^ n) *ᵥ f := by
  let A : TensorPow M := (Complex.I * K1) • H1JordanWigner M
  let B : TensorPow M := (Complex.I * K1) • H1 M ηsign
  change A ^ n *ᵥ f = B ^ n *ᵥ f
  induction n generalizing f with
  | zero => simp
  | succ n ih =>
      have hAf : epsilon M *ᵥ (A *ᵥ f) = η • (A *ᵥ f) :=
        V1JordanWigner_generator_mulVec_mem_sector hM hf
      have hABf : A *ᵥ f = B *ᵥ f := V1_generators_mulVec_eq hηsign hf
      rw [pow_succ, pow_succ, ← Matrix.mulVec_mulVec, ← Matrix.mulVec_mulVec, ih hAf, hABf]

/-- 人手本文 Step 6: Step 5 を各項へ適用すると、指数級数の有限部分和は一致する。 -/
theorem V1_generator_partialSums_mulVec_eq {K1 ηsign η : ℂ} (hM : 2 ≤ M)
    (hηsign : ηsign = -η) {f : Conf M → ℂ}
    (hf : epsilon M *ᵥ f = η • f) (N : ℕ) :
    (∑ n ∈ Finset.range N, ((Nat.factorial n : ℂ))⁻¹ •
        ((((Complex.I * K1) • H1JordanWigner M) ^ n) *ᵥ f))
      = ∑ n ∈ Finset.range N, ((Nat.factorial n : ℂ))⁻¹ •
        ((((Complex.I * K1) • H1 M ηsign) ^ n) *ᵥ f) := by
  apply Finset.sum_congr rfl
  intro n _
  rw [V1_generators_pow_mulVec_eq hM hηsign hf n]

/-! 行列指数関数の級数を使う証明の中だけ、mathlib の行列作用素ノルムを有効にする。 -/
open scoped Matrix.Norms.Operator in
/-- 人手本文 Step 6: 同じ有限部分和列の極限は一意なので、二つの指数行列も
固有ベクトルへの作用が一致する。 -/
theorem V1pauli_mulVec_eq_V1 {K1 ηsign η : ℂ} (hM : 2 ≤ M)
    (hηsign : ηsign = -η) {f : Conf M → ℂ}
    (hf : epsilon M *ᵥ f = η • f) :
    V1pauli M K1 *ᵥ f = V1 M K1 ηsign *ᵥ f := by
  let A : TensorPow M := (Complex.I * K1) • H1JordanWigner M
  let B : TensorPow M := (Complex.I * K1) • H1 M ηsign
  let applyTo : TensorPow M →ₗ[ℂ] (Conf M → ℂ) :=
    { toFun := fun X => X *ᵥ f
      map_add' := fun X Y => by rw [Matrix.add_mulVec]
      map_smul' := fun c X => by
        simpa only [RingHom.id_apply] using Matrix.smul_mulVec c X f }
  let applyToC := applyTo.toContinuousLinearMap
  have hAseries :=
    (NormedSpace.exp_series_hasSum_exp' (𝕂 := ℂ) A).mapL applyToC
  have hBseries :=
    (NormedSpace.exp_series_hasSum_exp' (𝕂 := ℂ) B).mapL applyToC
  have hexp : matExp A *ᵥ f = matExp B *ᵥ f := by
    have hpartialFunctions :
        (fun N : ℕ => ∑ n ∈ Finset.range N,
          applyToC (((Nat.factorial n : ℂ))⁻¹ • A ^ n))
          = (fun N : ℕ => ∑ n ∈ Finset.range N,
            applyToC (((Nat.factorial n : ℂ))⁻¹ • B ^ n)) := by
      funext N
      simpa [applyToC, applyTo, A, B] using
        V1_generator_partialSums_mulVec_eq hM hηsign hf N
    have hexpRaw : applyToC (NormedSpace.exp A) = applyToC (NormedSpace.exp B) := by
      apply tendsto_nhds_unique hAseries.tendsto_sum_nat
      rw [hpartialFunctions]
      exact hBseries.tendsto_sum_nat
    funext i
    exact congrFun hexpRaw i
  rw [V1pauli_eq_jordanWigner hM, V1]
  exact hexp

/-- `M ≥ 2` と `η² = 1` の下で、`ηsign = -η` の符号対応が
原文の `V_1` の固有空間への制限を与える。 -/
theorem V1_restrictsOnSector_of_opposite_sign {K1 η : ℂ} (hM : 2 ≤ M)
    (_hη : η * η = 1) : RestrictsOnSector M K1 (-η) η := by
  intro f hf
  exact V1pauli_mulVec_eq_V1 hM rfl hf

/-- 偶セクター `η = 1` では、境界符号は `ηsign = -1`。 -/
theorem V1_restrictsOnEvenSector (hM : 2 ≤ M) (K1 : ℂ) :
    RestrictsOnSector M K1 (-1) 1 := by
  simpa using V1_restrictsOnSector_of_opposite_sign (M := M) (K1 := K1) (η := (1 : ℂ))
    hM (by norm_num)

/-- 奇セクター `η = -1` では、境界符号は `ηsign = 1`。 -/
theorem V1_restrictsOnOddSector (hM : 2 ≤ M) (K1 : ℂ) :
    RestrictsOnSector M K1 1 (-1) := by
  simpa using V1_restrictsOnSector_of_opposite_sign (M := M) (K1 := K1) (η := (-1 : ℂ))
    hM (by norm_num)

/-- **人手本文 `sector_replacement_of_V1`: `V_1 P^{(±)} = V_1^{(±)} P^{(±)}`。** -/
theorem sector_replacement_of_V1 {K1 η : ℂ} (hM : 2 ≤ M) (hη : η * η = 1) :
    V1pauli M K1 * epsProj M η = V1 M K1 (-η) * epsProj M η := by
  refine Matrix.ext_of_mulVec_single fun i => ?_
  rw [← Matrix.mulVec_mulVec, ← Matrix.mulVec_mulVec]
  exact V1_restrictsOnSector_of_opposite_sign hM hη _ (epsProj_mulVec_mem hη _)

/-- **人手本文 `sector_replacement_pow`: `(V_1V_2)^n P^{(±)} = (V_1^{(±)}V_2)^n P^{(±)}`**
（必要十分版 `Ising2D.NecSuf.pow_mul_proj` の系）。 -/
theorem sector_replacement_pow {K1 η : ℂ} {s2 : ℝ} {K2star : ℂ} (hM : 2 ≤ M)
    (hη : η * η = 1) (n : ℕ) :
    (V1pauli M K1 * V2pauli M s2 K2star) ^ n * epsProj M η
      = (V1 M K1 (-η) * V2pauli M s2 K2star) ^ n * epsProj M η :=
  NecSuf.pow_mul_proj (epsProj_sq hη) (commute_V1pauli_epsProj K1 η)
    (commute_V2pauli_epsProj s2 K2star η) (commute_V1_epsProj K1 (-η) η)
    (sector_replacement_of_V1 hM hη) n

end Ising2D
