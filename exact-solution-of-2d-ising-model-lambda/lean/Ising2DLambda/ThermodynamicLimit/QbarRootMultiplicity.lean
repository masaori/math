/-
章「熱力学極限」の「零でない代数的数係数多項式の根の重複度」
（`def_qbar_root_multiplicity`）の具体版。定義ブロックなので必要十分版は置かない。

  人手証明                                                          このファイル
  𝒦_w(f) := { k ∈ ℕ | (t-ŵ)^k ∣ f }（有限集合として）              `qbarRootMultiplicityExponentSet`
    n_f := f の非零係数の番号の最大元、k ∈ 𝒦 ⇒ k ≤ n_f              `f.support.max'`, `qbarLinearFactorPowDividesExponentLe`
    （集合を {0,…,n_f} の filter として持つ）                        `mem_qbarRootMultiplicityExponentSet`
  0 ∈ 𝒦_w(f)（空でない）                                            `qbarRootMultiplicityExponentSet_nonempty`
  mult_w(f) := max 𝒦_w(f)                                            `qbarRootMultiplicity`（`Finset.max'`）
  読み取り 1: (t-ŵ)^{mult} ∣ f                                       `qbarRootMultiplicity_divides`
  読み取り 2: (t-ŵ)^k ∣ f ⇒ k ≤ mult                                 `qbarRootMultiplicity_ge_of_divides`
  読み取り 3: 係数の上界 n ⇒ mult ≤ n                                `qbarRootMultiplicity_le_of_coeff_bound`
  （橋渡し）mathlib の `Polynomial.rootMultiplicity` との一致        `qbarRootMultiplicity_eq_rootMultiplicity`

住処: Q̄（実数体・複素数体は現れない）。`natDegree` は使わず係数で書く。
-/
import Ising2DLambda.ThermodynamicLimit.QbarLinearFactorPowDividesExponentLe

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue
open Polynomial
open Classical

/-- 零でない `f` の非零係数の番号の集合は空でない。 -/
theorem qbarPoly_support_nonempty_of_ne_zero (f : QbarPoly) (hf : f ≠ 0) :
    f.support.Nonempty := by
  rw [Finset.nonempty_iff_ne_empty, Ne, Polynomial.support_eq_empty]
  exact hf

/-- 非零係数の番号の最大元 `n_f`。 -/
noncomputable def qbarPolyTopIndex (f : QbarPoly) (hf : f ≠ 0) : ℕ :=
  f.support.max' (qbarPoly_support_nonempty_of_ne_zero f hf)

