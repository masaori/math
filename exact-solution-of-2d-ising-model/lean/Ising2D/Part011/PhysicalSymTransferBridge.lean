/-
# 章 011 の実行列 `W` と複素行列としての物理的転送行列の同一視

正本: `structured-latex/content/011_max_eigenvalue.ts`

* `maxeig_001_definition_transfer_matrix_square_root`
  （ラベル **`def_transfer_matrix_square_root`**）
* `maxeig_001a_definition_symmetrized_transfer_matrix`
  （ラベル **`def_symmetrized_transfer_matrix`**）
* `maxeig_claim_symmetrized_transfer_matrix_on_sectors`
  （ラベル **`symmetrized_transfer_matrix_on_sectors`**）

章 011 の Rayleigh 商は実行列 `W` 上で述べる一方、章 010 までの物理的転送行列は
`TensorPow M = Matrix (Conf M) (Conf M) ℂ` 上で定義されている。本ファイルでは、
実成分で定めた `V₁¹⁄²`, `V₂`, `W` を明示し、各成分を `ℂ` へ埋め込むと
章 010 の Pauli 表示から作る対称化転送行列そのものになることを示す。

これは同じ具体的な行列の二つの係数体での表示を突き合わせる主張なので、必要十分版は置かない。
-/
import Ising2D.Part010.Claim004_V1Bridge
import Ising2D.Part010.Claim006_V2Bridge
import Ising2D.Part010.Claim012_SectorDecomposition
import Ising2D.Part011.Definition001_SymmetrizedTransferMatrix

namespace Ising2D

variable {M : ℕ}

/-! ## 実成分で定める物理的転送行列 -/

/-- `V₁¹⁄²` の実行列表示。

対角成分は `exp((K₁/2) ∑_m μ(m)μ(m+1))` であり、非対角成分は `0`。 -/
noncomputable def physicalV1halfR (M : ℕ) (K1 : ℝ) : Matrix (Conf M) (Conf M) ℝ :=
  Matrix.diagonal fun I : Conf M =>
    Real.exp ((K1 / 2) * ∑ m : Fin M, sgn (I m) * sgn (I (nextSite m)))

/-- `V₂` の実行列表示。成分は `exp(K₂ ∑_m μ(m)μ'(m))`。 -/
noncomputable def physicalV2R (M : ℕ) (K2 : ℝ) : Matrix (Conf M) (Conf M) ℝ :=
  Matrix.of fun I J : Conf M =>
    Real.exp (∑ m : Fin M, K2 * sgn (I m) * sgn (J m))

/-- 章 011 で実ベクトルへ作用させる対称化転送行列
`W = V₁¹⁄² V₂ V₁¹⁄²`。 -/
noncomputable def physicalSymTransferR (M : ℕ) (K1 K2 : ℝ) :
    Matrix (Conf M) (Conf M) ℝ :=
  symTransfer (physicalV1halfR M K1) (physicalV2R M K2)

/-! ## `TensorPow` 上の物理的転送行列 -/

/-- 章 010 の Pauli 表示から作る `V₁¹⁄²`。 -/
noncomputable def physicalV1halfC (M : ℕ) (K1 : ℝ) : TensorPow M :=
  V1pauli M (((K1 / 2 : ℝ) : ℂ))

/-- 章 010 の Pauli 表示から作る物理的な対称化転送行列。 -/
noncomputable def physicalSymTransferC (M : ℕ) (K1 K2 : ℝ) : TensorPow M :=
  physicalV1halfC M K1 *
    V2pauli M (Real.sinh (2 * K2)) (((Kstar K2 : ℝ) : ℂ)) *
    physicalV1halfC M K1

/-- 実行列表示の `V₁¹⁄²` を成分ごとに `ℂ` へ埋め込むと、Pauli 表示に一致する。 -/
theorem physicalV1halfC_eq_map (K1 : ℝ) :
    physicalV1halfC M K1 = (physicalV1halfR M K1).map Complex.ofRealHom := by
  rw [physicalV1halfC, V1pauli_eq_V1comp]
  ext I J
  rw [V1comp_apply]
  by_cases h : I = J
  · subst h
    simp only [if_pos, physicalV1halfR, Matrix.map_apply, Matrix.diagonal_apply_eq,
      Complex.ofRealHom_eq_coe, rowEnergy]
    rw [Complex.ofReal_exp]
    congr 1
    rw [Complex.ofReal_mul, Complex.ofReal_sum, Finset.mul_sum]
    refine Finset.sum_congr rfl fun m _ => ?_
    simp only [sgnC, Complex.ofReal_mul, Complex.ofReal_div]
    ring
  · rw [if_neg h, physicalV1halfR, Matrix.map_apply, Matrix.diagonal_apply_ne _ h,
      map_zero]

