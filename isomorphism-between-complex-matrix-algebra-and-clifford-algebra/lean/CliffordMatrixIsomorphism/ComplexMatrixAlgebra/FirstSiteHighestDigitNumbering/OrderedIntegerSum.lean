/-
章「複素行列環」の、整数の番号順の和とその三つの主張。人手証明と 1 対 1 に対応させる。
ℂ を含まないので、具体版と必要十分版が同じこのファイルを引く（必要十分版・導出版を置かない）。

  本文のラベル                                                      このファイル
  def_ordered_sum_of_integers                                       orderedIntSumAux・orderedIntSum（Σ_{t=a}^{b} n_t）・
                                                                    orderedIntSum_of_lt（b < a の場合）・orderedIntSum_of_le（b ≥ a の場合）
  claim_ordered_sum_of_integers_splits_off_first_term               orderedIntSum_split_first
  claim_ordered_sum_of_integers_is_unchanged_by_shifting_index      orderedIntSum_shift
  claim_ordered_sums_of_integers_with_equal_terms_are_equal         orderedIntSum_congr

{a,…,b} の上の整数の族は `ℤ → ℤ` で表し、{a,…,b} の外の値は使わない。
本文の定義は b についての帰納的な定義（b < a のとき 0、b ≥ a のとき (Σ_{t=a}^{b-1} n_t) + n_b）である。b は ℤ を動くので、
Lean では足す項の個数 (b - a + 1) の ℕ の値についての帰納的な定義 `orderedIntSumAux` で値を定め、本文の二つの場合の式を
`orderedIntSum_of_lt`・`orderedIntSum_of_le` として示す。以後の証明はこの二つの式だけを引く。
本文の「b についての帰納法」は、b = a + m（または b = (a - 1) + m）と置いた m ∈ ℕ についての帰納法で書く。
帰納法の段 m + 1 の b について、本文の b - 1 は Lean の b - 1（段 m の値）である。

組の番号の二つの主張の、和の項を番号ごとに取り替える行は、本文の claim_ordered_sums_of_integers_with_equal_terms_are_equal を引く。
Lean ではその主張を `orderedIntSum_congr` で書く（`TupleNumber.lean` が使う）。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.PowerSetNumbering.BinaryNumbering
import Mathlib.Algebra.Ring.Int.Defs

namespace CliffordMatrixIsomorphism.ComplexMatrixAlgebra

/-- 本文 `def_ordered_sum_of_integers` の値を、足す項の個数 m についての帰納法で定める：
a から始めて m 個の項 n_a, n_{a+1}, …, n_{a+m-1} を番号順に足した整数。 -/
def orderedIntSumAux (n : ℤ → ℤ) (a : ℤ) : ℕ → ℤ
  | 0 => 0
  | m + 1 => orderedIntSumAux n a m + n (a + m)

/-- 本文 `def_ordered_sum_of_integers`：Σ_{t=a}^{b} n_t。足す項の個数は b ≥ a のとき b - a + 1、b < a のとき 0。 -/
def orderedIntSum (n : ℤ → ℤ) (a b : ℤ) : ℤ :=
  orderedIntSumAux n a (b - a + 1).toNat

/-- 本文 `def_ordered_sum_of_integers` の b < a の場合：Σ_{t=a}^{b} n_t = 0。 -/
theorem orderedIntSum_of_lt (n : ℤ → ℤ) {a b : ℤ} (h : b < a) : orderedIntSum n a b = 0 := by
  have hm : (b - a + 1).toNat = 0 := by omega
  unfold orderedIntSum
  rw [hm]
  rfl

/-- 本文 `def_ordered_sum_of_integers` の b ≥ a の場合：Σ_{t=a}^{b} n_t = (Σ_{t=a}^{b-1} n_t) + n_b。 -/
theorem orderedIntSum_of_le (n : ℤ → ℤ) {a b : ℤ} (h : a ≤ b) :
    orderedIntSum n a b = orderedIntSum n a (b - 1) + n b := by
  have hm : (b - a + 1).toNat = (b - 1 - a + 1).toNat + 1 := by omega
  have hb : a + (((b - 1 - a + 1).toNat : ℕ) : ℤ) = b := by omega
  unfold orderedIntSum
  rw [hm]
  show orderedIntSumAux n a (b - 1 - a + 1).toNat + n (a + (((b - 1 - a + 1).toNat : ℕ) : ℤ))
    = orderedIntSumAux n a (b - 1 - a + 1).toNat + n b
  rw [hb]

/-- 本文 `claim_ordered_sums_of_integers_with_equal_terms_are_equal`：すべての t ∈ {a,…,b} で n_t = n'_t なら
Σ_{t=a}^{b} n_t = Σ_{t=a}^{b} n'_t。本文の b についての帰納法を、足す項の個数 m についての帰納法で書く。 -/
theorem orderedIntSum_congr (n n' : ℤ → ℤ) (a b : ℤ) (h : ∀ t : ℤ, a ≤ t → t ≤ b → n t = n' t) :
    orderedIntSum n a b = orderedIntSum n' a b := by
  have haux : ∀ m : ℕ, m ≤ (b - a + 1).toNat → orderedIntSumAux n a m = orderedIntSumAux n' a m := by
    intro m
    induction m with
    | zero => intro _; rfl
    | succ m ih =>
      intro hm
      show orderedIntSumAux n a m + n (a + m) = orderedIntSumAux n' a m + n' (a + m)
      rw [ih (by omega), h (a + m) (by omega) (by omega)]
  unfold orderedIntSum
  exact haux _ le_rfl

