/-
# `V_2` のパウリ行列表示

対応する人手証明（正本は `structured-latex/content/004_transfer_matrix.ts`）:

* `transfer_matrix_definition_second_transfer_matrix_prefactor`
  （ラベル **`def_second_transfer_matrix_prefactor`**）:
  `(2 sinh 2K_2)^{M_col/2} := (√(2 sinh 2K_2))^{M_col}`
* `transfer_matrix_claim_second_transfer_matrix_pauli_form`
  （ラベル **`second_transfer_matrix_pauli_form`**）

主張: `def_transfer_matrix` で成分により定めた `V_2`（`Ising2D.V2`、結合定数 `K_2 > 0`）は
`V_2 = (2 sinh 2K_2)^{M_col/2} exp(K_2^* ∑_{m=1}^{M_col} σ^x_m)` と表せる。

`V2PauliForm M s2 K2star` はこの**右辺の式**に付けた名前であり、`V_2` の定義ではない。
`s2`, `K2star` を独立な引数とする一般化として定義しておき（`Part010` の偶奇セクターの議論は
この一般形のまま使う）、人手の主張は `s2 = sinh 2K_2`, `K2star = K_2^*`（`Ising2D.Kstar`）の値について
述べる（`second_transfer_matrix_pauli_form`）。前係数は `V2PauliForm` の中では実冪 `(2 s_2)^{M/2}`
（`Real.rpow`）で書き、人手の定義 `(√(2 sinh 2K_2))^{M_col}`（`secondTransferPrefactor`）と
一致することを `secondTransferPrefactor_eq_rpow` で示す。

## 人手証明との対応

人手証明の `A`（`A_{ij} = exp(K_2 ς_i ς_j)`）は `Ising2D.twoByTwo`、`ς_{i_m} = μ(m)` は
`sgn (ι(μ) m) = μ(m)`（`sgn_configBasisIso`）、`s_2 = sinh 2K_2`（`def_indexed_hyperbolic_abbreviations`）。

* 中間目標「`V_2` を `A` のクロネッカー冪で書く」→ `V2_eq_siteProd_twoByTwo`。
  各段（`def_transfer_matrix`・分配則・`theorem_exp_product`・`A` の成分・クロネッカー積の成分）は
  `V2_apply_configBasisIso_eq_siteProd` の中で一行ずつ対応する。行番号 `ord(μ)` と `ν(ι(μ))` の
  読み替え（`config_numbering_equals_kronecker_numbering`）は、Lean では行列の添字が `ι(μ)` そのもの
  であることにあたる（`Part001/DefinitionTransferMatrix.lean` 冒頭）。すべての行・列番号が
  `(ord(μ), ord(μ'))` の形に書けること（`row_configuration_numbering_bijective` の全射性）は
  `ι` の全射性にあたる。
* 中間目標「1 因子の `exp` をサイト演算子の `exp` にする」→ `exp_smul_sigmaX`。
  人手の「冪の等式 `(σ^x_m)^p = I⊠⋯⊠(σ^x)^p⊠⋯⊠I` を指数級数の部分和へ適用し、成分ごとの極限を取る」を、
  冪の等式 `siteOp_pow`、部分和の像（連続線型写像 `siteOp m` による級数の像 `HasSum.mapL`）、
  極限の一意性（`HasSum.unique`）の 3 段で書く。
* 中間目標「積にまとめる」→ `exp_smul_sum_sigmaX`。
  互いに可換な `K_2^* σ^x_m` の有限和の指数関数が積になること（`theorem_exp_product` の繰り返し適用）は
  `Matrix.exp_sum_of_commute`、直前の中間目標の全因子への同時適用は `Finset.noncommProd_congr`、
  クロネッカー積の積の規則でまとめる段は `noncommProd_siteOp`。
* 中間目標「結論」→ `second_transfer_matrix_pauli_form`。
  `two_by_two_transfer_identity` の全因子への同時適用、多重線型性でスカラーを前へ出す段
  （`siteProd_smul_const`）、`def_second_transfer_matrix_prefactor`（`secondTransferPrefactor`）、
  積にまとめた式、の順。

必要十分版は置かない。本ファイル固有の内容は具体的な行列 `V_2` の成分定義とパウリ行列表示の
突き合わせであり、一般的な部分（連続な環準同型と指数関数の可換性）は `Ising2D/NecSuf/ExpDiagonal.lean`
が扱っている。
-/
import Ising2D.Part001.DefinitionTransferMatrix
import Ising2D.Part004.ClaimTwoByTwoTransferIdentity
import Mathlib.Analysis.Normed.Algebra.MatrixExponential
import Mathlib.Topology.Algebra.Module.FiniteDimension

namespace Ising2D

open NormedSpace

variable {M : ℕ}

/-! ## 前係数（`def_second_transfer_matrix_prefactor`） -/

