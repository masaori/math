/-
# 符号反転共役 `U`（具体版）

対応する人手証明（`structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`）:
`sign_flip_conjugation`（`eigenvalues_of_V_016_claim_sign_flip_conjugation`）

原文の `U := E F`（`E = ∏_{m 奇数} σ^x_m`, `F = ∏_m σ^z_m`）を、サイトごとの
`2×2` 行列の族としてまとめて `siteProd` に流し込む形で定義する
（Lean の添字は 0 始まりなので、原文の「`m` が奇数」は `(i : ℕ)` が偶数にあたる）。

## 原文との違い（形式化して分かったこと）

人手の本文（`(+)` だけ）の旧版は `S_1^{(±)}` を `K_1 ∑ σ^z_m σ^z_{m+1} ∓ K_1 G` の形に書き換えてから、
`G` の因子の符号を `M` の偶奇で場合分けして数えている。
しかし実際には

  `U Z_m U^{-1} = -Z_m`,  `U Y_m U^{-1} = +Y_m`   （**`m` によらず**）

が成り立ち、ここから `U H_1^{(±)} U^{-1} = -H_1^{(±)}`、`U H_2 U^{-1} = -H_2` が
（`H_1` が `Y_m Z_{m+1}` の、`H_2` が `Z_m Y_m` の和であることから）直ちに従う。
**`M` の偶奇による場合分けも `G` への書き換えも要らない。**
原文の結論は正しいが、経路は本ファイルの方が短い。

人手の本文は `(+)` セクターの `U H_1^{(+)} U^{-1} = -H_1^{(+)}`, `U S_1^{(+)} U^{-1} = -S_1^{(+)}` だけを述べる
（`(−)` セクターは参照用ノート `structured-latex/notes/minus_sector_not_adopted.ts` へ退避済み）。
Lean では境界項の係数を引数 `η` に持たせた一般形 `Uflip_conj_H1` / `Uflip_conj_S1` を補助として残し
（整数運動量の経路の形式化の記録と章 017 が使う）、人手の主張に対応する `(+)` の定理
`Uflip_conj_H1plus` / `Uflip_conj_S1plus` はその `η = -1` の場合として立てる。
-/
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.DefinitionH1H2V1V2

namespace Ising2D

open Matrix

section SignFlip

variable {M : ℕ}

/-! ## `U` とその逆 -/

/-- 原文の `U = E F` のサイト `i` の因子（`(i : ℕ)` が偶数 ⟺ 原文の `m = i+1` が奇数）。 -/
noncomputable def flipFam (M : ℕ) : Fin M → Matrix (Fin 2) (Fin 2) ℂ :=
  fun i => (if Even (i : ℕ) then pauliX else 1) * pauliZ

/-- `flipFam` の各サイトの逆。 -/
noncomputable def flipFamInv (M : ℕ) : Fin M → Matrix (Fin 2) (Fin 2) ℂ :=
  fun i => pauliZ * (if Even (i : ℕ) then pauliX else 1)

/-- **原文の `U = E F`**。 -/
noncomputable def Uflip (M : ℕ) : TensorPow M := siteProd M (flipFam M)

/-- `U^{-1}`。 -/
noncomputable def UflipInv (M : ℕ) : TensorPow M := siteProd M (flipFamInv M)

private theorem flipFam_mul_inv (i : Fin M) : flipFam M i * flipFamInv M i = 1 := by
  unfold flipFam flipFamInv
  by_cases h : Even (i : ℕ) <;> simp only [h, if_pos, if_neg, if_true, if_false] <;>
    · ext a b
      fin_cases a <;> fin_cases b <;>
        simp [pauliX, pauliZ, Matrix.mul_apply, Fin.sum_univ_two, Matrix.one_apply]

