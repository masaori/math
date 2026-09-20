/-
章「Onsager 閉形式への接続」の
「右半直線との交差奇偶で定めた内側セルは有限個である」
（`claim_odd_ray_interior_cells_bounded`）の具体版。

平面持ち上げの頂点列を整数座標列 `row`, `col` で表す。右半直線交差数は、
水準 `r` を横切る縦辺のうち列座標が `c` より右にあるものの有限和である。
閉路の水準横断数が上下で等しいことから左側では交差数が偶数になり、ほかの三方向では
外接矩形の外に交差辺がないことから交差数が零になる。
-/
import Ising2DLambda.Tools.IntegerSequenceLevelCrossing
import Mathlib
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

open BigOperators Ising2DLambda.Tools

/-- 頂点 `(row k, col k)` から始まる第 `k` 辺が水準 `r` を縦に横切ること。 -/
def crossesRowLevel (row : ℕ → ℤ) (r : ℤ) (k : ℕ) : Prop :=
  (row k = r ∧ row (k + 1) = r + 1) ∨
  (row k = r + 1 ∧ row (k + 1) = r)

instance crossesRowLevelDecidable (row : ℕ → ℤ) (r : ℤ) (k : ℕ) :
    Decidable (crossesRowLevel row r k) := by
  unfold crossesRowLevel
  infer_instance

/-- セル `(r,c)` の中心から右へ延びる半直線と縦辺との交差数。 -/
def rightRayCrossingCount (n : ℕ) (row col : ℕ → ℤ) (r c : ℤ) : ℕ :=
  ∑ k ∈ Finset.range n,
    if crossesRowLevel row r k ∧ c < col k then 1 else 0

/-- 右半直線交差数が奇数であるセルの集合。 -/
def oddRayInteriorCells (n : ℕ) (row col : ℕ → ℤ) : Set (ℤ × ℤ) :=
  {p | Odd (rightRayCrossingCount n row col p.1 p.2)}

private theorem odd_ne_zero {n : ℕ} (hn : Odd n) : n ≠ 0 := by
  rcases hn with ⟨k, hk⟩
  omega

/-- 行の下側では水準を横切る辺がない。 -/
theorem rightRayCrossingCount_eq_zero_of_row_lt
    (n : ℕ) (row col : ℕ → ℤ) (rMin r c : ℤ)
    (hrow : ∀ k ≤ n, rMin ≤ row k) (hr : r < rMin) :
    rightRayCrossingCount n row col r c = 0 := by
  unfold rightRayCrossingCount
  apply Finset.sum_eq_zero
  intro k hk
  rw [if_neg]
  rintro ⟨hcross, -⟩
  have hklt : k < n := Finset.mem_range.mp hk
  rcases hcross with hcross | hcross
  · exact (not_lt_of_ge (hrow k (Nat.le_of_lt hklt))) (hcross.1 ▸ hr)
  · exact (not_lt_of_ge (hrow (k + 1) (by omega))) (hcross.2 ▸ hr)

/-- 行の上側では水準を横切る辺がない。 -/
theorem rightRayCrossingCount_eq_zero_of_row_ge
    (n : ℕ) (row col : ℕ → ℤ) (rMax r c : ℤ)
    (hrow : ∀ k ≤ n, row k ≤ rMax) (hr : rMax ≤ r) :
    rightRayCrossingCount n row col r c = 0 := by
  unfold rightRayCrossingCount
  apply Finset.sum_eq_zero
  intro k hk
  rw [if_neg]
  rintro ⟨hcross, -⟩
  have hklt : k < n := Finset.mem_range.mp hk
  rcases hcross with hcross | hcross
  · have := hrow (k + 1) (by omega)
    omega
  · have := hrow k (Nat.le_of_lt hklt)
    omega