/-- 本文 `claim_ordered_sum_of_integers_splits_off_first_term`：a ≤ b なら Σ_{t=a}^{b} n_t = n_a + Σ_{t=a+1}^{b} n_t。 -/
theorem orderedIntSum_split_first (n : ℤ → ℤ) (a b : ℤ) (hab : a ≤ b) :
    orderedIntSum n a b = n a + orderedIntSum n (a + 1) b := by
  -- b = a + m と置き、m についての帰納法で示す
  have hm : ∀ m : ℕ, ∀ b : ℤ, b = a + m → orderedIntSum n a b = n a + orderedIntSum n (a + 1) b := by
    intro m
    induction m with
    | zero =>
      -- b = a のとき
      intro b hb
      have hba : b = a := by omega
      subst hba
      calc orderedIntSum n b b
          -- def_ordered_sum_of_integers の b ≥ a の場合
          = orderedIntSum n b (b - 1) + n b := orderedIntSum_of_le n (le_refl b)
        -- def_ordered_sum_of_integers の b < a の場合（a - 1 < a）
        _ = 0 + n b := by rw [orderedIntSum_of_lt n (by omega : b - 1 < b)]
        -- ℤ の加法の交換法則
        _ = n b + 0 := by rw [add_comm 0 (n b)]
        -- def_ordered_sum_of_integers の b < a の場合（a < a + 1）
        _ = n b + orderedIntSum n (b + 1) b := by rw [orderedIntSum_of_lt n (by omega : b < b + 1)]
    | succ m ih =>
      -- b ≥ a + 1 とし、b - 1 で成り立つとする（帰納法の仮定。b - 1 = a + m ≥ a）
      intro b hb
      have ih' := ih (b - 1) (by omega)
      calc orderedIntSum n a b
          -- def_ordered_sum_of_integers の b ≥ a の場合
          = orderedIntSum n a (b - 1) + n b := orderedIntSum_of_le n (by omega)
        -- 帰納法の仮定
        _ = (n a + orderedIntSum n (a + 1) (b - 1)) + n b := by rw [ih']
        -- ℤ の加法の結合法則
        _ = n a + (orderedIntSum n (a + 1) (b - 1) + n b) := add_assoc _ _ _
        -- def_ordered_sum_of_integers の b ≥ a + 1 の場合
        _ = n a + orderedIntSum n (a + 1) b := by rw [← orderedIntSum_of_le n (by omega : a + 1 ≤ b)]
  exact hm (b - a).toNat b (by omega)

/-- 本文 `claim_ordered_sum_of_integers_is_unchanged_by_shifting_index`：Σ_{t=a+1}^{b+1} n_t = Σ_{s=a}^{b} n_{s+1}。 -/
theorem orderedIntSum_shift (n : ℤ → ℤ) (a b : ℤ) :
    orderedIntSum n (a + 1) (b + 1) = orderedIntSum (fun s => n (s + 1)) a b := by
  -- b < a のとき（b + 1 < a + 1）
  have hbase : ∀ b : ℤ, b < a → orderedIntSum n (a + 1) (b + 1) = orderedIntSum (fun s => n (s + 1)) a b :=
    fun b hba => calc
      orderedIntSum n (a + 1) (b + 1)
          -- def_ordered_sum_of_integers の b < a の場合（b + 1 < a + 1）
          = 0 := orderedIntSum_of_lt n (by omega)
      -- def_ordered_sum_of_integers の b < a の場合
      _ = orderedIntSum (fun s => n (s + 1)) a b := (orderedIntSum_of_lt _ hba).symm
  -- b = (a - 1) + m と置き、m についての帰納法で示す
  have hm : ∀ m : ℕ, ∀ b : ℤ, b = a - 1 + m →
      orderedIntSum n (a + 1) (b + 1) = orderedIntSum (fun s => n (s + 1)) a b := by
    intro m
    induction m with
    | zero => intro b hb; exact hbase b (by omega)
    | succ m ih =>
      -- b ≥ a とし、b - 1 で成り立つとする（帰納法の仮定）
      intro b hb
      have ih' := ih (b - 1) (by omega)
      calc orderedIntSum n (a + 1) (b + 1)
          -- def_ordered_sum_of_integers の b ≥ a の場合（b + 1 ≥ a + 1）
          = orderedIntSum n (a + 1) (b + 1 - 1) + n (b + 1) := orderedIntSum_of_le n (by omega)
        -- b + 1 - 1 = b
        _ = orderedIntSum n (a + 1) b + n (b + 1) := by rw [add_sub_cancel_right]
        -- b = (b - 1) + 1
        _ = orderedIntSum n (a + 1) (b - 1 + 1) + n (b + 1) := by rw [sub_add_cancel]
        -- 帰納法の仮定
        _ = orderedIntSum (fun s => n (s + 1)) a (b - 1) + n (b + 1) := by rw [ih']
        -- def_ordered_sum_of_integers の b ≥ a の場合
        _ = orderedIntSum (fun s => n (s + 1)) a b := (orderedIntSum_of_le _ (by omega : a ≤ b)).symm
  by_cases hba : b < a
  · exact hbase b hba
  · exact hm (b - a + 1).toNat b (by omega)

end CliffordMatrixIsomorphism.ComplexMatrixAlgebra
