/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

反復そのもの: 必要十分版の `iterRight` / `precompIterate` / `iterLeft` に
  ι := ZMod L（または RowConfig L）、f := columnTranslation L（または rowShift L）
を代入すると、具体版の `columnTranslationIterate` / `rowShiftIterate` と同じ写像が出る。

4 つの主張と定理も、同じ代入で出る。代入する仮定は次だけである。
  γ^[L] = id      ← L • 1̄ = 0（ZMod L で π(L) = 0 であること）
  S^[L] = id      ← 上の γ^[L] = id
  U^L = I         ← 上の S^[L] = id と、ℤ[x] の a * 1 = a、a * 0 = 0

このことは、具体版の証明が次を使っていないという主張の裏取りになっている。
行配位であること・格子の形・スピンの値が ±1 であること・成分が多項式であること・
成分が不定元の冪であること・シフトが巡回であること・ℤ/Lℤ の加法が可換であること・
ℤ/Lℤ が有限であること・逆元があること・`ℤ[x]` の分配則・積の結合則・積の可換性・引き算。
とくに **`e` の位数がちょうど L であることは使っておらず、L 回で恒等写像に戻る
全単射であれば何でも、その行列は L 乗すると単位行列になる**。

住処: ℕ / ℤ / ℤ[x] のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.ShiftMatrixOrder
import Ising2DLambda.AlgebraicEigenvalue.ShiftMatrixFromNecSuf
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.ShiftMatrixOrder

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 具体版の `γ^[k]` が、必要十分版の右からの反復の特殊化であること。 -/
theorem columnTranslationIterate_eq_necSuf (k : ℕ) (y : ZMod L) :
    columnTranslationIterate L k y
      = NecSuf.AlgebraicEigenvalue.iterRight (columnTranslation L) k y := by
  induction k generalizing y with
  | zero => rfl
  | succ k ih => exact ih (columnTranslation L y)

/-- 反復した平行移動の主張を、必要十分版から導いたもの。 -/
theorem columnTranslationIterate_apply_from_necSuf (k : ℕ) (y : ZMod L) :
    columnTranslationIterate L k y = y + (k : ZMod L) := by
  have hf : columnTranslation L = fun z : ZMod L => z + 1 := rfl
  rw [columnTranslationIterate_eq_necSuf, hf,
    NecSuf.AlgebraicEigenvalue.iterRight_add_apply (1 : ZMod L) k y, nsmul_eq_mul, mul_one]

/-- 平行移動の周期の主張を、必要十分版から導いたもの。渡す仮定は `L • 1̄ = 0` だけである。 -/
theorem columnTranslationIterate_period_from_necSuf (y : ZMod L) :
    columnTranslationIterate L L y = y := by
  have h : (L : ℕ) • (1 : ZMod L) = 0 := by
    rw [nsmul_eq_mul, mul_one, ZMod.natCast_self]
  have hf : columnTranslation L = fun z : ZMod L => z + 1 := rfl
  rw [columnTranslationIterate_eq_necSuf, hf]
  exact NecSuf.AlgebraicEigenvalue.iterRight_add_period (1 : ZMod L) L h y

/-- 具体版の `S^[k]` が、必要十分版の引き戻しの反復の特殊化であること。 -/
theorem rowShiftIterate_eq_necSuf (k : ℕ) (τ : RowConfig L) (y : ZMod L) :
    rowShiftIterate L k τ y
      = NecSuf.AlgebraicEigenvalue.precompIterate (V := PartitionPolynomial.SpinValue)
          (columnTranslation L) k (fun z => τ z) y := by
  induction k generalizing y with
  | zero => rfl
  | succ k ih => exact ih (columnTranslation L y)

/-- 反復した巡回シフトの主張を、必要十分版から導いたもの。 -/
theorem rowShiftIterate_apply_from_necSuf (k : ℕ) (τ : RowConfig L) (y : ZMod L) :
    rowShiftIterate L k τ y = τ (columnTranslationIterate L k y) := by
  rw [rowShiftIterate_eq_necSuf,
    NecSuf.AlgebraicEigenvalue.precompIterate_apply (V := PartitionPolynomial.SpinValue) (columnTranslation L) k
      (fun z => τ z) y,
    columnTranslationIterate_eq_necSuf]