/-- 列の右側では半直線と交差する辺がない。 -/
theorem rightRayCrossingCount_eq_zero_of_col_ge
    (n : ℕ) (row col : ℕ → ℤ) (cMax r c : ℤ)
    (hcol : ∀ k < n, col k ≤ cMax) (hc : cMax ≤ c) :
    rightRayCrossingCount n row col r c = 0 := by
  unfold rightRayCrossingCount
  apply Finset.sum_eq_zero
  intro k hk
  rw [if_neg]
  rintro ⟨-, hright⟩
  exact (not_lt_of_ge (le_trans (hcol k (Finset.mem_range.mp hk)) hc)) hright

/-- 列の左側では全ての水準横断を数え、閉路なのでその個数は偶数になる。 -/
theorem rightRayCrossingCount_even_of_col_lt
    (n : ℕ) (row col : ℕ → ℤ) (cMin r c : ℤ)
    (hcol : ∀ k < n, cMin ≤ col k) (hc : c < cMin)
    (hclosed : row n = row 0)
    (hstep : ∀ k < n, row (k + 1) - row k = -1 ∨
      row (k + 1) - row k = 0 ∨ row (k + 1) - row k = 1) :
    Even (rightRayCrossingCount n row col r c) := by
  have hcrossing := integerSequence_levelCrossing n row r hstep
  have hendpoint : endpointCrossingValue r (row 0) (row n) = 0 := by
    rw [hclosed]
    unfold endpointCrossingValue
    split_ifs <;> omega
  have hdiff : (upCrossingCount n row r : ℤ) -
      (downCrossingCount n row r : ℤ) = 0 := by
    rw [hcrossing, hendpoint]
  have hud : upCrossingCount n row r = downCrossingCount n row r := by
    omega
  have hcount : rightRayCrossingCount n row col r c =
      upCrossingCount n row r + downCrossingCount n row r := by
    unfold rightRayCrossingCount upCrossingCount downCrossingCount
    rw [← Finset.sum_add_distrib]
    apply Finset.sum_congr rfl
    intro k hk
    have hright : c < col k := lt_of_lt_of_le hc (hcol k (Finset.mem_range.mp hk))
    simp only [crossesRowLevel, hright, and_true]
    split_ifs <;> omega
  rw [hcount, hud]
  exact ⟨downCrossingCount n row r, by omega⟩

/-- `claim_odd_ray_interior_cells_bounded` の具体版。 -/
theorem oddRayInteriorCells_finite
    (n : ℕ) (row col : ℕ → ℤ) (rMin rMax cMin cMax : ℤ)
    (hrow : ∀ k ≤ n, rMin ≤ row k ∧ row k ≤ rMax)
    (hcol : ∀ k < n, cMin ≤ col k ∧ col k ≤ cMax)
    (hclosed : row n = row 0)
    (hstep : ∀ k < n, row (k + 1) - row k = -1 ∨
      row (k + 1) - row k = 0 ∨ row (k + 1) - row k = 1) :
    (oddRayInteriorCells n row col).Finite := by
  apply Set.Finite.subset
    (Set.Finite.prod (Set.finite_Ico rMin rMax) (Set.finite_Ico cMin cMax))
  rintro ⟨r, c⟩ hodd
  change Odd (rightRayCrossingCount n row col r c) at hodd
  constructor
  · constructor
    · by_contra h
      exact odd_ne_zero hodd
        (rightRayCrossingCount_eq_zero_of_row_lt n row col rMin r c
          (fun k hk => (hrow k hk).1) (lt_of_not_ge h))
    · by_contra h
      exact odd_ne_zero hodd
        (rightRayCrossingCount_eq_zero_of_row_ge n row col rMax r c
          (fun k hk => (hrow k hk).2) (le_of_not_gt h))
  · constructor
    · by_contra h
      have hc : c < cMin := lt_of_not_ge h
      have heven := rightRayCrossingCount_even_of_col_lt n row col cMin r c
        (fun k hk => (hcol k hk).1) hc hclosed hstep
      exact (Nat.not_odd_iff_even.mpr heven) hodd
    · by_contra h
      exact odd_ne_zero hodd
        (rightRayCrossingCount_eq_zero_of_col_ge n row col cMax r c
          (fun k hk => (hcol k hk).2) (le_of_not_gt h))

end Ising2DLambda.KacWard