/-- **人手 `def_second_transfer_matrix_prefactor` の `(2 sinh 2K_2)^{M_col/2} := (√(2 sinh 2K_2))^{M_col}`。** -/
noncomputable def secondTransferPrefactor (M : ℕ) (K2 : ℝ) : ℝ :=
  (Real.sqrt (2 * Real.sinh (2 * K2))) ^ M

/-- 前係数 `(2 s_2)^{M/2}` は `((2 s_2)^{1/2})^M` である（`x ≥ 0` の実冪として）。 -/
theorem rpow_half_pow (x : ℝ) (hx : 0 ≤ x) (M : ℕ) :
    (x ^ ((M : ℝ) / 2) : ℝ) = (Real.sqrt x) ^ M := by
  rw [Real.sqrt_eq_rpow, ← Real.rpow_natCast (x ^ (1 / (2 : ℝ))) M, ← Real.rpow_mul hx]
  congr 1
  ring

/-- 人手の前係数の定義は、`V2PauliForm` / `V2H2Form` の中で使う実冪 `(2 s_2)^{M/2}` に等しい
（`K_2 > 0` のとき）。 -/
theorem secondTransferPrefactor_eq_rpow {K2 : ℝ} (h : 0 < K2) (M : ℕ) :
    secondTransferPrefactor M K2 = (2 * Real.sinh (2 * K2)) ^ ((M : ℝ) / 2) := by
  have hs2 : (0 : ℝ) ≤ 2 * Real.sinh (2 * K2) := by
    have : 0 < Real.sinh (2 * K2) := Real.sinh_pos_iff.mpr (by linarith)
    linarith
  rw [secondTransferPrefactor, rpow_half_pow _ hs2]

/-! ## パウリ行列表示の右辺 -/