/-- `i > n_f` ならば `ac_i(f) = 0`。 -/
theorem qbarPolyTopIndex_coeff_bound (f : QbarPoly) (hf : f ≠ 0) :
    ∀ i, qbarPolyTopIndex f hf < i → f.coeff i = 0 := by
  intro i hi
  by_contra hci
  have hmem : i ∈ f.support := Polynomial.mem_support_iff.mpr hci
  exact absurd (Finset.le_max' f.support i hmem) (not_le.mpr hi)

/-- `𝒦_w(f) = { k ∈ ℕ | (t-ŵ)^k ∣ f }`。有限集合として `{0,…,n_f}` の中で取る
（`k ∈ 𝒦_w(f) ⇒ k ≤ n_f` は `qbarLinearFactorPowDividesExponentLe`）。 -/
noncomputable def qbarRootMultiplicityExponentSet (w : Qbar) (f : QbarPoly) (hf : f ≠ 0) :
    Finset ℕ :=
  (Finset.range (qbarPolyTopIndex f hf + 1)).filter (fun k => qbarLinearFactorPowDivides w k f)

/-- `k ∈ 𝒦_w(f) ↔ (t-ŵ)^k ∣ f`（範囲の条件は整除から従う）。 -/
theorem mem_qbarRootMultiplicityExponentSet (w : Qbar) (f : QbarPoly) (hf : f ≠ 0) (k : ℕ) :
    k ∈ qbarRootMultiplicityExponentSet w f hf ↔ qbarLinearFactorPowDivides w k f := by
  unfold qbarRootMultiplicityExponentSet
  rw [Finset.mem_filter, Finset.mem_range]
  constructor
  · intro h
    exact h.2
  · intro h
    refine ⟨?_, h⟩
    -- k ≤ n_f（claim_qbar_linear_factor_pow_divides_exponent_le を上界 n_f で）
    have hk : k ≤ qbarPolyTopIndex f hf :=
      qbarLinearFactorPowDividesExponentLe w f (qbarPolyTopIndex f hf) hf
        (qbarPolyTopIndex_coeff_bound f hf) k h
    exact Nat.lt_succ_of_le hk

/-- `0 ∈ 𝒦_w(f)`（`k = 0` は任意の多項式を割り切る）。 -/
theorem qbarRootMultiplicityExponentSet_nonempty (w : Qbar) (f : QbarPoly) (hf : f ≠ 0) :
    (qbarRootMultiplicityExponentSet w f hf).Nonempty :=
  ⟨0, (mem_qbarRootMultiplicityExponentSet w f hf 0).mpr (qbarLinearFactorPowDivides_zero w f)⟩

/-- 根の重複度 `mult_w(f) := max 𝒦_w(f)`。 -/
noncomputable def qbarRootMultiplicity (w : Qbar) (f : QbarPoly) (hf : f ≠ 0) : ℕ :=
  (qbarRootMultiplicityExponentSet w f hf).max' (qbarRootMultiplicityExponentSet_nonempty w f hf)

/-- 読み取り 1: `(t-ŵ)^{mult_w(f)} ∣ f`（最大元は集合の元）。 -/
theorem qbarRootMultiplicity_divides (w : Qbar) (f : QbarPoly) (hf : f ≠ 0) :
    qbarLinearFactorPowDivides w (qbarRootMultiplicity w f hf) f :=
  (mem_qbarRootMultiplicityExponentSet w f hf _).mp
    (Finset.max'_mem _ (qbarRootMultiplicityExponentSet_nonempty w f hf))

/-- 読み取り 2: `(t-ŵ)^k ∣ f` ならば `k ≤ mult_w(f)`（最大元は集合のどの元以上）。 -/
theorem qbarRootMultiplicity_ge_of_divides (w : Qbar) (f : QbarPoly) (hf : f ≠ 0) (k : ℕ)
    (hk : qbarLinearFactorPowDivides w k f) : k ≤ qbarRootMultiplicity w f hf :=
  Finset.le_max' _ k ((mem_qbarRootMultiplicityExponentSet w f hf k).mpr hk)

/-- 読み取り 3: 係数の上界 `n` のもとで `mult_w(f) ≤ n`
（読み取り 1 と `f ≠ 0` に `qbarLinearFactorPowDividesExponentLe` を当てる）。 -/
theorem qbarRootMultiplicity_le_of_coeff_bound (w : Qbar) (f : QbarPoly) (hf : f ≠ 0) (n : ℕ)
    (hn : ∀ i, n < i → f.coeff i = 0) : qbarRootMultiplicity w f hf ≤ n :=
  qbarLinearFactorPowDividesExponentLe w f n hf hn _ (qbarRootMultiplicity_divides w f hf)

/-- 橋渡し: mathlib の `Polynomial.rootMultiplicity` と一致する
（両向きの不等式を `Polynomial.le_rootMultiplicity_iff` で読み取り 1・2 と結ぶ）。 -/
theorem qbarRootMultiplicity_eq_rootMultiplicity (w : Qbar) (f : QbarPoly) (hf : f ≠ 0) :
    qbarRootMultiplicity w f hf = Polynomial.rootMultiplicity w f := by
  apply le_antisymm
  · rw [Polynomial.le_rootMultiplicity_iff hf]
    exact (qbarLinearFactorPowDivides_iff_dvd w _ f).mp (qbarRootMultiplicity_divides w f hf)
  · apply qbarRootMultiplicity_ge_of_divides
    rw [qbarLinearFactorPowDivides_iff_dvd]
    exact (Polynomial.le_rootMultiplicity_iff hf).mp le_rfl

end Ising2DLambda.ThermodynamicLimit
