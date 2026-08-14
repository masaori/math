/-
人手証明の主張「相異なる有理点の素指数データは分配多項式を一意に決める」
（ラベル `claim_rational_values_determine_partition_polynomial`）の具体版。

人手証明とこのファイルの対応:

  素指数データの単射性から各評価値が等しい
    `eval_eq_of_primeExponentData_eq`
  A-B は d+1 個の相異なる根を持つ
    `samplePoints_subset_difference_roots`
  次数 d 以下の非零多項式に d+1 個の根はない
    `difference_eq_zero_of_sample_roots`

ここで `primeExponentData` は正の有理数上で定義された本文の λ を表し、その単射性は
素因数分解の一意性に対応する。多項式と評価値を区別し、住処は `Nat`、`Rat`、
有理係数多項式、有限型のみである。ℝ / ℂ は現れない。
-/
import Mathlib.Algebra.Polynomial.Roots

namespace Ising3DCut.NullModel

noncomputable section

/-- 素因数分解の一意性を一度だけ適用し、素指数データの等式を有理数の等式へ戻す。 -/
lemma eval_eq_of_primeExponentData_eq {D : Type*}
    (primeExponentData : ℚ → D) (hdata_injective : Function.Injective primeExponentData)
    {A B : Polynomial ℚ} {q : ℚ}
    (hdata : primeExponentData (A.eval q) = primeExponentData (B.eval q)) :
    A.eval q = B.eval q :=
  hdata_injective hdata

/-- 各標本点で二つの多項式の値が等しければ、その相異なる標本点はすべて差多項式の根である。 -/
lemma samplePoints_subset_difference_roots {d : ℕ} {q : Fin (d + 1) → ℚ}
    {A B : Polynomial ℚ} (hAB : A ≠ B) (heval : ∀ i, A.eval (q i) = B.eval (q i)) :
    (Finset.univ.image q).val ⊆ (A - B).roots := by
  intro x hx
  have hx_image : x ∈ Finset.univ.image q := hx
  obtain ⟨i, -, rfl⟩ := Finset.mem_image.mp hx_image
  rw [Polynomial.mem_roots (sub_ne_zero.mpr hAB)]
  change (A - B).eval (q i) = 0
  rw [Polynomial.eval_sub]
  exact sub_eq_zero.mpr (heval i)

/-- 差多項式の次数が `d` 以下なのに相異なる `d+1` 個の標本点を根に持つなら、差は零である。 -/
lemma difference_eq_zero_of_sample_roots {d : ℕ} {q : Fin (d + 1) → ℚ}
    (hq_injective : Function.Injective q) (A B : Polynomial ℚ)
    (hA_degree : A.natDegree ≤ d) (hB_degree : B.natDegree ≤ d)
    (heval : ∀ i, A.eval (q i) = B.eval (q i)) :
    A - B = 0 := by
  by_contra hdifference
  have hAB : A ≠ B := sub_ne_zero.mp hdifference
  have hroots : (Finset.univ.image q).card ≤ (A - B).natDegree :=
    Polynomial.card_le_degree_of_subset_roots
      (samplePoints_subset_difference_roots hAB heval)
  have hpoints : (Finset.univ.image q).card = d + 1 := by
    rw [Finset.card_image_of_injective _ hq_injective, Finset.card_univ, Fintype.card_fin]
  have hdifference_degree : (A - B).natDegree ≤ d :=
    (Polynomial.natDegree_sub_le A B).trans (max_le hA_degree hB_degree)
  omega

/-- `claim_rational_values_determine_partition_polynomial` の具体版。
次数 `d` 以下の二つの有理係数多項式が、相異なる `d+1` 個の正の有理点で
同じ素指数データを持つなら、その二つの多項式は等しい。 -/
theorem rationalPolynomial_eq_of_primeExponentData_eq {D : Type*}
    (primeExponentData : ℚ → D) (hdata_injective : Function.Injective primeExponentData)
    (d : ℕ) (q : Fin (d + 1) → ℚ) (hq_injective : Function.Injective q)
    (A B : Polynomial ℚ) (hA_degree : A.natDegree ≤ d) (hB_degree : B.natDegree ≤ d)
    (hdata : ∀ i, primeExponentData (A.eval (q i)) = primeExponentData (B.eval (q i))) :
    A = B := by
  apply sub_eq_zero.mp
  apply difference_eq_zero_of_sample_roots hq_injective A B hA_degree hB_degree
  intro i
  exact eval_eq_of_primeExponentData_eq primeExponentData hdata_injective (hdata i)

end

end Ising3DCut.NullModel