/-- 巡回シフトの周期の主張を、必要十分版から導いたもの。
渡す仮定は上で導いた `γ^[L] = id` だけである。 -/
theorem rowShiftIterate_period_from_necSuf (τ : RowConfig L) :
    rowShiftIterate L L τ = τ := by
  have h : ∀ y : ZMod L,
      NecSuf.AlgebraicEigenvalue.iterRight (columnTranslation L) L y = y := by
    intro y
    rw [← columnTranslationIterate_eq_necSuf]
    exact columnTranslationIterate_period_from_necSuf y
  funext y
  rw [rowShiftIterate_eq_necSuf]
  exact congrFun
    (NecSuf.AlgebraicEigenvalue.precompIterate_period (V := PartitionPolynomial.SpinValue)
      (columnTranslation L) L h (fun z => τ z)) y

/-- 具体版の `U^k` が、必要十分版の置換行列の冪の特殊化であること。 -/
theorem shiftMatrixPow_eq_necSuf (k : ℕ) (τ τ' : RowConfig L) :
    rowMatrixPow L (shiftMatrix L) k τ τ'
      = NecSuf.AlgebraicEigenvalue.matPow
          (NecSuf.AlgebraicEigenvalue.permMatrix (S := Polynomial ℤ) (rowShiftEquiv L)) k τ τ' := by
  classical
  induction k generalizing τ' with
  | zero => exact shiftMatrix_eq_necSuf τ τ'
  | succ k ih =>
    show rowMatrixProduct L (rowMatrixPow L (shiftMatrix L) k) (shiftMatrix L) τ τ' = _
    show (∑ σ : RowConfig L, rowMatrixPow L (shiftMatrix L) k τ σ * shiftMatrix L σ τ') = _
    refine Finset.sum_congr rfl fun σ _ => ?_
    rw [ih σ, shiftMatrix_eq_necSuf]

/-- シフト行列の冪の主張を、必要十分版から導いたもの。 -/
theorem shiftMatrix_pow_apply_from_necSuf (k : ℕ) (τ τ' : RowConfig L) :
    rowMatrixPow L (shiftMatrix L) k τ τ'
      = if τ' = rowShiftIterate L (k + 1) τ then constPoly 1 else constPoly 0 := by
  classical
  have hiter : ∀ (m : ℕ) (σ : RowConfig L),
      NecSuf.AlgebraicEigenvalue.iterLeft (fun ρ => (rowShiftEquiv L) ρ) m σ
        = rowShiftIterate L m σ := by
    intro m
    induction m with
    | zero => intro σ; rfl
    | succ m ih => intro σ; show rowShift L _ = rowShift L _; rw [ih σ]
  rw [shiftMatrixPow_eq_necSuf,
    NecSuf.AlgebraicEigenvalue.permMatrix_pow_apply
      (fun a : Polynomial ℤ => mul_one a) (fun a : Polynomial ℤ => mul_zero a)
      (rowShiftEquiv L) k τ τ',
    hiter (k + 1) τ, constPoly_one, constPoly_zero]

/-- 定理「シフト行列の L 乗は単位行列である」を、必要十分版から導いたもの。

渡す仮定は上で導いた `S^[L] = id` と、`ℤ[x]` の `a * 1 = a`、`a * 0 = 0` だけである。 -/
theorem shiftMatrix_pow_L_from_necSuf :
    rowMatrixPow L (shiftMatrix L) (L - 1) = identityRowMatrix L := by
  classical
  have hL : L - 1 + 1 = L := Nat.succ_pred_eq_of_pos (Nat.pos_of_ne_zero (NeZero.ne L))
  funext τ τ'
  rw [shiftMatrix_pow_apply_from_necSuf, hL, rowShiftIterate_period_from_necSuf,
    identityRowMatrix]
  by_cases h : τ = τ'
  · rw [if_pos h.symm, if_pos h]
  · rw [if_neg (fun hc : τ' = τ => h hc.symm), if_neg h]

end Ising2DLambda.AlgebraicEigenvalue
