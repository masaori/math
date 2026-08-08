/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

必要十分版 `NecSuf.AlgebraicEigenvalue.monicDeg_charDet` に

  ι := RowConfig L（行配位）、S := Polynomial ℤ（人手証明の ℤ[x]）、
  w := fun φ => ι(κ(sgn φ))、B := fun τ τ' => -A τ τ'

を代入すると、具体版の主張「χ_A ∈ M_{2^L}」がそのまま出る。書き換えが要るのは 2 箇所で、
どちらも記法の違いである。第一に、必要十分版が `Fintype.card ι` と書く個数が、具体版では
`2^L` である（`card_rowConfig`）。第二に、係数の零元と単位元を具体版は人手証明に合わせて
`κ(0)` / `κ(1)` と書き、必要十分版は `0` / `1` と書く（`constPoly_zero` / `constPoly_one`）。

重み `w` について必要十分版が要求するのは次の 2 つだけであり、具体版はこれを満たす。

  w 1 = 1              ← permSign_id と constSecond_constPoly_one
  ∀ φ, DegLe (w φ) 0   ← degLe_constSecond（符号がどんな整数であってもよい）

すなわち具体版の証明は、符号が ±1 であることも、転倒数で定まることも、乗法的であることも
使っていない。行配位であること・格子の形・スピンの値が ±1 であることも使っていない。
ℤ[x][t] の引き算も使っていない（符号の反転は特性行列の定義で ℤ[x] の中に閉じ込めてある）。

住処: ℤ[x] と ℕ のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.CharacteristicPolynomial
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.CharacteristicPolynomial

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 具体版の特性行列は、必要十分版の `charMatrix` に `B := fun τ τ' => -A τ τ'` を
代入したものである。 -/
theorem charMatrix_eq_necSuf (A : RowMatrix L) (τ τ' : RowConfig L) :
    charMatrix L A τ τ' = NecSuf.AlgebraicEigenvalue.charMatrix (fun a b => -A a b) τ τ' := by
  unfold charMatrix NecSuf.AlgebraicEigenvalue.charMatrix constSecond
  split <;> rfl

/-- 具体版の主張「特性多項式はモニックな次数 `2^L` の元である」を、必要十分版から導いたもの。 -/
theorem monicDeg_charPoly_from_necSuf (A : RowMatrix L) : MonicDeg (charPoly L A) (2 ^ L) := by
  classical
  haveI : Nonempty (RowConfig L) := ⟨fun _ => ⟨1, Or.inl rfl⟩⟩
  have hw : (fun φ : Equiv.Perm (RowConfig L) => constSecond (constPoly (permSign L φ))) 1 = 1 := by
    show constSecond (constPoly (permSign L (1 : Equiv.Perm (RowConfig L)))) = 1
    rw [permSign_id, constSecond_constPoly_one]
  have hwdeg : ∀ φ : Equiv.Perm (RowConfig L),
      NecSuf.AlgebraicEigenvalue.DegLe (constSecond (constPoly (permSign L φ))) 0 := by
    intro φ
    intro k hk
    -- 具体版の degLe_constSecond（κ(0) と書く）を、必要十分版の書き方（0）へ移す。
    have := degLe_constSecond (constPoly (permSign L φ)) k hk
    rwa [constPoly_zero] at this
  have := NecSuf.AlgebraicEigenvalue.monicDeg_charDet
    (ι := RowConfig L) (S := Polynomial ℤ)
    (fun φ => constSecond (constPoly (permSign L φ))) hw hwdeg (fun a b => -A a b)
  -- 具体版の χ_A と個数 2^L の書き方へ戻す。
  rw [charPoly, secondDeterminant]
  simp only [charMatrix_eq_necSuf]
  rw [MonicDeg, NecSuf.AlgebraicEigenvalue.MonicDeg] at *
  rw [card_rowConfig] at this
  refine ⟨fun k hk => ?_, ?_⟩
  · rw [constPoly_zero]
    exact this.1 k hk
  · rw [constPoly_one]
    exact this.2

end Ising2DLambda.AlgebraicEigenvalue
