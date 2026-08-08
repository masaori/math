/-
章「固有値の代数性」の「特性多項式」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 5 件
（`def_second_matrix` / `def_second_determinant` / `def_indeterminate_element` /
`def_characteristic_matrix` / `def_characteristic_polynomial`）と主張 3 件
（`claim_second_const_degree_zero` / `claim_second_linear_monic` /
`claim_characteristic_polynomial_monic`）に対応する。

  人手証明                          このファイル
  Mat_{R_L}(ℤ[x][t])                SecondRowMatrix L
  det_t B                           secondDeterminant L B
  t（不定元自身が定める元）          Polynomial.X
  ch(A)                             charMatrix L A
  χ_A                               charPoly L A
  ι(a) ∈ D_0                        degLe_constSecond
  t + ι(a) ∈ M_1                    monicDeg_indeterminate_add_constSecond
  χ_A ∈ M_{2^L}                     monicDeg_charPoly
  準備の第一（恒等置換の項）         monicDeg_identity_term
  準備の第二（恒等でない置換の項）   degLe_term_of_ne_one
  準備の第三（その総和）             degLe_rest

人手証明が符号の反転を ℤ[x] の中で済ませていること（`ch(A)_{τ,τ'} = t + ι(-A_{τ,τ'})`）は
ここでも同じで、`ℤ[x][t]` の引き算はどこにも現れない。整数である符号を `ℤ[x][t]` へ入れる
経路も人手証明と同じく `constSecond ∘ constPoly`（= ι ∘ κ）だけである。

mathlib の `Matrix.det` / `Matrix.charpoly` は引いていない（引くと「置換にわたる和として
定める」「係数の条件として次数を定める」という人手証明の定義そのものが消える）。

住処: 人手証明のこれらのブロックは ℤ を宣言している。ここに ℝ / ℂ は現れない
（係数は `Polynomial ℤ`、次数と添字は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.SecondPolynomial

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable (L : ℕ) [NeZero L]

/-- 人手証明の `Mat_{R_L}(ℤ[x][t])`。成分が `ℤ[x][t]` である、行配位を添字とする行列。 -/
def SecondRowMatrix : Type := RowConfig L → RowConfig L → SecondPoly

/-- 人手証明の `det_t B = Σ_φ ι(κ(sgn φ)) · Π_τ B_{τ,φ(τ)}`。 -/
noncomputable def secondDeterminant (B : SecondRowMatrix L) : SecondPoly :=
  ∑ φ : Equiv.Perm (RowConfig L),
    constSecond (constPoly (permSign L φ)) * ∏ τ : RowConfig L, B τ (φ τ)

/-- 人手証明の特性行列 `ch(A)`。符号の反転は `ℤ[x]` の中で済ませてある。 -/
noncomputable def charMatrix (A : RowMatrix L) : SecondRowMatrix L :=
  fun τ τ' =>
    if τ = τ' then Polynomial.X + constSecond (-A τ τ) else constSecond (-A τ τ')

/-- 人手証明の特性多項式 `χ_A = det_t(ch(A))`。 -/
noncomputable def charPoly (A : RowMatrix L) : SecondPoly :=
  secondDeterminant L (charMatrix L A)

variable {L}

/-- 人手証明の主張「定数として送った元の次数は 0 以下である」。 -/
theorem degLe_constSecond (a : Polynomial ℤ) : DegLe (constSecond a) 0 := by
  intro k hk
  -- k > 0 なので k = k' + 1 の形であり、ι の定義から係数は κ(0)。
  obtain ⟨k', rfl⟩ : ∃ k', k = k' + 1 := ⟨k - 1, by omega⟩
  rw [coeff_constSecond_succ, constPoly_zero]

/-- 人手証明の主張「不定元に定数を足したものはモニックな次数 1 の元である」。 -/
theorem monicDeg_indeterminate_add_constSecond (a : Polynomial ℤ) :
    MonicDeg (Polynomial.X + constSecond a) 1 := by
  constructor
  · -- 第一（k > 1 の係数。t の係数と ι(a) の係数がともに κ(0)）。
    intro k hk
    obtain ⟨k', rfl⟩ : ∃ k', k = k' + 1 := ⟨k - 1, by omega⟩
    rw [constPoly_zero, Polynomial.coeff_add, coeff_constSecond_succ,
      Polynomial.coeff_X, if_neg (by omega), add_zero]
  · -- 第二（t^1 の係数。κ(1) + κ(0) = κ(1)）。
    rw [Polynomial.coeff_add, Polynomial.coeff_X_one, coeff_constSecond_succ (a := a) (k := 0),
      add_zero, constPoly_one]

/-- 人手証明の準備の第一。恒等置換の項はモニックな次数 `2^L` の元である。 -/
theorem monicDeg_identity_term (A : RowMatrix L) :
    MonicDeg (∏ τ : RowConfig L, charMatrix L A τ ((1 : Equiv.Perm (RowConfig L)) τ)) (2 ^ L) := by
  have hterm : ∀ τ : RowConfig L,
      MonicDeg (charMatrix L A τ ((1 : Equiv.Perm (RowConfig L)) τ)) 1 := by
    intro τ
    simpa [charMatrix] using monicDeg_indeterminate_add_constSecond (-A τ τ)
  have := monicDeg_prod (T := (univ : Finset (RowConfig L)))
    (f := fun τ => charMatrix L A τ ((1 : Equiv.Perm (RowConfig L)) τ))
    (n := fun _ => 1) (fun τ _ => hterm τ)
  -- Σ_{τ ∈ R_L} 1 = |R_L| = 2^L。
  simpa [card_rowConfig] using this

