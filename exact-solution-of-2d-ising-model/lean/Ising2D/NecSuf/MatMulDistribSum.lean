/-
# 行列の積は因子の和に分配する（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimMatMultDistributesOverSum.lean`
（人手 `finite_sum_of_complex_sums`・`mat_mult_distributes_over_sum_in_right_factor`・`mat_mult_distributes_over_sum_in_left_factor`）。
具体版をこのファイルの系として導くのは `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimMatMultDistributesOverSumFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `finite_sum_of_complex_sums_step`（結合則 → 結合則 → 交換則 → 結合則 → 結合則） | `finite_sum_add_step'`（同じ並び） |
| `finite_sum_of_complex_sums_succ`（`n + 1` 項の帰納法。`Σ_{j=1}^{1}` と `Σ_{j=1}^{n+1} = (Σ_{j=1}^{n}) + (n+1 項目)` の定義 → 帰納法の仮定 → 上の 5 段 → 定義） | `finite_sum_add_succ'`（同じ並び） |
| `finite_sum_of_complex_sums`（`n = 0` は空の和。人手には無い） | `finite_sum_add_fin'` |
| （具体版の添字は `Fin n` なので無い。`TensorPow M` の系が縮める添字 `Conf M` のために使う） | `finite_sum_add'`（有限型 `κ` の上の和を `Fintype.equivFin` で `Fin (card κ)` の上の和へ番号付けし直してから `finite_sum_add_fin'` を使う） |
| `mul_add_matrix_apply`（積の定義 → 和の定義 → 分配則を各項へ → 有限和を二つに分ける → 積の定義 → 和の定義） | `mul_add_matrix_apply'`（同じ並び） |
| `add_mul_matrix_apply`（同上。分配則は右分配則） | `add_mul_matrix_apply'`（同じ並び） |

## 何が効いているか / 効いていないか

- 有限和を二つに分ける段で効いているのは、**加法の結合則と交換則だけ**である（`AddCommMonoid`）。加法の零は `Finset.sum` の定義と
  `n = 0`（空の和。人手には無い）にだけ現れ、帰納法の段では効いていない。加法の逆元は効いていない。
- 行列の積の分配で効いているのは、係数の**左分配則**（`A(B + C)`。`LeftDistribClass`）または**右分配則**（`(A + B)C`。`RightDistribClass`）
  と、上の有限和の分配だけである。
- **乗法の結合則・単位元・可換則は効いていない**（`Mul` だけを仮定した）。`0 * x = 0` も効いていない。
  複素数であること、体であることは効いていない。
- 積の中で縮める添字は有限であること（`Fintype`）だけが効く。人手の左から足す和は番号 `1, …, n` の順に足すので、
  一般の有限型 `κ` では `Fintype.equivFin κ` で番号を付けてから同じ帰納法を使う（番号を付ける段と外す段は mathlib の `Equiv.sum_comp` による。この段は具体版には無く、番号の付け方に依らないことを自前では示していない）。
-/
import Mathlib.Data.Matrix.Mul
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Logic.Equiv.Fintype

namespace Ising2D.NecSuf

open Matrix

variable {R : Type*}

/-- **帰納法の段の 5 行**（具体版 `finite_sum_of_complex_sums_step`）: `(α + β) + (x + y) = (α + x) + (β + y)`。加法の結合則と交換則だけを使う。 -/
theorem finite_sum_add_step' [AddCommSemigroup R] (α β x y : R) :
    (α + β) + (x + y) = (α + x) + (β + y) :=
  calc (α + β) + (x + y)
      = α + (β + (x + y)) := add_assoc _ _ _                                 -- 結合則
    _ = α + ((β + x) + y) := by rw [add_assoc β x y]                         -- 結合則
    _ = α + ((x + β) + y) := by rw [add_comm β x]                            -- 交換則
    _ = α + (x + (β + y)) := by rw [add_assoc x β y]                         -- 結合則
    _ = (α + x) + (β + y) := (add_assoc _ _ _).symm                          -- 結合則

/-- **`Σ_{j=1}^{n+1}(a_j + b_j) = Σ a_j + Σ b_j`**（具体版 `finite_sum_of_complex_sums_succ`）。`n` についての帰納法。 -/
theorem finite_sum_add_succ' [AddCommMonoid R] (n : ℕ) (a b : Fin (n + 1) → R) :
    ∑ j, (a j + b j) = (∑ j, a j) + ∑ j, b j := by
  induction n with
  | zero =>
    calc ∑ j : Fin 1, (a j + b j)
        = a 0 + b 0 := Fin.sum_univ_one _                                    -- 和の定義（1 項）
      _ = (∑ j : Fin 1, a j) + ∑ j : Fin 1, b j := by
          rw [Fin.sum_univ_one a, Fin.sum_univ_one b]                         -- 和の定義（1 項）を 2 か所
  | succ n ih =>
    calc ∑ j : Fin (n + 2), (a j + b j)
        = (∑ j : Fin (n + 1), (a j.castSucc + b j.castSucc)) + (a (Fin.last _) + b (Fin.last _)) :=
          Fin.sum_univ_castSucc _                                             -- 和の定義（項を 1 つ足す）
      _ = ((∑ j : Fin (n + 1), a j.castSucc) + ∑ j : Fin (n + 1), b j.castSucc)
            + (a (Fin.last _) + b (Fin.last _)) := by
          rw [ih (fun j => a j.castSucc) (fun j => b j.castSucc)]             -- 帰納法の仮定
      _ = ((∑ j : Fin (n + 1), a j.castSucc) + a (Fin.last _))
            + ((∑ j : Fin (n + 1), b j.castSucc) + b (Fin.last _)) :=
          finite_sum_add_step' _ _ _ _                                         -- 結合則・交換則の 5 段
      _ = (∑ j, a j) + ∑ j, b j := by
          rw [Fin.sum_univ_castSucc a, Fin.sum_univ_castSucc b]               -- 和の定義を 2 か所

