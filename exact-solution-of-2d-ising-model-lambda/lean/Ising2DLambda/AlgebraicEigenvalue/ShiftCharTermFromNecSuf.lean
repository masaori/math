/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

必要十分版の `permMatrixOf` / `charMatrixOf` / `OrbitPreserving` に
ι := RowConfig L、S := Polynomial ℤ、f := rowShift L を代入すると、具体版の
`shiftMatrix` / `charMatrix` / `OrbitPreserving` と同じものが出る。渡す仮定は次だけである。

  R_L が有限で相等が判定できること
  係数環が可換環であること（特性行列の定義が -A_{τ,τ'} を含むため。証明は引き算を使わない）
  各点について K(τ) が空でないこと   ← S^[L](τ) = τ と L ≥ 1（`iterLeft_period_exists`）

**S の単射性も全射性も渡していない。** 像の個数が変わらないことに使う単射性は
置換 φ のものであり（`Equiv.Perm` なので自動）、S については何も要求しない。

このことは、具体版の証明が次を使っていないという主張の裏取りになっている。
行配位であること・格子の形・スピンの値が ±1 であること・シフトが巡回であること・
S が全単射であること・S の位数が L であること・符号が ±1 であること・符号が乗法的であること。

住処: ℤ / ℕ のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.ShiftCharTerm
import Ising2DLambda.AlgebraicEigenvalue.RowShiftOrbitPartitionFromNecSuf
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.ShiftCharTerm

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 具体版のシフト行列が、必要十分版の置換行列（写像版）の特殊化であること。

`ShiftMatrixFromNecSuf` の `shiftMatrix_eq_necSuf` は全単射版の `permMatrix` を相手にしているが、
ここで要るのは**全単射性を仮定しない**写像版 `permMatrixOf` との一致である。 -/
theorem shiftMatrix_eq_permMatrixOf_necSuf (τ τ' : RowConfig L) :
    shiftMatrix L τ τ' =
      NecSuf.AlgebraicEigenvalue.permMatrixOf (S := Polynomial ℤ) (rowShift L) τ τ' := by
  classical
  by_cases h : τ' = rowShift L τ
  · simp [shiftMatrix, NecSuf.AlgebraicEigenvalue.permMatrixOf, h, constPoly]
  · simp [shiftMatrix, NecSuf.AlgebraicEigenvalue.permMatrixOf, h, constPoly]

/-- 具体版の特性行列が、必要十分版の特性行列の特殊化であること。 -/
theorem charMatrix_shiftMatrix_eq_necSuf (τ τ' : RowConfig L) :
    charMatrix L (shiftMatrix L) τ τ' =
      NecSuf.AlgebraicEigenvalue.charMatrixOf
        (NecSuf.AlgebraicEigenvalue.permMatrixOf (S := Polynomial ℤ) (rowShift L)) τ τ' := by
  classical
  by_cases h : τ = τ'
  · subst h
    simp [charMatrix, NecSuf.AlgebraicEigenvalue.charMatrixOf, constSecond,
      shiftMatrix_eq_permMatrixOf_necSuf]
  · simp [charMatrix, NecSuf.AlgebraicEigenvalue.charMatrixOf, h, constSecond,
      shiftMatrix_eq_permMatrixOf_necSuf]

/-- 主張「特性行列の成分は列の添字が行の添字でもその像でもないとき零元である」を、
必要十分版から導いたもの。 -/
theorem charMatrix_shiftMatrix_eq_zero_from_necSuf {τ τ' : RowConfig L}
    (hτ : τ' ≠ τ) (hS : τ' ≠ rowShift L τ) :
    charMatrix L (shiftMatrix L) τ τ' = 0 := by
  rw [charMatrix_shiftMatrix_eq_necSuf]
  exact NecSuf.AlgebraicEigenvalue.charMatrix_eq_zero_of_ne (rowShift L) hτ hS

/-- 主張「行の添字にもその像にも当たらない値を取る置換の項は零元である」を、
必要十分版から導いたもの。 -/
theorem charTerm_shiftMatrix_eq_zero_from_necSuf (φ : Equiv.Perm (RowConfig L))
    {τ₁ : RowConfig L} (h₁ : φ τ₁ ≠ τ₁) (h₂ : φ τ₁ ≠ rowShift L τ₁) :
    constSecond (constPoly (permSign L φ)) *
        ∏ τ : RowConfig L, charMatrix L (shiftMatrix L) τ (φ τ) = 0 := by
  refine NecSuf.AlgebraicEigenvalue.term_eq_zero_of_entry_zero _ _ φ (i₁ := τ₁) ?_
  exact charMatrix_shiftMatrix_eq_zero_from_necSuf h₁ h₂

/-- 具体版の「軌道を保つ置換」が、必要十分版のそれの特殊化であること。 -/
theorem orbitPreserving_iff_necSuf (φ : Equiv.Perm (RowConfig L)) :
    OrbitPreserving L φ ↔
      NecSuf.AlgebraicEigenvalue.OrbitPreserving (rowShift L) φ := by
  constructor
  · intro h τ
    exact (rowShiftOrbit_eq_necSuf τ) ▸ h τ
  · intro h τ
    exact (rowShiftOrbit_eq_necSuf τ).symm ▸ h τ

/-- 主張「各行配位をそれ自身かその像へ送る置換は軌道を保つ」を、必要十分版から導いたもの。 -/
theorem orbitPreserving_of_fixed_or_shift_from_necSuf {φ : Equiv.Perm (RowConfig L)}
    (h : ∀ τ : RowConfig L, φ τ = τ ∨ φ τ = rowShift L τ) : OrbitPreserving L φ :=
  (orbitPreserving_iff_necSuf φ).mpr
    (NecSuf.AlgebraicEigenvalue.orbitPreserving_of_fixed_or_map (rowShift L) φ h)

/-- 主張「軌道を保つ置換は各軌道をそれ自身へ写す」を、必要十分版から導いたもの。 -/
theorem image_orbit_eq_of_orbitPreserving_from_necSuf {φ : Equiv.Perm (RowConfig L)}
    (hφ : OrbitPreserving L φ) {O : Finset (RowConfig L)} (hO : O ∈ rowShiftOrbitSet L) :
    O.image φ = O := by
  obtain ⟨τ₀, hτ₀⟩ := mem_rowShiftOrbitSet.mp hO
  subst hτ₀
  rw [rowShiftOrbit_eq_necSuf]
  exact NecSuf.AlgebraicEigenvalue.image_orbit_eq (rowShift L) iterLeft_period_exists
    ((orbitPreserving_iff_necSuf φ).mp hφ) τ₀

end Ising2DLambda.AlgebraicEigenvalue