private theorem flipFamInv_mul (i : Fin M) : flipFamInv M i * flipFam M i = 1 := by
  unfold flipFam flipFamInv
  by_cases h : Even (i : ℕ) <;> simp only [h, if_pos, if_neg, if_true, if_false] <;>
    · ext a b
      fin_cases a <;> fin_cases b <;>
        simp [pauliX, pauliZ, Matrix.mul_apply, Fin.sum_univ_two, Matrix.one_apply]

/-- **原文 Step 0**: `U` は可逆。 -/
theorem Uflip_mul_inv : Uflip M * UflipInv M = 1 := by
  rw [Uflip, UflipInv, ← siteProd_mul]
  have h : (flipFam M * flipFamInv M) = 1 := by
    funext i; exact flipFam_mul_inv i
  rw [h, siteProd_one]

theorem UflipInv_mul : UflipInv M * Uflip M = 1 := by
  rw [Uflip, UflipInv, ← siteProd_mul]
  have h : (flipFamInv M * flipFam M) = 1 := by
    funext i; exact flipFamInv_mul i
  rw [h, siteProd_one]

/-! ## 共役写像の性質 -/

/-- 共役 `X ↦ U X U^{-1}` は積を保つ（原文 Step 2 の「共役は ℂ 線型で積を保つ」）。 -/
theorem Uflip_conj_mul (A B : TensorPow M) :
    Uflip M * (A * B) * UflipInv M
      = (Uflip M * A * UflipInv M) * (Uflip M * B * UflipInv M) := by
  have h : (Uflip M * A * UflipInv M) * (Uflip M * B * UflipInv M)
      = Uflip M * A * (UflipInv M * Uflip M) * B * UflipInv M := by noncomm_ring
  rw [h, UflipInv_mul]
  noncomm_ring

theorem Uflip_conj_smul (c : ℂ) (A : TensorPow M) :
    Uflip M * (c • A) * UflipInv M = c • (Uflip M * A * UflipInv M) := by
  rw [Matrix.mul_smul, Matrix.smul_mul]

theorem Uflip_conj_sum {ι : Type*} (s : Finset ι) (f : ι → TensorPow M) :
    Uflip M * (∑ i ∈ s, f i) * UflipInv M = ∑ i ∈ s, Uflip M * f i * UflipInv M := by
  rw [Finset.mul_sum, Finset.sum_mul]

/-- サイト局所作用素への共役。 -/
theorem Uflip_conj_siteProd (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) :
    Uflip M * siteProd M x * UflipInv M
      = siteProd M (fun i => flipFam M i * x i * flipFamInv M i) := by
  rw [Uflip, UflipInv, ← siteProd_mul, ← siteProd_mul]
  congr 1
  all_goals funext i
  all_goals simp [Pi.mul_apply]

theorem Uflip_conj_siteOp (k : Fin M) (A : Matrix (Fin 2) (Fin 2) ℂ) :
    Uflip M * siteOp k A * UflipInv M = siteOp k (flipFam M k * A * flipFamInv M k) := by
  rw [siteOp_apply, Uflip_conj_siteProd, siteOp_apply]
  congr 1
  funext i
  by_cases h : i = k
  · subst h; simp
  · simp [h, flipFam_mul_inv i]

/-! ## `σ^x, σ^y, σ^z` への作用（原文 Step 1） -/

private theorem conj_pauliX (i : Fin M) :
    flipFam M i * pauliX * flipFamInv M i = (-1 : ℂ) • pauliX := by
  unfold flipFam flipFamInv
  by_cases h : Even (i : ℕ) <;> simp only [h, if_pos, if_neg, if_true, if_false] <;>
    · ext a b
      fin_cases a <;> fin_cases b <;>
        simp [pauliX, pauliZ, Matrix.mul_apply, Fin.sum_univ_two]

private theorem conj_pauliY (i : Fin M) :
    flipFam M i * pauliY * flipFamInv M i
      = (if Even (i : ℕ) then (1 : ℂ) else -1) • pauliY := by
  unfold flipFam flipFamInv
  by_cases h : Even (i : ℕ) <;> simp only [h, if_pos, if_neg, if_true, if_false] <;>
    · ext a b
      fin_cases a <;> fin_cases b <;>
        simp [pauliX, pauliY, pauliZ, Matrix.mul_apply, Fin.sum_univ_two]

