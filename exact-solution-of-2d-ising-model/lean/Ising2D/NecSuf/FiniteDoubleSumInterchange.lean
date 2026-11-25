/-
# 零の有限和と、二重の有限和の順序の入れ替え（**必要十分版**）

具体版: `Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimFiniteSumsOfRealNumbers.lean`
（人手 `finite_sum_of_real_zeros`・`finite_double_sum_of_real_numbers_interchange`。`structured-latex/content/000_calculation_formulae_00_09.ts` の
`calc_formulae_claim_finite_sum_of_real_zeros`・`calc_formulae_claim_finite_double_sum_of_real_numbers_interchange`）。
具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimFiniteSumsOfRealNumbersFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `finite_double_sum_of_real_numbers_interchange_succ`（外側の項の数 `p + 1` についての帰納法。内側の項の数 `q` は 0 を含む。`p = 1` の 2 段: 和の定義 → 和の定義を各項へ。帰納法の段の 4 段: 和の定義 → 帰納法の仮定 → `finite_sum_of_real_sums` を右辺から左辺へ → 和の定義を各項へ） | `finite_double_sum_interchange_succ'`（同じ並び。3 段目は `finite_sum_add_fin'`） |
| `finite_sum_of_real_zeros_succ`（`m = 1` の 1 段: 和の定義。帰納法の段の 3 段: 和の定義 → 帰納法の仮定 → `0 + 0 = 0`） | `finite_sum_zero_fin_succ'`（同じ並び） |
| `finite_sum_of_real_zeros`（`m = 0` は空の和の 1 段。`m ≥ 1` は `_succ`） | `finite_sum_zero_fin'`（同じ並び） |
| `finite_double_sum_of_real_numbers_interchange`（`p = 0` の 3 段: 空の和 → 零の有限和を右辺から左辺へ → 空の和を各項へ。`p ≥ 1` は `_succ`） | `finite_double_sum_interchange_fin'`（同じ並び。2 段目は `finite_sum_zero_fin'`） |
| `finite_double_sum_of_real_numbers_interchange_fintype`（有限型の添字に番号を付けて当てる） | `finite_double_sum_interchange'`（同じ並び） |

## 何が効いているか / 効いていないか

- 効いているのは**加法の結合律と交換律だけ**である（帰納法の段の 3 段目 `finite_sum_add_fin'` が使うのがこの二つ）。
  加法の零は `Finset.sum` の定義（`AddCommMonoid` が要求する）と `p = 0` の段（空の和と零の有限和）にだけ現れ、`p ≥ 1` の帰納法では効いていない。
- 零の有限和に効いているのは、`0` が加法の単位元であること（`0 + 0 = 0`）だけである。
- 加法の逆元・乗法・順序は効いていない。実数であることは効いていない。
- 添字は有限であること（`Fintype`）だけが効く。人手の左から足す和は番号 `1, …, p` の順に足すので、一般の有限型では
  `Fintype.equivFin` で番号を付けてから同じ帰納法を使う（番号を付ける段と外す段は mathlib の `Equiv.sum_comp` による。
  この段は人手には無く、番号の付け方に依らないことを自前では示していない）。
-/
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Logic.Equiv.Fintype
import Ising2D.NecSuf.MatMulDistribSum

namespace Ising2D.NecSuf

variable {R : Type*} [AddCommMonoid R]

/-- **`Σ_{j=1}^{m+1} 0 = 0`**（具体版 `finite_sum_of_real_zeros_succ`）。`m` についての帰納法。 -/
theorem finite_sum_zero_fin_succ' (m : ℕ) : ∑ _j : Fin (m + 1), (0 : R) = 0 := by
  induction m with
  | zero =>
    calc ∑ _j : Fin 1, (0 : R) = 0 := Fin.sum_univ_one _                   -- 和の定義（1 項）
  | succ m ih =>
    calc ∑ _j : Fin (m + 2), (0 : R)
        = (∑ _j : Fin (m + 1), (0 : R)) + 0 := Fin.sum_univ_castSucc (fun _ => (0 : R))   -- 和の定義
      _ = 0 + 0 := by rw [ih]                                              -- 帰納法の仮定
      _ = 0 := add_zero 0                                                  -- `0` は加法の単位元

/-- `Fin m` の上の零の和（空の和を含む。具体版 `finite_sum_of_real_zeros`）。 -/
theorem finite_sum_zero_fin' (m : ℕ) : ∑ _j : Fin m, (0 : R) = 0 := by
  cases m with
  | zero => calc ∑ _j : Fin 0, (0 : R) = 0 := Fin.sum_univ_zero _          -- 空の和
  | succ m => exact finite_sum_zero_fin_succ' m

