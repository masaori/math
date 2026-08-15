/-
章「熱力学極限」の「開境界長方形の接合不等式（正の有理点）」
（`claim_open_rectangle_gluing_inequality_rational`）の具体版（人手証明と 1 対 1 に対応させる）。

実数版 `OpenRectangleGluingInequality.lean` と同じ手順を、評価点を正の有理数 `q : ℚ` に
置いて辿る。値は `openPartitionValueRat`（`OpenRectanglePartitionValueRational.lean`。
`Z[x]` の分配多項式への代入）。

  人手証明の段                                     このファイル
  全単射と破れボンド数の分解による二重和への
    書き換えと q^{m+n} = q^m q^n                   openPartitionValueRat_glueFirst_eq
  0<q≤1 での自然数冪の順序 q^b ≤ q^s ≤ 1           pow_le_one_by_induction_rat /
                                                   pow_le_pow_of_le_one_of_exp_le_by_induction_rat
  「各項は正」                                     pow_pos_by_induction（正の有理数の冪は正）
  項ごとの評価の有限和と有限和の分配則
    （第一方向・0<q≤1 の二つの不等式）             openPartitionValueRat_glueFirst_bounds_of_le_one
  1≤q での自然数冪の順序 1 ≤ q^s ≤ q^b
    （第一方向・1≤q の二つの不等式）               openPartitionValueRat_glueFirst_bounds_of_one_le
  第二の座標の向き（同じ置き換え）                 openPartitionValueRat_glueSecond_eq /
                                                   openPartitionValueRat_glueSecond_bounds_of_le_one /
                                                   openPartitionValueRat_glueSecond_bounds_of_one_le

住処: ℕ・ℚ のみ。ℝ / ℂ は現れない。使うのは有理数体の順序体としての性質・自然数冪・
有限和・有限積だけである。

人手証明との対応の注意（実数版と同じ）:
- 冪の順序は指数についての帰納法と指数の差への分解で示し、mathlib の既製の単調性定理へ委ねない。
- 「項ごとに掛けて有限和を取る」は `Finset.sum_le_sum` を二重に適用して書く。
- 「有限和の分配則」は `Finset.mul_sum`（定数倍）と `Finset.sum_mul_sum`（積の展開）で書く。
- 実数版 `claim_open_rectangle_gluing_inequality` はこの主張の実数側の像であり、旧経路の撤去まで併存させる。
-/
import Ising2DLambda.ThermodynamicLimit.OpenRectangleGluing
import Ising2DLambda.ThermodynamicLimit.OpenRectanglePartitionValueRational
import Ising2DLambda.ThermodynamicLimit.PartitionValueUpperBoundRational

namespace Ising2DLambda.ThermodynamicLimit

open Finset PartitionPolynomial NecSuf.ThermodynamicLimit

variable (a b c : ℕ)

/-- 一以下の非負の底の自然数冪は一以下である。人手証明どおり指数について帰納する。 -/
lemma pow_le_one_by_induction_rat {q : ℚ} (hq0 : 0 ≤ q) (hq1 : q ≤ 1) : ∀ k : ℕ, q ^ k ≤ 1
  | 0 => by rw [pow_zero]
  | k + 1 => by
      rw [pow_succ]
      calc
        q ^ k * q ≤ 1 * 1 :=
          mul_le_mul (pow_le_one_by_induction_rat hq0 hq1 k) hq1 hq0 zero_le_one
        _ = 1 := one_mul 1