private theorem conj_pauliZ (i : Fin M) :
    flipFam M i * pauliZ * flipFamInv M i
      = (if Even (i : ℕ) then (-1 : ℂ) else 1) • pauliZ := by
  unfold flipFam flipFamInv
  by_cases h : Even (i : ℕ) <;> simp only [h, if_pos, if_neg, if_true, if_false] <;>
    · ext a b
      fin_cases a <;> fin_cases b <;>
        simp [pauliX, pauliZ, Matrix.mul_apply, Fin.sum_univ_two]

theorem Uflip_conj_sigmaX (k : Fin M) :
    Uflip M * sigmaX k * UflipInv M = (-1 : ℂ) • sigmaX k := by
  rw [sigmaX, Uflip_conj_siteOp, conj_pauliX, map_smul]

theorem Uflip_conj_sigmaY (k : Fin M) :
    Uflip M * sigmaY k * UflipInv M = (if Even (k : ℕ) then (1 : ℂ) else -1) • sigmaY k := by
  rw [sigmaY, Uflip_conj_siteOp, conj_pauliY, map_smul]

theorem Uflip_conj_sigmaZ (k : Fin M) :
    Uflip M * sigmaZ k * UflipInv M = (if Even (k : ℕ) then (-1 : ℂ) else 1) • sigmaZ k := by
  rw [sigmaZ, Uflip_conj_siteOp, conj_pauliZ, map_smul]

/-! ## Jordan–Wigner 文字列への作用 -/

