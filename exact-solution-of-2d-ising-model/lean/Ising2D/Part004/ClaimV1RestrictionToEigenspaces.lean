/-
# `V_1` の `𝓕^{(+)}` への制限

対応する人手証明（正本は `structured-latex/content/004_transfer_matrix.ts`）:

* `transfer_matrix_006_claim_V1_restriction_to_eigenspaces`
  （ラベル **`V1_restriction_to_eigenspaces`**）
  — `f ∈ 𝓕^{(+)}` なら `V_1 f = V_1^{(+)} f`（`Ising2D.V1_restriction_to_eigenspaces`。
  `V_1` は `def_transfer_matrix` の `V_1`、`V_1^{(+)}` は `def_V1_plus` の `V1plus`）

## 人手の Step との対応

* Step 1（`ε` と `Z_m`, `Y_m` の反交換）→ `Ising2D.epsilon_anticomm_Z` / `epsilon_anticomm_Y`
  （`Part010/Claim010_EpsilonCommutes.lean`）。
* Step 2 の `V_1 = exp(G)` → `Ising2D.V1_in_Z_Y_epsilon`（`Part004/ClaimV1InZYEpsilon.lean`）。
* Step 3〜6 → 下の `mulVec_mem_sector_of_commute_epsilon` から `V1_mulVec_eq_V1pm` まで。

Step 3〜6 の補題は、`ε` の固有値 `η` と境界項の係数 `ηsign` を引数にもつ一般形で書いてある
（`η = 1`, `ηsign = -1` が人手の `𝓕^{(+)}` と `H_1^{(+)}`）。一般形のまま残すのは、人手の本文から
参照用ノート `structured-latex/notes/minus_sector_not_adopted.ts` へ退避した `(−)` セクターの議論
（`Part010/Claim011_SectorReplacement.lean`）の形式化の記録も同じ補題を使うためである。
人手の主張に対応する `V1_restriction_to_eigenspaces` は `η = 1` に特殊化した `(+)` だけの主張である。

人手は「両辺は `𝓕^{(+)}` から `𝓕` への写像として一致する」を `end` の制限の等号で述べる。
Lean では `f ∈ 𝓕^{(+)}`（`ε f = f`）への行列の作用の等号として述べる。
-/
import Ising2D.Part010.Claim010_EpsilonCommutes
import Ising2D.Part004.ClaimV1InZYEpsilon

namespace Ising2D

open Matrix

variable {M : ℕ}

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

/-- 人手本文 Step 3 の `G^{(+)}`（境界符号を一般の `ηsign` にした形）: 境界符号を固定した生成子も
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
固有ベクトルへの作用が一致する（`V_1 = exp(G)` は `V1_in_Z_Y_epsilon` による）。 -/
theorem V1_mulVec_eq_V1pm {K1 : ℝ} {ηsign η : ℂ} (hM : 2 ≤ M)
    (hηsign : ηsign = -η) {f : Conf M → ℂ}
    (hf : epsilon M *ᵥ f = η • f) :
    V1 M K1 *ᵥ f = V1pm M K1 ηsign *ᵥ f := by
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
  rw [V1_in_Z_Y_epsilon hM, V1pm]
  exact hexp

/-- **人手本文 `V1_restriction_to_eigenspaces`**: `M_col ≥ 2` のとき、`f ∈ 𝓕^{(+)}`（`ε f = f`）なら
`V_1 f = V_1^{(+)} f`。Step 3〜6 の一般形を `η = 1`, `ηsign = -1` で使う。 -/
theorem V1_restriction_to_eigenspaces {K1 : ℝ} (hM : 2 ≤ M) {f : Conf M → ℂ}
    (hf : epsilon M *ᵥ f = f) :
    V1 M K1 *ᵥ f = V1plus M K1 *ᵥ f := by
  rw [V1plus_eq_V1pm]
  exact V1_mulVec_eq_V1pm (η := 1) hM rfl (by rw [hf, one_smul])

end Ising2D