/-- 実行列表示の `V₂` を成分ごとに `ℂ` へ埋め込むと、Pauli 表示に一致する。 -/
theorem physicalV2C_eq_map {K2 : ℝ} (hK2 : 0 < K2) :
    V2pauli M (Real.sinh (2 * K2)) (((Kstar K2 : ℝ) : ℂ))
      = (physicalV2R M K2).map Complex.ofRealHom := by
  rw [V2pauli_eq_V2comp hK2]
  ext I J
  rw [V2comp_apply]
  change Complex.exp (interEnergy (K2 : ℂ) I J) =
    ((Real.exp (∑ m : Fin M, K2 * sgn (I m) * sgn (J m)) : ℝ) : ℂ)
  rw [Complex.ofReal_exp, interEnergy, Complex.ofReal_sum]
  congr 1
  refine Finset.sum_congr rfl fun m _ => ?_
  simp only [sgnC, Complex.ofReal_mul]

/-- **章 011 の実行列 `W` と複素 `TensorPow` 上の物理的転送行列は同じ成分を持つ。**

左辺は章 010 の `V₁`, `V₂` の Pauli 表示から作る行列、右辺は章 011 の
Rayleigh 商で使う実行列を成分ごとに `ℂ` へ埋め込んだ行列である。 -/
theorem physicalSymTransferC_eq_map {K2 : ℝ} (K1 : ℝ) (hK2 : 0 < K2) :
    physicalSymTransferC M K1 K2 =
      (physicalSymTransferR M K1 K2).map Complex.ofRealHom := by
  rw [physicalSymTransferC, physicalSymTransferR, symTransfer,
    Matrix.map_mul, Matrix.map_mul, ← physicalV1halfC_eq_map K1,
    ← physicalV2C_eq_map hK2]

/-! ## セクター射影後の表示 -/

/-- **人手本文 `symmetrized_transfer_matrix_on_sectors`:
`W P^{(±)} = V^{(±)} P^{(±)}`。**

左辺では章 011 の実行列 `W` を成分ごとに `ℂ` へ埋め込む。右辺では
セクター固有値 `η` に対して境界符号を `-η` とした章 010 の `Vsym` を使う。
証明は本文と同じく、`B P = C P` と `P C = C P`, `P V₂ = V₂ P` を
一行ずつ代入する。ここで使う構造だけを残した必要十分版は
`Ising2D.NecSuf.sandwich_mul_proj_eq` である。 -/
theorem physicalSymTransferR_map_mul_epsProj_eq_Vsym {K2 : ℝ} (K1 : ℝ)
    (hM : 2 ≤ M) (hK2 : 0 < K2) {η : ℂ} (hη : η * η = 1) :
    (physicalSymTransferR M K1 K2).map Complex.ofRealHom * epsProj M η
      = Vsym M (K1 : ℂ) (-η) (Real.sinh (2 * K2)) (((Kstar K2 : ℝ) : ℂ)) *
          epsProj M η := by
  rw [← physicalSymTransferC_eq_map K1 hK2]
  let B : TensorPow M := physicalV1halfC M K1
  let C : TensorPow M := V1half M (K1 : ℂ) (-η)
  let V : TensorPow M :=
    V2pauli M (Real.sinh (2 * K2)) (((Kstar K2 : ℝ) : ℂ))
  let P : TensorPow M := epsProj M η
  have hhalf : V1 M (((K1 / 2 : ℝ) : ℂ)) (-η) = C := by
    dsimp [C]
    rw [V1, V1half]
    congr 1
    rw [Complex.ofReal_div]
    norm_num
    module
  have hBP : B * P = C * P := by
    dsimp [B, P]
    rw [physicalV1halfC]
    calc
      V1pauli M (((K1 / 2 : ℝ) : ℂ)) * epsProj M η
          = V1 M (((K1 / 2 : ℝ) : ℂ)) (-η) * epsProj M η :=
            sector_replacement_of_V1 hM hη
      _ = C * epsProj M η := by rw [hhalf]
  have hCP : C * P = P * C := by
    exact (commute_V1half_epsProj (M := M) (K1 : ℂ) (-η) η).eq
  have hVP : V * P = P * V := by
    exact (commute_V2pauli_epsProj (M := M) (Real.sinh (2 * K2))
      (((Kstar K2 : ℝ) : ℂ)) η).eq
  change B * V * B * P = C * V * C * P
  exact NecSuf.sandwich_mul_proj_eq hBP hCP hVP

end Ising2D