/-- 人手証明の準備の第二。恒等写像でない置換の項は次数が `2^L - 2` 以下である。 -/
theorem degLe_term_of_ne_one (A : RowMatrix L) {φ : Equiv.Perm (RowConfig L)} (hφ : φ ≠ 1) :
    DegLe (constSecond (constPoly (permSign L φ)) * ∏ τ : RowConfig L, charMatrix L A τ (φ τ))
      (2 ^ L - 2) := by
  classical
  -- 各因子の次数の上界 n_τ（動かされる τ では 0、そうでなければ 1）。
  set n : RowConfig L → ℕ := fun τ => if φ τ = τ then 1 else 0 with hn
  have hfactor : ∀ τ ∈ (univ : Finset (RowConfig L)),
      DegLe (charMatrix L A τ (φ τ)) (n τ) := by
    intro τ _
    by_cases h : φ τ = τ
    · -- 動かされない τ。因子は t + ι(-A_{τ,τ}) で M_1 ⊂ D_1。
      simp only [hn, h, if_pos rfl]
      simpa [charMatrix, h] using (monicDeg_indeterminate_add_constSecond (-A τ τ)).1
    · -- 動かされる τ。因子は ι(-A_{τ,φ(τ)}) で D_0。
      simp only [hn, if_neg h]
      simpa [charMatrix, Ne.symm h] using degLe_constSecond (-A τ (φ τ))
  have hprod := degLe_prod (T := (univ : Finset (RowConfig L)))
    (f := fun τ => charMatrix L A τ (φ τ)) (n := n) hfactor
  -- Σ_τ n_τ = |R_L| - |M(φ)| ≤ 2^L - 2。
  have hsum : ∑ τ : RowConfig L, n τ = Fintype.card (RowConfig L) - (movedBy L φ).card := by
    have hsplit : (univ.filter fun τ : RowConfig L => φ τ = τ).card
        + (movedBy L φ).card = Fintype.card (RowConfig L) := by
      simpa [movedBy, Finset.card_univ] using
        Finset.filter_card_add_filter_neg_card_eq_card
          (s := (univ : Finset (RowConfig L))) (p := fun τ => φ τ = τ)
    rw [hn, ← Finset.card_filter]
    omega
  have hle : ∑ τ : RowConfig L, n τ ≤ 2 ^ L - 2 := by
    have h2 := two_le_card_movedBy hφ
    have hcard : Fintype.card (RowConfig L) = 2 ^ L := card_rowConfig L
    omega
  -- 係数 ι(κ(sgn φ)) は D_0 なので、2 つの元の積として全体が D_{2^L-2} に入る。
  have := degLe_mul (degLe_constSecond (constPoly (permSign L φ))) (hprod.mono hle)
  simpa using this

/-- 人手証明の準備の第三。恒等写像でない項の総和は次数が `2^L - 2` 以下である。 -/
theorem degLe_rest (A : RowMatrix L) :
    DegLe (∑ φ ∈ (univ : Finset (Equiv.Perm (RowConfig L))).erase 1,
        constSecond (constPoly (permSign L φ)) * ∏ τ : RowConfig L, charMatrix L A τ (φ τ))
      (2 ^ L - 2) :=
  degLe_sum fun φ hφ => degLe_term_of_ne_one A (Finset.ne_of_mem_erase hφ)

/-- 人手証明の主張「特性多項式はモニックな次数 `2^L` の元である」。

証明は人手証明どおり。恒等置換の項を括り出し（`sgn(id) = 1` と `ι(κ(1))` が単位元）、
第 1 項が `M_{2^L}`、残りが `D_{2^L-2}` であることから `monicDeg_add_of_degLe` で結論する。 -/
theorem monicDeg_charPoly (A : RowMatrix L) : MonicDeg (charPoly L A) (2 ^ L) := by
  classical
  -- 第 3 の等号（有限和から恒等置換の項を括り出す）。
  have hsplit : charPoly L A
      = constSecond (constPoly (permSign L (1 : Equiv.Perm (RowConfig L))))
          * ∏ τ : RowConfig L, charMatrix L A τ ((1 : Equiv.Perm (RowConfig L)) τ)
        + ∑ φ ∈ (univ : Finset (Equiv.Perm (RowConfig L))).erase 1,
            constSecond (constPoly (permSign L φ)) * ∏ τ : RowConfig L, charMatrix L A τ (φ τ) := by
    rw [charPoly, secondDeterminant,
      ← Finset.add_sum_erase _ _ (mem_univ (1 : Equiv.Perm (RowConfig L)))]
  -- 第 4・第 5 の等号（sgn(id) = 1、ι(κ(1)) は単位元）。
  rw [hsplit, permSign_id, constSecond_constPoly_one, one_mul]
  -- 2^L ≥ 2 なので 2^L - 2 < 2^L。
  have hpos : 0 < 2 ^ L := Nat.two_pow_pos L
  exact monicDeg_add_of_degLe (monicDeg_identity_term A) (degLe_rest A) (by omega)

end Ising2DLambda.AlgebraicEigenvalue