/-- 一以下の正の底では指数を大きくすると冪は増えない
（人手証明の `q^b ≤ q^s`。指数の差への分解と一以下の冪で示す）。 -/
lemma pow_le_pow_of_le_one_of_exp_le_by_induction_rat {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    ∀ {m n : ℕ}, m ≤ n → q ^ n ≤ q ^ m := by
  intro m n hmn
  obtain ⟨d, rfl⟩ := Nat.exists_eq_add_of_le hmn
  calc
    q ^ (m + d) = q ^ m * q ^ d := pow_add q m d
    _ ≤ q ^ m * 1 :=
      mul_le_mul_of_nonneg_left (pow_le_one_by_induction_rat hq0.le hq1 d)
        (pow_pos_by_induction hq0 m).le
    _ = q ^ m := mul_one _

/-- 人手証明の「上の全単射と破れボンド数の分解」と「`q^{m+n} = q^m q^n`」の二段:
接合後の値の有限和を、対の二重和へ書き換える（第一の座標の向き）。 -/
lemma openPartitionValueRat_glueFirst_eq (ha : 0 < a) (hc : 0 < c) (q : ℚ) :
    openPartitionValueRat (a + c) b q =
      ∑ σ : OpenConfig a b, ∑ τ : OpenConfig c b,
        q ^ (openBrokenBondCount a b σ + openBrokenBondCount c b τ) *
          q ^ openSeamBrokenCountFirst a b c ha hc σ τ := by
  rw [openPartitionValueRat_eq_sum]
  rw [← Fintype.sum_equiv (openConfigGlueEquivFirst a b c)
    (fun p : OpenConfig a b × OpenConfig c b =>
      q ^ openBrokenBondCount (a + c) b (openConfigGlueFirst a b c p.1 p.2))
    (fun ρ => q ^ openBrokenBondCount (a + c) b ρ) (fun _ => rfl)]
  rw [Fintype.sum_prod_type]
  exact sum_congr rfl fun σ _ => sum_congr rfl fun τ _ => by
    rw [openBrokenBondCount_glueFirst a b c ha hc σ τ, pow_add]

/-- 人手証明の「有限和の分配則と冪の指数法則」の段: 値の積を二重和へ書き換える。 -/
lemma openPartitionValueRat_mul_eq_double_sum (a₁ b₁ a₂ b₂ : ℕ) (q : ℚ) :
    openPartitionValueRat a₁ b₁ q * openPartitionValueRat a₂ b₂ q =
      ∑ σ : OpenConfig a₁ b₁, ∑ τ : OpenConfig a₂ b₂,
        q ^ (openBrokenBondCount a₁ b₁ σ + openBrokenBondCount a₂ b₂ τ) := by
  rw [openPartitionValueRat_eq_sum, openPartitionValueRat_eq_sum, sum_mul_sum]
  exact sum_congr rfl fun σ _ => sum_congr rfl fun τ _ => (pow_add q _ _).symm

/-- `claim_open_rectangle_gluing_inequality_rational` の第一の座標の向き、`0 < q ≤ 1` の場合:
`q^b Z^op_{a,b}(q) Z^op_{c,b}(q) ≤ Z^op_{a+c,b}(q) ≤ Z^op_{a,b}(q) Z^op_{c,b}(q)`。 -/
theorem openPartitionValueRat_glueFirst_bounds_of_le_one
    (ha : 0 < a) (hc : 0 < c) {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    q ^ b * (openPartitionValueRat a b q * openPartitionValueRat c b q) ≤
        openPartitionValueRat (a + c) b q ∧
      openPartitionValueRat (a + c) b q ≤
        openPartitionValueRat a b q * openPartitionValueRat c b q := by
  constructor
  · rw [openPartitionValueRat_mul_eq_double_sum a b c b q,
      openPartitionValueRat_glueFirst_eq a b c ha hc q, mul_sum]
    refine sum_le_sum fun σ _ => ?_
    rw [mul_sum]
    refine sum_le_sum fun τ _ => ?_
    calc
      q ^ b * q ^ (openBrokenBondCount a b σ + openBrokenBondCount c b τ)
          = q ^ (openBrokenBondCount a b σ + openBrokenBondCount c b τ) * q ^ b :=
        mul_comm _ _
      _ ≤ q ^ (openBrokenBondCount a b σ + openBrokenBondCount c b τ) *
            q ^ openSeamBrokenCountFirst a b c ha hc σ τ :=
        mul_le_mul_of_nonneg_left
          (pow_le_pow_of_le_one_of_exp_le_by_induction_rat hq0 hq1
            (openSeamBrokenCountFirst_le a b c ha hc σ τ))
          (pow_pos_by_induction hq0 _).le
  · rw [openPartitionValueRat_mul_eq_double_sum a b c b q,
      openPartitionValueRat_glueFirst_eq a b c ha hc q]
    refine sum_le_sum fun σ _ => sum_le_sum fun τ _ => ?_
    calc
      q ^ (openBrokenBondCount a b σ + openBrokenBondCount c b τ) *
            q ^ openSeamBrokenCountFirst a b c ha hc σ τ
          ≤ q ^ (openBrokenBondCount a b σ + openBrokenBondCount c b τ) * 1 :=
        mul_le_mul_of_nonneg_left (pow_le_one_by_induction_rat hq0.le hq1 _)
          (pow_pos_by_induction hq0 _).le
      _ = q ^ (openBrokenBondCount a b σ + openBrokenBondCount c b τ) := mul_one _

/-- `claim_open_rectangle_gluing_inequality_rational` の第一の座標の向き、`1 ≤ q` の場合:
`Z^op_{a,b}(q) Z^op_{c,b}(q) ≤ Z^op_{a+c,b}(q) ≤ q^b Z^op_{a,b}(q) Z^op_{c,b}(q)`。 -/
theorem openPartitionValueRat_glueFirst_bounds_of_one_le
    (ha : 0 < a) (hc : 0 < c) {q : ℚ} (hq : 1 ≤ q) :
    openPartitionValueRat a b q * openPartitionValueRat c b q ≤
        openPartitionValueRat (a + c) b q ∧
      openPartitionValueRat (a + c) b q ≤
        q ^ b * (openPartitionValueRat a b q * openPartitionValueRat c b q) := by
  have hq0 : 0 < q := lt_of_lt_of_le zero_lt_one hq
  constructor
  · rw [openPartitionValueRat_mul_eq_double_sum a b c b q,
      openPartitionValueRat_glueFirst_eq a b c ha hc q]
    refine sum_le_sum fun σ _ => sum_le_sum fun τ _ => ?_
    calc
      q ^ (openBrokenBondCount a b σ + openBrokenBondCount c b τ)
          = q ^ (openBrokenBondCount a b σ + openBrokenBondCount c b τ) * 1 :=
        (mul_one _).symm
      _ ≤ q ^ (openBrokenBondCount a b σ + openBrokenBondCount c b τ) *
            q ^ openSeamBrokenCountFirst a b c ha hc σ τ :=
        mul_le_mul_of_nonneg_left (one_le_pow_by_induction_rat hq _)
          (pow_pos_by_induction hq0 _).le
  · rw [openPartitionValueRat_mul_eq_double_sum a b c b q,
      openPartitionValueRat_glueFirst_eq a b c ha hc q, mul_sum]
    refine sum_le_sum fun σ _ => ?_
    rw [mul_sum]
    refine sum_le_sum fun τ _ => ?_
    calc
      q ^ (openBrokenBondCount a b σ + openBrokenBondCount c b τ) *
            q ^ openSeamBrokenCountFirst a b c ha hc σ τ
          ≤ q ^ (openBrokenBondCount a b σ + openBrokenBondCount c b τ) * q ^ b :=
        mul_le_mul_of_nonneg_left
          (pow_le_pow_of_one_le_of_exp_le_by_induction_rat hq
            (openSeamBrokenCountFirst_le a b c ha hc σ τ))
          (pow_pos_by_induction hq0 _).le
      _ = q ^ b * q ^ (openBrokenBondCount a b σ + openBrokenBondCount c b τ) :=
        mul_comm _ _

/-- 二重和への書き換え（第二の座標の向き。人手証明の「同じ全単射・破れボンド数の分解」）。 -/
lemma openPartitionValueRat_glueSecond_eq (hb : 0 < b) (hc : 0 < c) (q : ℚ) :
    openPartitionValueRat a (b + c) q =
      ∑ σ : OpenConfig a b, ∑ τ : OpenConfig a c,
        q ^ (openBrokenBondCount a b σ + openBrokenBondCount a c τ) *
          q ^ openSeamBrokenCountSecond a b c hb hc σ τ := by
  rw [openPartitionValueRat_eq_sum]
  rw [← Fintype.sum_equiv (openConfigGlueEquivSecond a b c)
    (fun p : OpenConfig a b × OpenConfig a c =>
      q ^ openBrokenBondCount a (b + c) (openConfigGlueSecond a b c p.1 p.2))
    (fun ρ => q ^ openBrokenBondCount a (b + c) ρ) (fun _ => rfl)]
  rw [Fintype.sum_prod_type]
  exact sum_congr rfl fun σ _ => sum_congr rfl fun τ _ => by
    rw [openBrokenBondCount_glueSecond a b c hb hc σ τ, pow_add]

/-- `claim_open_rectangle_gluing_inequality_rational` の第二の座標の向き、`0 < q ≤ 1` の場合:
`q^a Z^op_{a,b}(q) Z^op_{a,c}(q) ≤ Z^op_{a,b+c}(q) ≤ Z^op_{a,b}(q) Z^op_{a,c}(q)`。 -/
theorem openPartitionValueRat_glueSecond_bounds_of_le_one
    (hb : 0 < b) (hc : 0 < c) {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    q ^ a * (openPartitionValueRat a b q * openPartitionValueRat a c q) ≤
        openPartitionValueRat a (b + c) q ∧
      openPartitionValueRat a (b + c) q ≤
        openPartitionValueRat a b q * openPartitionValueRat a c q := by
  constructor
  · rw [openPartitionValueRat_mul_eq_double_sum a b a c q,
      openPartitionValueRat_glueSecond_eq a b c hb hc q, mul_sum]
    refine sum_le_sum fun σ _ => ?_
    rw [mul_sum]
    refine sum_le_sum fun τ _ => ?_
    calc
      q ^ a * q ^ (openBrokenBondCount a b σ + openBrokenBondCount a c τ)
          = q ^ (openBrokenBondCount a b σ + openBrokenBondCount a c τ) * q ^ a :=
        mul_comm _ _
      _ ≤ q ^ (openBrokenBondCount a b σ + openBrokenBondCount a c τ) *
            q ^ openSeamBrokenCountSecond a b c hb hc σ τ :=
        mul_le_mul_of_nonneg_left
          (pow_le_pow_of_le_one_of_exp_le_by_induction_rat hq0 hq1
            (openSeamBrokenCountSecond_le a b c hb hc σ τ))
          (pow_pos_by_induction hq0 _).le
  · rw [openPartitionValueRat_mul_eq_double_sum a b a c q,
      openPartitionValueRat_glueSecond_eq a b c hb hc q]
    refine sum_le_sum fun σ _ => sum_le_sum fun τ _ => ?_
    calc
      q ^ (openBrokenBondCount a b σ + openBrokenBondCount a c τ) *
            q ^ openSeamBrokenCountSecond a b c hb hc σ τ
          ≤ q ^ (openBrokenBondCount a b σ + openBrokenBondCount a c τ) * 1 :=
        mul_le_mul_of_nonneg_left (pow_le_one_by_induction_rat hq0.le hq1 _)
          (pow_pos_by_induction hq0 _).le
      _ = q ^ (openBrokenBondCount a b σ + openBrokenBondCount a c τ) := mul_one _

/-- `claim_open_rectangle_gluing_inequality_rational` の第二の座標の向き、`1 ≤ q` の場合:
`Z^op_{a,b}(q) Z^op_{a,c}(q) ≤ Z^op_{a,b+c}(q) ≤ q^a Z^op_{a,b}(q) Z^op_{a,c}(q)`。 -/
theorem openPartitionValueRat_glueSecond_bounds_of_one_le
    (hb : 0 < b) (hc : 0 < c) {q : ℚ} (hq : 1 ≤ q) :
    openPartitionValueRat a b q * openPartitionValueRat a c q ≤
        openPartitionValueRat a (b + c) q ∧
      openPartitionValueRat a (b + c) q ≤
        q ^ a * (openPartitionValueRat a b q * openPartitionValueRat a c q) := by
  have hq0 : 0 < q := lt_of_lt_of_le zero_lt_one hq
  constructor
  · rw [openPartitionValueRat_mul_eq_double_sum a b a c q,
      openPartitionValueRat_glueSecond_eq a b c hb hc q]
    refine sum_le_sum fun σ _ => sum_le_sum fun τ _ => ?_
    calc
      q ^ (openBrokenBondCount a b σ + openBrokenBondCount a c τ)
          = q ^ (openBrokenBondCount a b σ + openBrokenBondCount a c τ) * 1 :=
        (mul_one _).symm
      _ ≤ q ^ (openBrokenBondCount a b σ + openBrokenBondCount a c τ) *
            q ^ openSeamBrokenCountSecond a b c hb hc σ τ :=
        mul_le_mul_of_nonneg_left (one_le_pow_by_induction_rat hq _)
          (pow_pos_by_induction hq0 _).le
  · rw [openPartitionValueRat_mul_eq_double_sum a b a c q,
      openPartitionValueRat_glueSecond_eq a b c hb hc q, mul_sum]
    refine sum_le_sum fun σ _ => ?_
    rw [mul_sum]
    refine sum_le_sum fun τ _ => ?_
    calc
      q ^ (openBrokenBondCount a b σ + openBrokenBondCount a c τ) *
            q ^ openSeamBrokenCountSecond a b c hb hc σ τ
          ≤ q ^ (openBrokenBondCount a b σ + openBrokenBondCount a c τ) * q ^ a :=
        mul_le_mul_of_nonneg_left
          (pow_le_pow_of_one_le_of_exp_le_by_induction_rat hq
            (openSeamBrokenCountSecond_le a b c hb hc σ τ))
          (pow_pos_by_induction hq0 _).le
      _ = q ^ a * q ^ (openBrokenBondCount a b σ + openBrokenBondCount a c τ) :=
        mul_comm _ _

end Ising2DLambda.ThermodynamicLimit
