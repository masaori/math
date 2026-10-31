/-
# `V^{(+)}` の成分は実である（具体版）

正本: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`
（`closing_009_theorem_c_plus_equals_Lambda_half`、ラベル **`c_plus_equals_Lambda_half_integer`**）の
Step 2 の段落「`V^{(+)}` の成分は実である」。

`Ising2D.EvenSectorBridge`（`TheoremCPlusEqualsLambda.lean`）の欄 `Vr`・`hVr`
（`V^{(+)}` の実行列としての表示）を、`Ising2D.vPlusDataOf` の `V^{(+)}` について与える。

## 人手証明との対応

人手は `V_plus_is_positive_definite` の表示
`V^{(+)} = (2s_2)^{M_col/2} exp(½S_1^{(+)}) exp(S_2) exp(½S_1^{(+)})` において、
`iH_is_real_symmetric` より `S_1^{(+)}, S_2` が実対称であること、実対称行列の指数関数が実対称であること、
`(2s_2)^{M_col/2} ∈ ℝ_{>0}` から `V^{(+)}` が実行列であると結論する。
Lean の `VPlus` は `(V_1^{(+)})^{1/2} · (2s_2)^{M_col/2}exp(S_2) · (V_1^{(+)})^{1/2}` の積の形
（`V2H2Form` がスカラー倍を中に持つ）なので、スカラー倍を `V2H2Form` の中で扱う。

| 人手 | Lean |
| --- | --- |
| `iH_is_real_symmetric` の「成分がすべて実数で転置について対称」を、Lean では「エルミートかつ転置不変」の 2 条件で持ち、そこから成分の実性を読む（定義の同値の片側の向き） | `hasRealEntries_of_isHermitian_of_transpose` |
| `½S_1^{(+)} = (i/2)K_1H_1^{(+)}` は実対称（`iH_is_real_symmetric` を `K_1/2` で） | `halfS1plus_isHermitian`, `halfS1plus_transpose` |
| 実対称行列の指数関数は実対称（`W_is_real_symmetric_positive_definite` の Step 2 と同じ議論） | `matExp_hasRealEntries` |
| `exp(½S_1^{(+)}) = (V_1^{(+)})^{1/2}` の成分は実 | `V1plusHalf_hasRealEntries` |
| `(2s_2)^{M_col/2}exp(S_2)` の成分は実（`S_2` は実対称、`(2s_2)^{M_col/2} ∈ ℝ`） | `V2H2Form_hasRealEntries` |
| 実行列の積は実行列 | `HasRealEntries.mul` |
| 結論: `V^{(+)}` は実行列 | `VPlus_hasRealEntries`、実行列 `VPlusR` と `vPlusDataOf_V_eq_map` |

人手の「実対称行列の指数関数は実対称」は、部分和と極限の実対称性で示す。Lean では
`Matrix.IsHermitian.exp`（`exp(A^*) = exp(A)^*` から従う）と `Matrix.exp_transpose`（`exp(A^⊤) = exp(A)^⊤`）を使う。
共役転置の側は数学的道具立て「トレース・共役転置・正定値性」の `ClaimPositiveDefinite.lean`、転置の側は章 011 の
`PhysicalPartitionFunctionSandwich.lean`（`physicalV1halfC_transpose`・`V2_transpose`）が同じ置き換えをしている。

具体的な `V^{(+)}` の成分についての主張で、`EvenSectorBridge` の欄を埋めるためだけに立てるので、必要十分版は置かない。
-/
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimVPlusPositiveDefinite
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimVPlusDataFromEigenvaluesOfVPlus

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## 成分が実であること -/

/-- 行列 `A` の成分がすべて実である（各成分が複素共役で変わらない）。 -/
def HasRealEntries (A : TensorPow M) : Prop :=
  ∀ s t : Conf M, (starRingEnd ℂ) (A s t) = A s t

/-- エルミートかつ転置不変なら、成分はすべて実（人手 `iH_is_real_symmetric` の「実対称」を Lean で持つ 2 条件から、成分の実性を読む向き）。 -/
theorem hasRealEntries_of_isHermitian_of_transpose {A : TensorPow M}
    (hH : A.IsHermitian) (hT : Aᵀ = A) : HasRealEntries A :=
  entries_real_of_isHermitian_of_transpose hH hT

/-- 実行列の積は実行列（積の成分 `∑_j A_{sj}B_{jt}` の複素共役は各項の複素共役の和）。 -/
theorem HasRealEntries.mul {A B : TensorPow M} (hA : HasRealEntries A) (hB : HasRealEntries B) :
    HasRealEntries (A * B) := by
  intro s t
  rw [Matrix.mul_apply, map_sum]
  exact Finset.sum_congr rfl fun j _ => by rw [map_mul, hA s j, hB j t]

/-- 実行列の実数倍は実行列。 -/
theorem HasRealEntries.real_smul {A : TensorPow M} (hA : HasRealEntries A) (c : ℝ) :
    HasRealEntries ((c : ℂ) • A) := by
  intro s t
  rw [Matrix.smul_apply, smul_eq_mul, map_mul, Complex.conj_ofReal, hA s t]

/-- **実対称行列の指数関数は実対称**（人手 `W_is_real_symmetric_positive_definite` の Step 2 と同じ議論。
Lean では `Matrix.IsHermitian.exp` と `Matrix.exp_transpose` を使う）。 -/
theorem matExp_hasRealEntries {S : TensorPow M} (hH : S.IsHermitian) (hT : Sᵀ = S) :
    HasRealEntries (matExp S) := by
  apply hasRealEntries_of_isHermitian_of_transpose
  · exact hH.exp
  · rw [matExp, ← Matrix.exp_transpose, hT]

/-! ## `V^{(+)}` の因子 -/

/-- `(i/2)K_1 = i(K_1/2)`（`V1plusHalf` の指数の係数を `iH_is_real_symmetric` の形へ）。 -/
theorem halfS1plus_coeff_eq (K1 : ℝ) :
    (1 / 2 : ℂ) * Complex.I * (K1 : ℂ) = Complex.I * ((K1 / 2 : ℝ) : ℂ) := by
  push_cast
  ring

/-- 人手 `iH_is_real_symmetric` を `K_1/2` で: `½S_1^{(+)} = (i/2)K_1H_1^{(+)}` はエルミート。 -/
theorem halfS1plus_isHermitian (K1 : ℝ) :
    (((1 / 2 : ℂ) * Complex.I * (K1 : ℂ)) • H1plus M).IsHermitian := by
  rw [halfS1plus_coeff_eq]
  exact S1plus_isHermitian (Complex.conj_ofReal _)

/-- 人手 `iH_is_real_symmetric` を `K_1/2` で: `½S_1^{(+)}` は転置不変。 -/
theorem halfS1plus_transpose (K1 : ℝ) :
    (((1 / 2 : ℂ) * Complex.I * (K1 : ℂ)) • H1plus M)ᵀ
      = ((1 / 2 : ℂ) * Complex.I * (K1 : ℂ)) • H1plus M := by
  rw [halfS1plus_coeff_eq]
  exact S1plus_transpose

/-- `(V_1^{(+)})^{1/2} = exp(½S_1^{(+)})` の成分は実（`K_1` 実）。 -/
theorem V1plusHalf_hasRealEntries (K1 : ℝ) : HasRealEntries (V1plusHalf M (K1 : ℂ)) :=
  matExp_hasRealEntries (halfS1plus_isHermitian K1) (halfS1plus_transpose K1)

/-- `(2s_2)^{M_col/2}exp(S_2)`（`S_2 = iK_2^*H_2`）の成分は実（`K_2^*` 実）。 -/
theorem V2H2Form_hasRealEntries (s2 K2star : ℝ) :
    HasRealEntries (V2H2Form M s2 (K2star : ℂ)) :=
  (matExp_hasRealEntries (S2_isHermitian (Complex.conj_ofReal _)) S2_transpose).real_smul _

/-- **人手 `c_plus_equals_Lambda_half_integer` Step 2「`V^{(+)}` の成分は実である」**（`K_1, K_2^*` 実）。 -/
theorem VPlus_hasRealEntries (s2 K1 K2star : ℝ) :
    HasRealEntries (VPlus M s2 (K1 : ℂ) (K2star : ℂ)) :=
  ((V1plusHalf_hasRealEntries K1).mul (V2H2Form_hasRealEntries s2 K2star)).mul
    (V1plusHalf_hasRealEntries K1)

/-! ## 実行列としての表示 -/

/-- 成分の実部を取った実行列。 -/
noncomputable def reMat (A : TensorPow M) : Matrix (Conf M) (Conf M) ℝ :=
  A.map Complex.re

/-- 成分が実なら、`A` は実部の実行列を成分ごとに `ℂ` へ埋め込んだもの。 -/
theorem eq_map_reMat {A : TensorPow M} (h : HasRealEntries A) :
    A = (reMat A).map (fun r : ℝ => (r : ℂ)) := by
  ext s t
  rw [Matrix.map_apply, reMat, Matrix.map_apply]
  exact (Complex.conj_eq_iff_re.mp (h s t)).symm

/-- `vPlusDataOf` の `V^{(+)}` の実行列表示。 -/
noncomputable def VPlusR (P : IsingParam) (M : ℕ) : Matrix (Conf M) (Conf M) ℝ :=
  reMat (VPlus M (Real.sinh (2 * P.K2)) (P.K1 : ℂ) (P.K2star : ℂ))

/-- **`Ising2D.EvenSectorBridge.hVr`**: `vPlusDataOf` の `V^{(+)}` は実行列 `VPlusR` を成分ごとに `ℂ` へ埋め込んだもの。 -/
theorem vPlusDataOf_V_eq_map (P : IsingParam) (hM : M ≠ 0)
    (hdual : P.const.c2 * P.const.s2star = P.const.c2star) :
    (vPlusDataOf P hM hdual).V = (VPlusR P M).map (fun r : ℝ => (r : ℂ)) := by
  rw [vPlusDataOf_V, VPlusR]
  exact eq_map_reMat (VPlus_hasRealEntries _ _ _)

end Ising2D