theorem Uflip_conj_xString (k : ℕ) (hk : k ≤ M) :
    Uflip M * xString M k * UflipInv M = ((-1 : ℂ) ^ k) • xString M k := by
  induction k with
  | zero => simp [Uflip_mul_inv]
  | succ k ih =>
      have hk' : k < M := by omega
      rw [xString_succ k hk', Uflip_conj_mul, ih (by omega), Uflip_conj_sigmaX]
      rw [smul_mul_assoc, Matrix.mul_smul, smul_smul, ← xString_succ k hk']
      congr 1
      all_goals ring

/-- **原文 Step 1 の帰結**: `U Z_m U^{-1} = -Z_m`（`m` の偶奇によらない）。 -/
theorem Uflip_conj_Z (m : Fin M) : Uflip M * Z m * UflipInv M = -(Z m) := by
  rw [Z_eq_xString_mul, Uflip_conj_mul, Uflip_conj_xString (m : ℕ) (le_of_lt m.isLt),
    Uflip_conj_sigmaZ, smul_mul_assoc, Matrix.mul_smul, smul_smul, ← Z_eq_xString_mul]
  have hsign : ((-1 : ℂ) ^ (m : ℕ)) * (if Even (m : ℕ) then (-1 : ℂ) else 1) = -1 := by
    by_cases h : Even (m : ℕ)
    · rw [if_pos h, h.neg_one_pow, one_mul]
    · rw [if_neg h, (Nat.not_even_iff_odd.1 h).neg_one_pow, mul_one]
  rw [hsign, neg_one_smul]

/-- **原文 Step 1 の帰結**: `U Y_m U^{-1} = +Y_m`（`m` の偶奇によらない）。 -/
theorem Uflip_conj_Y (m : Fin M) : Uflip M * Y m * UflipInv M = Y m := by
  rw [Y_eq_xString_mul, Uflip_conj_mul, Uflip_conj_xString (m : ℕ) (le_of_lt m.isLt),
    Uflip_conj_sigmaY, smul_mul_assoc, Matrix.mul_smul, smul_smul, ← Y_eq_xString_mul]
  have hsign : ((-1 : ℂ) ^ (m : ℕ)) * (if Even (m : ℕ) then (1 : ℂ) else -1) = 1 := by
    by_cases h : Even (m : ℕ)
    · rw [if_pos h, h.neg_one_pow, one_mul]
    · rw [if_neg h, (Nat.not_even_iff_odd.1 h).neg_one_pow]
      norm_num
  rw [hsign, one_smul]

/-! ## `H_1^{(+)}`, `H_2` への作用（人手 Step 3） -/

/-- 補助: 一般形で `U (H1 M η) U^{-1} = -(H1 M η)`。 -/
theorem Uflip_conj_H1 (η : ℂ) : Uflip M * H1 M η * UflipInv M = -(H1 M η) := by
  rw [H1, Uflip_conj_sum, ← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun m _ => ?_
  rw [Uflip_conj_smul, Uflip_conj_mul, Uflip_conj_Y, Uflip_conj_Z]
  rw [Matrix.mul_neg, smul_neg]

/-- **人手本文 `sign_flip_conjugation`（Step 3）**: `U H_2 U^{-1} = -H_2`。 -/
theorem Uflip_conj_H2 : Uflip M * H2 M * UflipInv M = -(H2 M) := by
  rw [H2, Uflip_conj_sum, ← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun m _ => ?_
  rw [Uflip_conj_mul, Uflip_conj_Y, Uflip_conj_Z, Matrix.neg_mul]

/-- 補助: 一般形で `U (i K_1 H1 M η) U^{-1} = -(i K_1 H1 M η)`。 -/
theorem Uflip_conj_S1 (K1 η : ℂ) :
    Uflip M * ((Complex.I * K1) • H1 M η) * UflipInv M = -((Complex.I * K1) • H1 M η) := by
  rw [Uflip_conj_smul, Uflip_conj_H1, smul_neg]

/-- **人手本文 `sign_flip_conjugation`**: `U S_2 U^{-1} = -S_2`（`S_2 = i K_2^* H_2`）。 -/
theorem Uflip_conj_S2 (K2star : ℂ) :
    Uflip M * ((Complex.I * K2star) • H2 M) * UflipInv M
      = -((Complex.I * K2star) • H2 M) := by
  rw [Uflip_conj_smul, Uflip_conj_H2, smul_neg]

/-- **人手本文 `sign_flip_conjugation`（Step 3）**: `U H_1^{(+)} U^{-1} = -H_1^{(+)}`。 -/
theorem Uflip_conj_H1plus : Uflip M * H1plus M * UflipInv M = -(H1plus M) :=
  Uflip_conj_H1 (-1)

/-- **人手本文 `sign_flip_conjugation`（Step 4）**: `U S_1^{(+)} U^{-1} = -S_1^{(+)}`
（`S_1^{(+)} = i K_1 H_1^{(+)}`）。 -/
theorem Uflip_conj_S1plus (K1 : ℂ) :
    Uflip M * ((Complex.I * K1) • H1plus M) * UflipInv M = -((Complex.I * K1) • H1plus M) :=
  Uflip_conj_S1 K1 (-1)

/-! ## 指数関数への作用（人手本文 `constant_c_value_even_sector` Step 2） -/

/-
人手 `constant_c_value_even_sector` Step 2 の 3 段（`Uflip_conj_pow`・`Uflip_conj_expPartialSum`・`Uflip_conj_matExp`）は、
必要十分版 `NecSuf/ConjugationOfExpSeries.lean` の `NecSuf.conj_pow_of_inv`・`NecSuf.conj_partialSum_of_inv`・
`NecSuf.conj_series_limit_of_inv` と同じ手順であり、具体版をその特殊化として導いたものは
`ClaimSignFlipConjugationFromNecSuf.lean` にある。
-/

/-- 人手本文 `constant_c_value_even_sector` Step 2 の `U S^k U^{-1} = (U S U^{-1})^k`
（`k` についての帰納法。`k = 0` は `UU^{-1} = I`、帰納段階は `U^{-1}U = I`（`Uflip_conj_mul`））。
必要十分版は `NecSuf.conj_pow_of_inv`。 -/
theorem Uflip_conj_pow (S : TensorPow M) (k : ℕ) :
    Uflip M * S ^ k * UflipInv M = (Uflip M * S * UflipInv M) ^ k := by
  induction k with
  | zero =>
    calc Uflip M * S ^ 0 * UflipInv M
        = Uflip M * UflipInv M := by rw [pow_zero, mul_one]
      _ = 1 := Uflip_mul_inv
      _ = (Uflip M * S * UflipInv M) ^ 0 := (pow_zero _).symm
  | succ k ih =>
    calc Uflip M * S ^ (k + 1) * UflipInv M
        = Uflip M * (S ^ k * S) * UflipInv M := by rw [pow_succ]
      _ = (Uflip M * S ^ k * UflipInv M) * (Uflip M * S * UflipInv M) := Uflip_conj_mul _ _
      _ = (Uflip M * S * UflipInv M) ^ k * (Uflip M * S * UflipInv M) := by rw [ih]
      _ = (Uflip M * S * UflipInv M) ^ (k + 1) := (pow_succ _ _).symm

/-- 人手本文 `constant_c_value_even_sector` Step 2 の「共役は行列の積・和・スカラー倍を保ち」を
`def_exp` の部分和 `∑_{k<n} (k!)^{-1} S^k` に当てたもの（和を保つのは分配法則 `Uflip_conj_sum`）。
必要十分版は `NecSuf.conj_partialSum_of_inv`。 -/
theorem Uflip_conj_expPartialSum (S : TensorPow M) (n : ℕ) :
    Uflip M * (∑ k ∈ Finset.range n, ((k.factorial : ℂ))⁻¹ • S ^ k) * UflipInv M
      = ∑ k ∈ Finset.range n, ((k.factorial : ℂ))⁻¹ • (Uflip M * S * UflipInv M) ^ k := by
  calc Uflip M * (∑ k ∈ Finset.range n, ((k.factorial : ℂ))⁻¹ • S ^ k) * UflipInv M
      = ∑ k ∈ Finset.range n, Uflip M * (((k.factorial : ℂ))⁻¹ • S ^ k) * UflipInv M :=
        Uflip_conj_sum _ _
    _ = ∑ k ∈ Finset.range n, ((k.factorial : ℂ))⁻¹ • (Uflip M * S ^ k * UflipInv M) := by
        simp only [Uflip_conj_smul]
    _ = ∑ k ∈ Finset.range n, ((k.factorial : ℂ))⁻¹ • (Uflip M * S * UflipInv M) ^ k := by
        simp only [Uflip_conj_pow]

/-- **人手本文 `constant_c_value_even_sector` Step 2** の `U exp(S) U^{-1} = exp(U S U^{-1})`。

人手どおり、`def_exp`（`matExp_hasSum`）の部分和 `s_n(S) := ∑_{k<n} (k!)^{-1} S^k` について
1. `U s_n(S) U^{-1} = s_n(USU^{-1})`（`Uflip_conj_expPartialSum`）、
2. `‖UXU^{-1} - UWU^{-1}‖ = ‖U(X-W)U^{-1}‖ ≤ ‖U‖‖U^{-1}‖‖X-W‖`（`matrix_norm_submultiplicativity`）から
   `s_n(S) → exp(S)` のとき `U s_n(S) U^{-1} → U exp(S) U^{-1}`、
3. `s_n(USU^{-1}) → exp(USU^{-1})` と極限の一意性（`def_exp` が引く `matrix_norm_triangle_inequality` (4)）
の順に示す。ノルムは mathlib の Frobenius ノルム（成分の絶対値の二乗和の `1/2` 乗）で、
`def_matrix_norm` の行列ノルム（二乗和の平方根）と値が一致する。劣乗法性 `Matrix.frobenius_norm_mul` は、
値が一致するこのノルムでの人手 `matrix_norm_submultiplicativity` と同じ主張である。
必要十分版は `NecSuf.conj_series_limit_of_inv`（連続性を仮定として受け取る）。 -/
theorem Uflip_conj_matExp (S : TensorPow M) :
    Uflip M * matExp S * UflipInv M = matExp (Uflip M * S * UflipInv M) := by
  letI : NormedAddCommGroup (TensorPow M) := Matrix.frobeniusNormedAddCommGroup
  -- 2 の評価 `‖UXU^{-1} - UWU^{-1}‖ ≤ ‖U‖‖U^{-1}‖‖X-W‖`
  have hle : ∀ X W : TensorPow M,
      ‖Uflip M * X * UflipInv M - Uflip M * W * UflipInv M‖
        ≤ ‖Uflip M‖ * ‖UflipInv M‖ * ‖X - W‖ := by
    intro X W
    calc ‖Uflip M * X * UflipInv M - Uflip M * W * UflipInv M‖
        = ‖Uflip M * (X - W) * UflipInv M‖ := by rw [mul_sub, sub_mul]
      _ ≤ ‖Uflip M * (X - W)‖ * ‖UflipInv M‖ := Matrix.frobenius_norm_mul _ _
      _ ≤ ‖Uflip M‖ * ‖X - W‖ * ‖UflipInv M‖ := by
          gcongr
          exact Matrix.frobenius_norm_mul _ _
      _ = ‖Uflip M‖ * ‖UflipInv M‖ * ‖X - W‖ := by ring
  -- `def_exp`: 部分和 `s_n(S) → exp(S)`
  have hS : Filter.Tendsto (fun n => ∑ k ∈ Finset.range n, ((k.factorial : ℂ))⁻¹ • S ^ k)
      Filter.atTop (nhds (matExp S)) := (matExp_hasSum S).tendsto_sum_nat
  -- 2: `U s_n(S) U^{-1} → U exp(S) U^{-1}`
  have hconj : Filter.Tendsto
      (fun n => Uflip M * (∑ k ∈ Finset.range n, ((k.factorial : ℂ))⁻¹ • S ^ k) * UflipInv M)
      Filter.atTop (nhds (Uflip M * matExp S * UflipInv M)) := by
    have hS0 := tendsto_iff_norm_sub_tendsto_zero.1 hS
    refine tendsto_iff_norm_sub_tendsto_zero.2 ?_
    have h0 : Filter.Tendsto
        (fun n => ‖Uflip M‖ * ‖UflipInv M‖
          * ‖(∑ k ∈ Finset.range n, ((k.factorial : ℂ))⁻¹ • S ^ k) - matExp S‖)
        Filter.atTop (nhds 0) := by
      simpa using hS0.const_mul (‖Uflip M‖ * ‖UflipInv M‖)
    exact squeeze_zero (fun _ => norm_nonneg _) (fun n => hle _ _) h0
  -- 1 で `U s_n(S) U^{-1}` を `s_n(USU^{-1})` に書き換える
  have hconj' : Filter.Tendsto
      (fun n => ∑ k ∈ Finset.range n, ((k.factorial : ℂ))⁻¹ • (Uflip M * S * UflipInv M) ^ k)
      Filter.atTop (nhds (Uflip M * matExp S * UflipInv M)) := by
    simpa only [Uflip_conj_expPartialSum] using hconj
  -- 3: `s_n(USU^{-1}) → exp(USU^{-1})` と極限の一意性
  have hUSU : Filter.Tendsto
      (fun n => ∑ k ∈ Finset.range n, ((k.factorial : ℂ))⁻¹ • (Uflip M * S * UflipInv M) ^ k)
      Filter.atTop (nhds (matExp (Uflip M * S * UflipInv M))) :=
    (matExp_hasSum (Uflip M * S * UflipInv M)).tendsto_sum_nat
  exact tendsto_nhds_unique hconj' hUSU

end SignFlip

end Ising2D