/-- `Fin n` の上の和（`n = 0` を含む。具体版 `finite_sum_of_complex_sums`）。 -/
theorem finite_sum_add_fin' [AddCommMonoid R] (n : ℕ) (a b : Fin n → R) :
    ∑ j, (a j + b j) = (∑ j, a j) + ∑ j, b j := by
  cases n with
  | zero => rw [Fin.sum_univ_zero, Fin.sum_univ_zero, Fin.sum_univ_zero, add_zero]   -- 空の和（人手には無い）
  | succ n => exact finite_sum_add_succ' n a b

/-- 有限型 `κ` の上の和。`κ` に `Fintype.equivFin` で番号を付け、`finite_sum_add_fin'` を使う。 -/
theorem finite_sum_add' [AddCommMonoid R] {κ : Type*} [Fintype κ] (a b : κ → R) :
    ∑ j, (a j + b j) = (∑ j, a j) + ∑ j, b j := by
  let e := Fintype.equivFin κ
  calc ∑ j, (a j + b j)
      = ∑ t : Fin (Fintype.card κ), (a (e.symm t) + b (e.symm t)) :=
        (Equiv.sum_comp e.symm (fun j => a j + b j)).symm                    -- 番号を付ける
    _ = (∑ t, a (e.symm t)) + ∑ t, b (e.symm t) := finite_sum_add_fin' _ _ _
    _ = (∑ j, a j) + ∑ j, b j := by rw [Equiv.sum_comp e.symm a, Equiv.sum_comp e.symm b]  -- 番号を外す

variable {ι κ μ : Type*}

/-- **`(A(B + C))_{ik} = (AB + AC)_{ik}`**（具体版 `mul_add_matrix_apply`）。係数は `AddCommMonoid`・`Mul`・左分配則だけ。 -/
theorem mul_add_matrix_apply' [AddCommMonoid R] [Mul R] [LeftDistribClass R] [Fintype κ]
    (A : Matrix ι κ R) (B C : Matrix κ μ R) (i : ι) (k : μ) :
    (A * (B + C)) i k = (A * B + A * C) i k :=
  calc (A * (B + C)) i k
      = ∑ j, A i j * (B + C) j k := rfl                                      -- 積の定義
    _ = ∑ j, A i j * (B j k + C j k) := rfl                                  -- 和の定義
    _ = ∑ j, (A i j * B j k + A i j * C j k) :=
        Finset.sum_congr rfl fun _ _ => left_distrib _ _ _                    -- 左分配則を各項へ
    _ = (∑ j, A i j * B j k) + ∑ j, A i j * C j k := finite_sum_add' _ _     -- 有限和を二つに分ける
    _ = (A * B) i k + (A * C) i k := rfl                                     -- 積の定義を 2 か所
    _ = (A * B + A * C) i k := rfl                                           -- 和の定義

/-- **`A(B + C) = AB + AC`**（具体版 `mul_add_matrix`）。 -/
theorem mul_add_matrix' [AddCommMonoid R] [Mul R] [LeftDistribClass R] [Fintype κ]
    (A : Matrix ι κ R) (B C : Matrix κ μ R) : A * (B + C) = A * B + A * C :=
  Matrix.ext (mul_add_matrix_apply' A B C)   -- 全ての成分が一致する

/-- **`((A + B)C)_{ik} = (AC + BC)_{ik}`**（具体版 `add_mul_matrix_apply`）。係数は `AddCommMonoid`・`Mul`・右分配則だけ。 -/
theorem add_mul_matrix_apply' [AddCommMonoid R] [Mul R] [RightDistribClass R] [Fintype κ]
    (A B : Matrix ι κ R) (C : Matrix κ μ R) (i : ι) (k : μ) :
    ((A + B) * C) i k = (A * C + B * C) i k :=
  calc ((A + B) * C) i k
      = ∑ j, (A + B) i j * C j k := rfl                                      -- 積の定義
    _ = ∑ j, (A i j + B i j) * C j k := rfl                                  -- 和の定義
    _ = ∑ j, (A i j * C j k + B i j * C j k) :=
        Finset.sum_congr rfl fun _ _ => right_distrib _ _ _                   -- 右分配則を各項へ
    _ = (∑ j, A i j * C j k) + ∑ j, B i j * C j k := finite_sum_add' _ _     -- 有限和を二つに分ける
    _ = (A * C) i k + (B * C) i k := rfl                                     -- 積の定義を 2 か所
    _ = (A * C + B * C) i k := rfl                                           -- 和の定義

/-- **`(A + B)C = AC + BC`**（具体版 `add_mul_matrix`）。 -/
theorem add_mul_matrix' [AddCommMonoid R] [Mul R] [RightDistribClass R] [Fintype κ]
    (A B : Matrix ι κ R) (C : Matrix κ μ R) : (A + B) * C = A * C + B * C :=
  Matrix.ext (add_mul_matrix_apply' A B C)   -- 全ての成分が一致する

end Ising2D.NecSuf
