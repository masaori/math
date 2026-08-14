/-
人手証明の主張「分配多項式の 1 での値は配位の個数である」
（ラベル `claim_partition_value_at_one`）の具体版。

人手証明の式変形とこのファイルの対応:

  Z_L(1) = Σ_m Ω_L(m) 1^m     `partitionPolynomial_eval_one`
           = Σ_m Ω_L(m)        同じ補題で `1 ^ m = 1` を一項ずつ適用
           = #Σ_L              `sum_multiplicity_eq_config_card`
           = 2^(#V_L)          `config_card_eq_two_pow_site_card`

分配多項式は `Polynomial ℤ` の元として定義し、その 1 での値と区別する。
水準集合の有限和が配位全体を数えることは、破れ数が `0` 以上 `#E_L` 以下の
ただ一つの自然数であることから示す。

住処: `Fin`、`Nat`、`Int`、整数係数多項式、有限型のみ。ℝ / ℂ は現れない。
-/
import Mathlib.Algebra.Polynomial.Eval.Defs
import Mathlib.Data.Fintype.BigOperators
import Ising3DCut.NullModel.MultiplicityPalindrome

namespace Ising3DCut.NullModel

noncomputable section

/-- 自由境界の分配多項式 `Z_L(X) = Σ_m Ω_L(m) X^m ∈ ℤ[X]`。 -/
def partitionPolynomial (L : ℕ) : Polynomial ℤ :=
  ∑ m ∈ Finset.range (Fintype.card (Edge L) + 1),
    Polynomial.monomial m (multiplicity L m)

/-- 人手証明の最初の二行。多項式へ 1 を代入すると多重度の有限和になる。 -/
lemma partitionPolynomial_eval_one (L : ℕ) :
    (partitionPolynomial L).eval 1 =
      ∑ m ∈ Finset.range (Fintype.card (Edge L) + 1), (multiplicity L m : ℤ) := by
  rw [partitionPolynomial, Polynomial.eval_finsetSum]
  simp only [Polynomial.eval_monomial, one_pow, mul_one]

/-- 各配位の破れ数は `0` 以上 `#E_L` 以下のただ一つの自然数なので、
多重度が数える水準集合は配位全体を重複なく分割する。 -/
lemma sum_multiplicity_eq_config_card (L : ℕ) :
    ∑ m ∈ Finset.range (Fintype.card (Edge L) + 1), multiplicity L m =
      Fintype.card (Config L) := by
  have hmaps :
      Set.MapsTo brokenCount
        (↑(Finset.univ : Finset (Config L)) : Set (Config L))
        (↑(Finset.range (Fintype.card (Edge L) + 1)) : Set ℕ) := by
    intro σ _
    rw [Finset.mem_coe, Finset.mem_range]
    exact Nat.lt_succ_of_le (Finset.card_le_card (Finset.filter_subset _ _))
  have hpartition := Finset.card_eq_sum_card_fiberwise
    (f := brokenCount) (s := (Finset.univ : Finset (Config L)))
    (t := Finset.range (Fintype.card (Edge L) + 1)) hmaps
  have hlevel (m : ℕ) : multiplicity L m = (levelSetFinset L m).card := by
    rw [multiplicity]
    exact Fintype.card_of_subtype (levelSetFinset L m) (fun _ => Iff.rfl)
  simp_rw [hlevel]
  simpa [levelSetFinset] using hpartition.symm

/-- 二つの整数値 `+1,-1` と `Bool` の全単射。 -/
def spinEquivBool : Spin ≃ Bool where
  toFun z := z.1 = 1
  invFun b := if b then ⟨1, Or.inl rfl⟩ else ⟨-1, Or.inr rfl⟩
  left_inv z := by
    apply Subtype.ext
    rcases z.2 with h | h <;> simp [h]
  right_inv b := by
    cases b <;> simp

/-- `Config L` と、その定義である点からスピンへの写像との全単射。 -/
def configEquivFunction (L : ℕ) : Config L ≃ (Site L → Spin) where
  toFun σ := σ
  invFun σ := σ
  left_inv _ := rfl
  right_inv _ := rfl

/-- 配位は各点へ二つの値 `+1,-1` のどちらかを割り当てる写像なので、
配位の個数は `2^(#V_L)` である。 -/
lemma config_card_eq_two_pow_site_card (L : ℕ) :
    Fintype.card (Config L) = 2 ^ Fintype.card (Site L) := by
  rw [Fintype.card_congr (configEquivFunction L)]
  rw [Fintype.card_fun, Fintype.card_congr spinEquivBool]
  simp

/-- `claim_partition_value_at_one` の具体版。`Z_L(1) = 2^(#V_L)`。 -/
theorem partitionPolynomial_value_at_one (L : ℕ) :
    (partitionPolynomial L).eval 1 = (2 ^ Fintype.card (Site L) : ℤ) := by
  rw [partitionPolynomial_eval_one]
  norm_cast
  rw [sum_multiplicity_eq_config_card, config_card_eq_two_pow_site_card]

end

end Ising3DCut.NullModel