/-- **人手 `second_transfer_matrix_pauli_form` の右辺
`(2 s_2)^{M/2} exp(K_2^* (σ^x_1 + ⋯ + σ^x_M))`**（`s2`, `K2star` は独立な引数）。 -/
noncomputable def V2PauliForm (M : ℕ) (s2 : ℝ) (K2star : ℂ) : TensorPow M :=
  (((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ) • exp (K2star • ∑ m : Fin M, sigmaX m)

/-! ## 中間目標「`V_2` を `A` のクロネッカー冪で書く」 -/

/-- 人手の式変形 `(V_2)_{ord(μ),ord(μ')} = ∏_m A_{i_m j_m} = (A ⊠ ⋯ ⊠ A)_{ord(μ),ord(μ')}`。 -/
theorem V2_apply_configBasisIso_eq_siteProd (K2 : ℝ) (μ μ' : SpinConf M) :
    V2 M K2 (configBasisIso M μ) (configBasisIso M μ')
      = siteProd M (fun _ => twoByTwo (K2 : ℂ)) (configBasisIso M μ) (configBasisIso M μ') := by
  -- `def_transfer_matrix`
  rw [V2_apply_configBasisIso,
    -- `ℝ` の分配則
    Finset.mul_sum,
    -- `theorem_exp_product` を有限和へ繰り返し適用
    Real.exp_sum, Complex.ofReal_prod,
    -- クロネッカー積の成分（`def_kronecker` (2)）
    siteProd_apply]
  -- `A` の成分と `ς_{i_m} = μ(m)`, `ς_{j_m} = μ'(m)` を全因子へ同時適用
  refine Finset.prod_congr rfl fun m _ => ?_
  rw [twoByTwo, Matrix.of_apply, sgnC_configBasisIso, sgnC_configBasisIso, Complex.ofReal_exp]
  push_cast
  ring_nf

/-- **中間目標**: 成分定義の `V_2` は `A` のクロネッカー冪 `A ⊠ ⋯ ⊠ A`（`M_col` 個）。 -/
theorem V2_eq_siteProd_twoByTwo (K2 : ℝ) :
    V2 M K2 = siteProd M (fun _ => twoByTwo (K2 : ℂ)) := by
  ext I J
  -- すべての行・列番号の組は `(ι(μ), ι(μ'))` の形に書ける
  obtain ⟨μ, rfl⟩ := (configBasisIso M).surjective I
  obtain ⟨μ', rfl⟩ := (configBasisIso M).surjective J
  exact V2_apply_configBasisIso_eq_siteProd K2 μ μ'

/-! ## 中間目標「1 因子の `exp` をサイト演算子の `exp` にする」 -/

/-- 人手の `(σ^x_m)^p = I⊠⋯⊠(σ^x)^p⊠⋯⊠I`（`kronecker_product_rule` (1) と `I^p = I`）を、
一般の 2×2 行列 `B` について述べたもの。 -/
theorem siteOp_pow (m : Fin M) (B : Matrix (Fin 2) (Fin 2) ℂ) (p : ℕ) :
    siteOp m (B ^ p) = (siteOp m B) ^ p := by
  induction p with
  | zero => rw [pow_zero, pow_zero, siteOp_one]
  | succ p ih => rw [pow_succ, pow_succ, ← siteOp_mul_same, ih]

/-- **人手の中間目標**: `exp(t σ^x_m) = I⊠⋯⊠exp(t σ^x)⊠⋯⊠I`（`t = K_2^*`）。 -/
theorem exp_smul_sigmaX (t : ℂ) (m : Fin M) :
    exp (t • sigmaX m) = siteOp m (exp (t • pauliX)) := by
  open scoped Matrix.Norms.Operator in
  let L : Matrix (Fin 2) (Fin 2) ℂ →L[ℂ] TensorPow M := (siteOp m).toContinuousLinearMap
  -- 指数級数の部分和への冪の等式の適用
  have hterm : ∀ p : ℕ, L (((Nat.factorial p : ℂ))⁻¹ • (t • pauliX) ^ p)
      = ((Nat.factorial p : ℂ))⁻¹ • (t • sigmaX m) ^ p := fun p => by
    rw [LinearMap.coe_toContinuousLinearMap', map_smul, siteOp_pow, map_smul]
    rfl
  -- 成分ごとの極限（連続線型写像による級数の像と、極限の一意性）
  open scoped Matrix.Norms.Operator in
  have hL := (NormedSpace.exp_series_hasSum_exp' (𝕂 := ℂ) (t • pauliX)).mapL L
  open scoped Matrix.Norms.Operator in
  have hR := NormedSpace.exp_series_hasSum_exp' (𝕂 := ℂ) (t • sigmaX m)
  simp only [hterm] at hL
  exact hR.unique hL

/-! ## 中間目標「積にまとめる」 -/

/-- 人手の `kronecker_product_rule` (1) で因子ごとの積にまとめる段:
`∏_m (I⊠⋯⊠B⊠⋯⊠I) = B⊠⋯⊠B`。 -/
theorem noncommProd_siteOp (B : Matrix (Fin 2) (Fin 2) ℂ)
    (hcomm : ((Finset.univ : Finset (Fin M)) : Set (Fin M)).Pairwise
      (fun a b => Commute (siteOp a B) (siteOp b B))) :
    (Finset.univ : Finset (Fin M)).noncommProd (fun m => siteOp m B) hcomm
      = siteProd M (fun _ => B) := by
  have key : ∀ s : Finset (Fin M),
      ∀ hs : (s : Set (Fin M)).Pairwise (fun a b => Commute (siteOp a B) (siteOp b B)),
      s.noncommProd (fun m => siteOp m B) hs = siteProd M (fun i => if i ∈ s then B else 1) := by
    intro s
    induction s using Finset.induction_on with
    | empty =>
      intro hs
      rw [Finset.noncommProd_empty]
      have h1 : (fun i : Fin M => if i ∈ (∅ : Finset (Fin M)) then B else 1) = 1 := by
        funext i; simp
      rw [h1, siteProd_one]
    | insert a s ha ih =>
      intro hs
      rw [Finset.noncommProd_insert_of_notMem _ _ _ _ ha,
        ih (hs.mono (by simp [Set.subset_insert])), siteOp_apply, ← siteProd_mul]
      congr 1
      funext i
      simp only [Pi.mul_apply, Function.update_apply, Pi.one_apply, Finset.mem_insert]
      by_cases hi : i = a
      · subst hi; simp [ha]
      · simp [hi]
  rw [key]
  congr 1
  funext i
  simp

/-- 異なるサイトの `t σ^x_m` は互いに可換。 -/
theorem commute_smul_sigmaX (t : ℂ) {a b : Fin M} (hab : a ≠ b) :
    Commute (t • sigmaX a) (t • sigmaX b) :=
  ((siteOp_mul_comm hab pauliX pauliX : sigmaX a * sigmaX b = sigmaX b * sigmaX a)
    |> fun h => (show Commute (sigmaX a) (sigmaX b) from h)).smul_left t |>.smul_right t

/-- **人手の中間目標**: `exp(t ∑_m σ^x_m) = exp(t σ^x) ⊠ ⋯ ⊠ exp(t σ^x)`（`t = K_2^*`）。 -/
theorem exp_smul_sum_sigmaX (t : ℂ) :
    exp (t • ∑ m : Fin M, sigmaX m) = siteProd M (fun _ => exp (t • pauliX)) := by
  have hpair : ((Finset.univ : Finset (Fin M)) : Set (Fin M)).Pairwise
      (Function.onFun Commute fun m => t • sigmaX m) := fun a _ b _ hab =>
        commute_smul_sigmaX t hab
  rw [Finset.smul_sum,
    -- `theorem_exp_product` を互いに可換な `t σ^x_m` の有限和へ繰り返し適用
    Matrix.exp_sum_of_commute _ _ hpair,
    -- 直前の中間目標の等式を全因子へ同時適用
    Finset.noncommProd_congr rfl (fun m _ => exp_smul_sigmaX t m),
    -- クロネッカー積の積の規則で因子ごとの積にまとめる
    noncommProd_siteOp]

/-! ## 中間目標「結論」 -/

/-- 人手の「`kronecker_multilinear` で各因子のスカラーを前へ出す」段。 -/
theorem siteProd_smul_const (c : ℂ) (B : Matrix (Fin 2) (Fin 2) ℂ) :
    siteProd M (fun _ => c • B) = c ^ M • siteProd M (fun _ => B) := by
  rw [MultilinearMap.map_smul_univ (siteProd M) (fun _ => c) (fun _ => B), Finset.prod_const,
    Finset.card_univ, Fintype.card_fin]

/-- **人手 `second_transfer_matrix_pauli_form`:
`V_2 = (2 sinh 2K_2)^{M_col/2} exp(K_2^* ∑_{m=1}^{M_col} σ^x_m)`**（前係数は人手の定義
`secondTransferPrefactor` で書いた形）。 -/
theorem second_transfer_matrix_pauli_form_prefactor {K2 : ℝ} (h : 0 < K2) :
    V2 M K2 = ((secondTransferPrefactor M K2 : ℝ) : ℂ) •
      exp (((Kstar K2 : ℝ) : ℂ) • ∑ m : Fin M, sigmaX m) := by
  have hA : (fun _ : Fin M => twoByTwo (K2 : ℂ))
      = fun _ : Fin M => ((Real.sqrt (2 * Real.sinh (2 * K2)) : ℝ) : ℂ) •
          exp (((Kstar K2 : ℝ) : ℂ) • pauliX) := by
    funext _
    exact two_by_two_transfer_identity h
  calc V2 M K2
      -- `V_2` を `A` のクロネッカー冪で書いた式
      = siteProd M (fun _ => twoByTwo (K2 : ℂ)) := V2_eq_siteProd_twoByTwo K2
      -- `two_by_two_transfer_identity` を全因子へ同時適用
    _ = siteProd M (fun _ => ((Real.sqrt (2 * Real.sinh (2 * K2)) : ℝ) : ℂ) •
          exp (((Kstar K2 : ℝ) : ℂ) • pauliX)) := by rw [hA]
      -- `kronecker_multilinear` で各因子のスカラーを前へ出す
    _ = (((Real.sqrt (2 * Real.sinh (2 * K2)) : ℝ) : ℂ)) ^ M •
          siteProd M (fun _ => exp (((Kstar K2 : ℝ) : ℂ) • pauliX)) := siteProd_smul_const _ _
      -- `def_second_transfer_matrix_prefactor`
    _ = ((secondTransferPrefactor M K2 : ℝ) : ℂ) •
          siteProd M (fun _ => exp (((Kstar K2 : ℝ) : ℂ) • pauliX)) := by
        rw [secondTransferPrefactor, Complex.ofReal_pow]
      -- 積にまとめた式
    _ = ((secondTransferPrefactor M K2 : ℝ) : ℂ) •
          exp (((Kstar K2 : ℝ) : ℂ) • ∑ m : Fin M, sigmaX m) := by rw [exp_smul_sum_sigmaX]

/-- **人手 `second_transfer_matrix_pauli_form`** を右辺の式 `V2PauliForm` で述べた形
（`s2 = sinh 2K_2`, `K2star = K_2^*`）。 -/
theorem second_transfer_matrix_pauli_form {K2 : ℝ} (h : 0 < K2) :
    V2 M K2 = V2PauliForm M (Real.sinh (2 * K2)) ((Kstar K2 : ℝ) : ℂ) := by
  rw [second_transfer_matrix_pauli_form_prefactor h, secondTransferPrefactor_eq_rpow h, V2PauliForm]

/-- `V2PauliForm` と `V2H2Form` は同じ行列（`√-1 H_2 = ∑_m σ^x_m`、`I_smul_H2_eq_sum_sigmaX` による）。
人手 `V2_in_Z_Y` の Step 3 の指数の肩の等式を、右辺の式どうしの等式として述べたもの。 -/
theorem V2PauliForm_eq_V2H2Form (s2 : ℝ) (K2star : ℂ) :
    V2PauliForm M s2 K2star = V2H2Form M s2 K2star := by
  have h : (Complex.I * K2star) • H2 M = K2star • (Complex.I • H2 M) := by
    rw [smul_smul]
    congr 1
    ring
  rw [V2H2Form, V2PauliForm, ← I_smul_H2_eq_sum_sigmaX, ← h, matExp]

end Ising2D
