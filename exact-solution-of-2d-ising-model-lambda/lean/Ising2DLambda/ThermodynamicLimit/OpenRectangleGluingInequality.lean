/-
章「熱力学極限」の「開境界長方形の接合不等式」の実数評価の上下評価の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts` の
`def_open_rectangle_partition_value`（値の定義と正値性）と
`claim_open_rectangle_gluing_inequality`（四つの不等式）である。

  人手証明の段                                     このファイル
  Z^op_{a,b}(t) := Σ_σ t^{b^op(σ)}                 openPartitionValue /
                                                   openPartitionValue_eq_sum
  「和は有限であり、各項は正なので 0 < Z^op」      openPartitionValue_pos
  全単射と破れボンド数の分解による二重和への
    書き換えと t^{m+n} = t^m t^n                   openPartitionValue_glueFirst_eq
  0<t≤1 での自然数冪の順序 t^b ≤ t^s ≤ 1           pow_le_one_by_induction /
                                                   pow_le_pow_of_le_one_of_exp_le_by_induction
  項ごとの評価の有限和と有限和の分配則
    （第一方向・0<t≤1 の二つの不等式）             openPartitionValue_glueFirst_bounds_of_le_one
  1≤t での自然数冪の順序 1 ≤ t^s ≤ t^b
    （第一方向・1≤t の二つの不等式）               openPartitionValue_glueFirst_bounds_of_one_le
  第二の座標の向き（同じ置き換え）                 openPartitionValue_glueSecond_eq /
                                                   openPartitionValue_glueSecond_bounds_of_le_one /
                                                   openPartitionValue_glueSecond_bounds_of_one_le

住処: この章で宣言済みの ℝ 脱出の中にある。使うのは順序体の性質・自然数冪・
有限和・有限積だけであり、実対数・完備性・極限は使わない（人手証明の realEscape どおり）。

人手証明との対応の注意:
- 底が一以下のときの冪の順序も、既存の底が一以上のときと同様に指数についての
  帰納法（`pow_le_one_by_induction`）と指数の差への分解で示し、mathlib の
  既製の単調性定理へ委ねない。
- 「項ごとに掛けて有限和を取る」は `Finset.sum_le_sum` を二重に適用して書く。
- 「有限和の分配則」は `Finset.mul_sum`（定数倍）と `Finset.sum_mul_sum`（積の展開）で書く。
-/
import Ising2DLambda.ThermodynamicLimit.OpenRectangleGluing
import Ising2DLambda.ThermodynamicLimit.PartitionValueUpperBound

namespace Ising2DLambda.ThermodynamicLimit

open Finset PartitionPolynomial

variable (a b c : ℕ)

/-- 開境界長方形の分配多項式の正の実数での値 `Z^op_{a,b}(t)`（多項式への代入）。 -/
noncomputable def openPartitionValue (t : ℝ) : ℝ :=
  Polynomial.aeval t (openPartitionPolynomial a b)

/-- 代入は有限和と冪を保つ（人手証明の定義の右辺 `Σ_σ t^{b^op(σ)}`）。 -/
lemma openPartitionValue_eq_sum (t : ℝ) :
    openPartitionValue a b t = ∑ σ : OpenConfig a b, t ^ openBrokenBondCount a b σ := by
  rw [openPartitionValue, openPartitionPolynomial, map_sum]
  exact sum_congr rfl fun σ _ => by rw [map_pow, Polynomial.aeval_X]

instance : Nonempty (OpenConfig a b) := ⟨fun _ => ⟨1, Or.inl rfl⟩⟩

/-- 「和は有限であり、各項は正なので `0 < Z^op_{a,b}(t)`」。 -/
lemma openPartitionValue_pos {t : ℝ} (ht : 0 < t) : 0 < openPartitionValue a b t := by
  rw [openPartitionValue_eq_sum]
  exact sum_pos (fun σ _ => pow_pos_by_induction ht _) univ_nonempty

/-- 一以下の非負の底の自然数冪は一以下である。人手証明どおり指数について帰納する。 -/
lemma pow_le_one_by_induction {t : ℝ} (ht0 : 0 ≤ t) (ht1 : t ≤ 1) : ∀ k : ℕ, t ^ k ≤ 1
  | 0 => le_rfl
  | k + 1 => by
      rw [pow_succ]
      calc
        t ^ k * t ≤ 1 * 1 :=
          mul_le_mul (pow_le_one_by_induction ht0 ht1 k) ht1 ht0 zero_le_one
        _ = 1 := one_mul 1

/-- 一以下の正の底では指数を大きくすると冪は増えない
（人手証明の `t^b ≤ t^s`。指数の差への分解と一以下の冪で示す）。 -/
lemma pow_le_pow_of_le_one_of_exp_le_by_induction {t : ℝ} (ht0 : 0 < t) (ht1 : t ≤ 1) :
    ∀ {m n : ℕ}, m ≤ n → t ^ n ≤ t ^ m := by
  intro m n hmn
  obtain ⟨d, rfl⟩ := Nat.exists_eq_add_of_le hmn
  calc
    t ^ (m + d) = t ^ m * t ^ d := pow_add t m d
    _ ≤ t ^ m * 1 :=
      mul_le_mul_of_nonneg_left (pow_le_one_by_induction ht0.le ht1 d)
        (pow_pos_by_induction ht0 m).le
    _ = t ^ m := mul_one _

/-- 人手証明の「上の全単射と破れボンド数の分解」と「`t^{m+n} = t^m t^n`」の二段:
接合後の値の有限和を、対の二重和へ書き換える（第一の座標の向き）。 -/
lemma openPartitionValue_glueFirst_eq (ha : 0 < a) (hc : 0 < c) (t : ℝ) :
    openPartitionValue (a + c) b t =
      ∑ σ : OpenConfig a b, ∑ τ : OpenConfig c b,
        t ^ (openBrokenBondCount a b σ + openBrokenBondCount c b τ) *
          t ^ openSeamBrokenCountFirst a b c ha hc σ τ := by
  rw [openPartitionValue_eq_sum]
  rw [← Fintype.sum_equiv (openConfigGlueEquivFirst a b c)
    (fun p : OpenConfig a b × OpenConfig c b =>
      t ^ openBrokenBondCount (a + c) b (openConfigGlueFirst a b c p.1 p.2))
    (fun ρ => t ^ openBrokenBondCount (a + c) b ρ) (fun _ => rfl)]
  rw [Fintype.sum_prod_type]
  exact sum_congr rfl fun σ _ => sum_congr rfl fun τ _ => by
    rw [openBrokenBondCount_glueFirst a b c ha hc σ τ, pow_add]

/-- 人手証明の「有限和の分配則と冪の指数法則」の段: 値の積を二重和へ書き換える。 -/
lemma openPartitionValue_mul_eq_double_sum (a₁ b₁ a₂ b₂ : ℕ) (t : ℝ) :
    openPartitionValue a₁ b₁ t * openPartitionValue a₂ b₂ t =
      ∑ σ : OpenConfig a₁ b₁, ∑ τ : OpenConfig a₂ b₂,
        t ^ (openBrokenBondCount a₁ b₁ σ + openBrokenBondCount a₂ b₂ τ) := by
  rw [openPartitionValue_eq_sum, openPartitionValue_eq_sum, sum_mul_sum]
  exact sum_congr rfl fun σ _ => sum_congr rfl fun τ _ => (pow_add t _ _).symm

/-- `claim_open_rectangle_gluing_inequality` の第一の座標の向き、`0 < t ≤ 1` の場合:
`t^b Z^op_{a,b}(t) Z^op_{c,b}(t) ≤ Z^op_{a+c,b}(t) ≤ Z^op_{a,b}(t) Z^op_{c,b}(t)`。 -/
theorem openPartitionValue_glueFirst_bounds_of_le_one
    (ha : 0 < a) (hc : 0 < c) {t : ℝ} (ht0 : 0 < t) (ht1 : t ≤ 1) :
    t ^ b * (openPartitionValue a b t * openPartitionValue c b t) ≤
        openPartitionValue (a + c) b t ∧
      openPartitionValue (a + c) b t ≤
        openPartitionValue a b t * openPartitionValue c b t := by
  constructor
  · rw [openPartitionValue_mul_eq_double_sum a b c b t,
      openPartitionValue_glueFirst_eq a b c ha hc t, mul_sum]
    refine sum_le_sum fun σ _ => ?_
    rw [mul_sum]
    refine sum_le_sum fun τ _ => ?_
    calc
      t ^ b * t ^ (openBrokenBondCount a b σ + openBrokenBondCount c b τ)
          = t ^ (openBrokenBondCount a b σ + openBrokenBondCount c b τ) * t ^ b :=
        mul_comm _ _
      _ ≤ t ^ (openBrokenBondCount a b σ + openBrokenBondCount c b τ) *
            t ^ openSeamBrokenCountFirst a b c ha hc σ τ :=
        mul_le_mul_of_nonneg_left
          (pow_le_pow_of_le_one_of_exp_le_by_induction ht0 ht1
            (openSeamBrokenCountFirst_le a b c ha hc σ τ))
          (pow_pos_by_induction ht0 _).le
  · rw [openPartitionValue_mul_eq_double_sum a b c b t,
      openPartitionValue_glueFirst_eq a b c ha hc t]
    refine sum_le_sum fun σ _ => sum_le_sum fun τ _ => ?_
    calc
      t ^ (openBrokenBondCount a b σ + openBrokenBondCount c b τ) *
            t ^ openSeamBrokenCountFirst a b c ha hc σ τ
          ≤ t ^ (openBrokenBondCount a b σ + openBrokenBondCount c b τ) * 1 :=
        mul_le_mul_of_nonneg_left (pow_le_one_by_induction ht0.le ht1 _)
          (pow_pos_by_induction ht0 _).le
      _ = t ^ (openBrokenBondCount a b σ + openBrokenBondCount c b τ) := mul_one _

/-- `claim_open_rectangle_gluing_inequality` の第一の座標の向き、`1 ≤ t` の場合:
`Z^op_{a,b}(t) Z^op_{c,b}(t) ≤ Z^op_{a+c,b}(t) ≤ t^b Z^op_{a,b}(t) Z^op_{c,b}(t)`。 -/
theorem openPartitionValue_glueFirst_bounds_of_one_le
    (ha : 0 < a) (hc : 0 < c) {t : ℝ} (ht : 1 ≤ t) :
    openPartitionValue a b t * openPartitionValue c b t ≤
        openPartitionValue (a + c) b t ∧
      openPartitionValue (a + c) b t ≤
        t ^ b * (openPartitionValue a b t * openPartitionValue c b t) := by
  have ht0 : 0 < t := lt_of_lt_of_le zero_lt_one ht
  constructor
  · rw [openPartitionValue_mul_eq_double_sum a b c b t,
      openPartitionValue_glueFirst_eq a b c ha hc t]
    refine sum_le_sum fun σ _ => sum_le_sum fun τ _ => ?_
    calc
      t ^ (openBrokenBondCount a b σ + openBrokenBondCount c b τ)
          = t ^ (openBrokenBondCount a b σ + openBrokenBondCount c b τ) * 1 :=
        (mul_one _).symm
      _ ≤ t ^ (openBrokenBondCount a b σ + openBrokenBondCount c b τ) *
            t ^ openSeamBrokenCountFirst a b c ha hc σ τ :=
        mul_le_mul_of_nonneg_left (one_le_pow_by_induction ht _)
          (pow_pos_by_induction ht0 _).le
  · rw [openPartitionValue_mul_eq_double_sum a b c b t,
      openPartitionValue_glueFirst_eq a b c ha hc t, mul_sum]
    refine sum_le_sum fun σ _ => ?_
    rw [mul_sum]
    refine sum_le_sum fun τ _ => ?_
    calc
      t ^ (openBrokenBondCount a b σ + openBrokenBondCount c b τ) *
            t ^ openSeamBrokenCountFirst a b c ha hc σ τ
          ≤ t ^ (openBrokenBondCount a b σ + openBrokenBondCount c b τ) * t ^ b :=
        mul_le_mul_of_nonneg_left
          (pow_le_pow_of_one_le_of_exp_le_by_induction ht
            (openSeamBrokenCountFirst_le a b c ha hc σ τ))
          (pow_pos_by_induction ht0 _).le
      _ = t ^ b * t ^ (openBrokenBondCount a b σ + openBrokenBondCount c b τ) :=
        mul_comm _ _

/-- 二重和への書き換え（第二の座標の向き。人手証明の「同じ全単射・破れボンド数の分解」）。 -/
lemma openPartitionValue_glueSecond_eq (hb : 0 < b) (hc : 0 < c) (t : ℝ) :
    openPartitionValue a (b + c) t =
      ∑ σ : OpenConfig a b, ∑ τ : OpenConfig a c,
        t ^ (openBrokenBondCount a b σ + openBrokenBondCount a c τ) *
          t ^ openSeamBrokenCountSecond a b c hb hc σ τ := by
  rw [openPartitionValue_eq_sum]
  rw [← Fintype.sum_equiv (openConfigGlueEquivSecond a b c)
    (fun p : OpenConfig a b × OpenConfig a c =>
      t ^ openBrokenBondCount a (b + c) (openConfigGlueSecond a b c p.1 p.2))
    (fun ρ => t ^ openBrokenBondCount a (b + c) ρ) (fun _ => rfl)]
  rw [Fintype.sum_prod_type]
  exact sum_congr rfl fun σ _ => sum_congr rfl fun τ _ => by
    rw [openBrokenBondCount_glueSecond a b c hb hc σ τ, pow_add]

/-- `claim_open_rectangle_gluing_inequality` の第二の座標の向き、`0 < t ≤ 1` の場合:
`t^a Z^op_{a,b}(t) Z^op_{a,c}(t) ≤ Z^op_{a,b+c}(t) ≤ Z^op_{a,b}(t) Z^op_{a,c}(t)`。 -/
theorem openPartitionValue_glueSecond_bounds_of_le_one
    (hb : 0 < b) (hc : 0 < c) {t : ℝ} (ht0 : 0 < t) (ht1 : t ≤ 1) :
    t ^ a * (openPartitionValue a b t * openPartitionValue a c t) ≤
        openPartitionValue a (b + c) t ∧
      openPartitionValue a (b + c) t ≤
        openPartitionValue a b t * openPartitionValue a c t := by
  constructor
  · rw [openPartitionValue_mul_eq_double_sum a b a c t,
      openPartitionValue_glueSecond_eq a b c hb hc t, mul_sum]
    refine sum_le_sum fun σ _ => ?_
    rw [mul_sum]
    refine sum_le_sum fun τ _ => ?_
    calc
      t ^ a * t ^ (openBrokenBondCount a b σ + openBrokenBondCount a c τ)
          = t ^ (openBrokenBondCount a b σ + openBrokenBondCount a c τ) * t ^ a :=
        mul_comm _ _
      _ ≤ t ^ (openBrokenBondCount a b σ + openBrokenBondCount a c τ) *
            t ^ openSeamBrokenCountSecond a b c hb hc σ τ :=
        mul_le_mul_of_nonneg_left
          (pow_le_pow_of_le_one_of_exp_le_by_induction ht0 ht1
            (openSeamBrokenCountSecond_le a b c hb hc σ τ))
          (pow_pos_by_induction ht0 _).le
  · rw [openPartitionValue_mul_eq_double_sum a b a c t,
      openPartitionValue_glueSecond_eq a b c hb hc t]
    refine sum_le_sum fun σ _ => sum_le_sum fun τ _ => ?_
    calc
      t ^ (openBrokenBondCount a b σ + openBrokenBondCount a c τ) *
            t ^ openSeamBrokenCountSecond a b c hb hc σ τ
          ≤ t ^ (openBrokenBondCount a b σ + openBrokenBondCount a c τ) * 1 :=
        mul_le_mul_of_nonneg_left (pow_le_one_by_induction ht0.le ht1 _)
          (pow_pos_by_induction ht0 _).le
      _ = t ^ (openBrokenBondCount a b σ + openBrokenBondCount a c τ) := mul_one _

/-- `claim_open_rectangle_gluing_inequality` の第二の座標の向き、`1 ≤ t` の場合:
`Z^op_{a,b}(t) Z^op_{a,c}(t) ≤ Z^op_{a,b+c}(t) ≤ t^a Z^op_{a,b}(t) Z^op_{a,c}(t)`。 -/
theorem openPartitionValue_glueSecond_bounds_of_one_le
    (hb : 0 < b) (hc : 0 < c) {t : ℝ} (ht : 1 ≤ t) :
    openPartitionValue a b t * openPartitionValue a c t ≤
        openPartitionValue a (b + c) t ∧
      openPartitionValue a (b + c) t ≤
        t ^ a * (openPartitionValue a b t * openPartitionValue a c t) := by
  have ht0 : 0 < t := lt_of_lt_of_le zero_lt_one ht
  constructor
  · rw [openPartitionValue_mul_eq_double_sum a b a c t,
      openPartitionValue_glueSecond_eq a b c hb hc t]
    refine sum_le_sum fun σ _ => sum_le_sum fun τ _ => ?_
    calc
      t ^ (openBrokenBondCount a b σ + openBrokenBondCount a c τ)
          = t ^ (openBrokenBondCount a b σ + openBrokenBondCount a c τ) * 1 :=
        (mul_one _).symm
      _ ≤ t ^ (openBrokenBondCount a b σ + openBrokenBondCount a c τ) *
            t ^ openSeamBrokenCountSecond a b c hb hc σ τ :=
        mul_le_mul_of_nonneg_left (one_le_pow_by_induction ht _)
          (pow_pos_by_induction ht0 _).le
  · rw [openPartitionValue_mul_eq_double_sum a b a c t,
      openPartitionValue_glueSecond_eq a b c hb hc t, mul_sum]
    refine sum_le_sum fun σ _ => ?_
    rw [mul_sum]
    refine sum_le_sum fun τ _ => ?_
    calc
      t ^ (openBrokenBondCount a b σ + openBrokenBondCount a c τ) *
            t ^ openSeamBrokenCountSecond a b c hb hc σ τ
          ≤ t ^ (openBrokenBondCount a b σ + openBrokenBondCount a c τ) * t ^ a :=
        mul_le_mul_of_nonneg_left
          (pow_le_pow_of_one_le_of_exp_le_by_induction ht
            (openSeamBrokenCountSecond_le a b c hb hc σ τ))
          (pow_pos_by_induction ht0 _).le
      _ = t ^ a * t ^ (openBrokenBondCount a b σ + openBrokenBondCount a c τ) :=
        mul_comm _ _

end Ising2DLambda.ThermodynamicLimit