/-- **`Σ_{k=1}^{p+1} Σ_{l=1}^{q} a_{k,l} = Σ_{l=1}^{q} Σ_{k=1}^{p+1} a_{k,l}`**（具体版 `finite_double_sum_of_real_numbers_interchange_succ`）。
`p` についての帰納法。 -/
theorem finite_double_sum_interchange_succ' (p q : ℕ) (a : Fin (p + 1) → Fin q → R) :
    ∑ k, ∑ l, a k l = ∑ l, ∑ k, a k l := by
  induction p with
  | zero =>
    calc ∑ k : Fin 1, ∑ l, a k l
        = ∑ l, a 0 l := Fin.sum_univ_one _                                   -- 和の定義（1 項）
      _ = ∑ l, ∑ k : Fin 1, a k l :=
          Finset.sum_congr rfl fun l _ => (Fin.sum_univ_one (fun k => a k l)).symm   -- 和の定義（1 項）を各 `l` の項へ
  | succ p ih =>
    calc ∑ k : Fin (p + 2), ∑ l, a k l
        = (∑ k : Fin (p + 1), ∑ l, a k.castSucc l) + ∑ l, a (Fin.last _) l :=
          Fin.sum_univ_castSucc _                                             -- 和の定義
      _ = (∑ l, ∑ k : Fin (p + 1), a k.castSucc l) + ∑ l, a (Fin.last _) l := by
          rw [ih (fun k l => a k.castSucc l)]                                 -- 帰納法の仮定
      _ = ∑ l, ((∑ k : Fin (p + 1), a k.castSucc l) + a (Fin.last _) l) :=
          (finite_sum_add_fin' q _ _).symm                                  -- 有限和を二つに分ける段を右辺から左辺へ
      _ = ∑ l, ∑ k, a k l :=
          Finset.sum_congr rfl fun l _ => (Fin.sum_univ_castSucc (fun k => a k l)).symm   -- 和の定義を各 `l` の項へ

/-- `Fin p`・`Fin q` の上の二重の和（空の和を含む。具体版 `finite_double_sum_of_real_numbers_interchange`）。 -/
theorem finite_double_sum_interchange_fin' (p q : ℕ) (a : Fin p → Fin q → R) :
    ∑ k, ∑ l, a k l = ∑ l, ∑ k, a k l := by
  cases p with
  | zero =>
    calc ∑ k : Fin 0, ∑ l, a k l
        = 0 := Fin.sum_univ_zero _                                           -- 空の和
      _ = ∑ _l : Fin q, (0 : R) := (finite_sum_zero_fin' q).symm             -- 零の有限和を右辺から左辺へ
      _ = ∑ l, ∑ k : Fin 0, a k l :=
          Finset.sum_congr rfl fun l _ => (Fin.sum_univ_zero (fun k => a k l)).symm   -- 空の和を各 `l` の項へ
  | succ p => exact finite_double_sum_interchange_succ' p q a

/-- 有限型 `κ`・`ι` の上の二重の和（具体版 `finite_double_sum_of_real_numbers_interchange_fintype`）。
`Fintype.equivFin` で番号を付け、`finite_double_sum_interchange_fin'` を使う。 -/
theorem finite_double_sum_interchange' {κ ι : Type*} [Fintype κ] [Fintype ι] (a : κ → ι → R) :
    ∑ k, ∑ l, a k l = ∑ l, ∑ k, a k l := by
  set e := Fintype.equivFin κ
  set f := Fintype.equivFin ι
  calc ∑ k, ∑ l, a k l
      = ∑ k : Fin (Fintype.card κ), ∑ l, a (e.symm k) l :=
        (e.symm.sum_comp (fun k => ∑ l, a k l)).symm                          -- `κ` に番号を付ける
    _ = ∑ k : Fin (Fintype.card κ), ∑ l : Fin (Fintype.card ι), a (e.symm k) (f.symm l) :=
        Finset.sum_congr rfl fun k _ => (f.symm.sum_comp (fun l => a (e.symm k) l)).symm   -- `ι` に番号を付ける（各 `k` の項へ）
    _ = ∑ l : Fin (Fintype.card ι), ∑ k : Fin (Fintype.card κ), a (e.symm k) (f.symm l) :=
        finite_double_sum_interchange_fin' _ _ _                              -- `Fin` の上の入れ替え
    _ = ∑ l : Fin (Fintype.card ι), ∑ k, a k (f.symm l) :=
        Finset.sum_congr rfl fun l _ => e.symm.sum_comp (fun k => a k (f.symm l))   -- `κ` の番号を外す（各 `l` の項へ）
    _ = ∑ l, ∑ k, a k l := f.symm.sum_comp (fun l => ∑ k, a k l)               -- `ι` の番号を外す

end Ising2D.NecSuf
