/-
# 抽象版: 行列の冪のトレースは「閉じた道」の重みの総和

対応する人手証明のラベル: **`partition_function_via_transfer_matrix`**
（001 章 `structured-latex/content/001_partition_function_2d_ising.ts` の Step 2・Step 3。
具体版は `Ising2D/Part010/Claim007_PartitionFunction.lean`）

## この主張に本質的に効いている構造は何か

人手証明の Step 2（`(A^m)_{μ,μ'} = ∑_{中間配置} ∏_k A_{μ^{(k)},μ^{(k+1)}}`）と
Step 3（`tr(A^M) = ∑_{全配置} ∏_k A_{μ^{(k)},μ^{(k+1)}}`、ただし `μ^{(M+1)} = μ^{(1)}`）に
効いているのは、次の 2 点だけである。

* 行列の積とトレースの定義（有限和・有限積の組み替え）。
* 添字集合が**有限**で、係数が**可換半環**であること。

効いていないもの: Ising 模型であること、成分が `exp` の形をしていること、
添字集合がスピン配置であること、係数が複素数・体であること、
可逆性・ノルム・位相のいずれも。実際、本ファイルの主張は
**任意の可換半環 `R` 上の任意の有限添字行列**について成り立つ。

人手証明が「有限集合上の二重和を直積集合上の一重和にまとめる」と書いている操作は、
Lean では `Fin.consEquiv` / `Fin.snocEquiv` による添字の付け替えにあたる。
-/
import Mathlib.LinearAlgebra.Matrix.Trace
import Mathlib.Data.Fin.Tuple.Basic
import Mathlib.Algebra.BigOperators.Fin

namespace Ising2D.Abstract

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {R : Type*} [CommSemiring R]

/-! ## 巡回する添字 -/

/-- 巡回後者 `k ↦ k+1`（`k = n-1` では `0` へ巻き戻る）。
`Ising2D.nextSite` と同じ定義であり、そちらは本定義の特殊化として扱える。 -/
def cycSucc {n : ℕ} (k : Fin n) : Fin n := ⟨((k : ℕ) + 1) % n, Nat.mod_lt _ k.pos⟩

theorem cycSucc_castSucc {m : ℕ} (k : Fin m) :
    cycSucc (k.castSucc : Fin (m + 1)) = k.succ := by
  apply Fin.ext
  show ((k : ℕ) + 1) % (m + 1) = (k : ℕ) + 1
  exact Nat.mod_eq_of_lt (by omega)

theorem cycSucc_last (m : ℕ) : cycSucc (Fin.last m) = 0 := by
  apply Fin.ext
  show ((m : ℕ) + 1) % (m + 1) = 0
  simp

/-! ## 開いた道の重み -/

/-- `w : Fin (n+1) → ι` の各点を順にたどり、最後に `j` へ抜ける道の重み。
人手証明の `∏_{k=1}^{m} A_{μ^{(k)},μ^{(k+1)}}` にあたる。 -/
def openW (A : Matrix ι ι R) {n : ℕ} (w : Fin (n + 1) → ι) (j : ι) : R :=
  (∏ k : Fin n, A (w k.castSucc) (w k.succ)) * A (w (Fin.last n)) j

/-- 道を 1 歩伸ばす。 -/
theorem openW_snoc (A : Matrix ι ι R) {n : ℕ} (w : Fin (n + 1) → ι) (c j : ι) :
    openW A (Fin.snoc w c) j = openW A w c * A c j := by
  rw [openW, openW, Fin.prod_univ_castSucc]
  have h1 : ∀ k : Fin n,
      A ((Fin.snoc w c : Fin (n + 2) → ι) k.castSucc.castSucc)
        ((Fin.snoc w c : Fin (n + 2) → ι) k.castSucc.succ)
        = A (w k.castSucc) (w k.succ) := by
    intro k
    rw [Fin.snoc_castSucc, Fin.succ_castSucc, Fin.snoc_castSucc]
  have h2 : A ((Fin.snoc w c : Fin (n + 2) → ι) (Fin.last n).castSucc)
      ((Fin.snoc w c : Fin (n + 2) → ι) (Fin.last n).succ) = A (w (Fin.last n)) c := by
    rw [Fin.snoc_castSucc, Fin.succ_last, Fin.snoc_last]
  rw [Finset.prod_congr rfl (fun k _ => h1 k), h2, Fin.snoc_last]

/-! ## 冪の成分と、トレース -/

/-- **人手証明 Step 2**: `(A^{n+1})_{i,j}` は長さ `n+1` の道の重みの総和である。 -/
theorem pow_succ_apply_eq_sum (A : Matrix ι ι R) :
    ∀ (n : ℕ) (i j : ι), (A ^ (n + 1)) i j = ∑ p : Fin n → ι, openW A (Fin.cons i p) j
  | 0, i, j => by
      simp [openW, pow_one]
  | n + 1, i, j => by
      rw [pow_succ, Matrix.mul_apply]
      have hstep : ∀ c : ι, (A ^ (n + 1)) i c * A c j
          = ∑ p : Fin n → ι, openW A (Fin.cons i p) c * A c j := by
        intro c
        rw [pow_succ_apply_eq_sum A n i c, Finset.sum_mul]
      rw [Finset.sum_congr rfl (fun c _ => hstep c)]
      -- 右辺を `q = snoc p c` で組み替える
      have hre : (∑ q : Fin (n + 1) → ι, openW A (Fin.cons i q) j)
          = ∑ cp : ι × (Fin n → ι), openW A (Fin.cons i (Fin.snoc cp.2 cp.1)) j := by
        refine (Fintype.sum_equiv (Fin.snocEquiv (fun _ : Fin (n + 1) => ι)) _ _ ?_).symm
        intro cp
        rfl
      rw [hre, Fintype.sum_prod_type]
      refine Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun p _ => ?_
      rw [Fin.cons_snoc_eq_snoc_cons, openW_snoc]

/-- **人手証明 Step 3**: `tr(A^{n+1})` は「閉じた道」（周期境界条件つきの配置）の
重みの総和である。 -/
theorem trace_pow_succ (A : Matrix ι ι R) (m : ℕ) :
    (A ^ (m + 1)).trace
      = ∑ s : Fin (m + 1) → ι, ∏ k : Fin (m + 1), A (s k) (s (cycSucc k)) := by
  have hclosed : ∀ s : Fin (m + 1) → ι,
      (∏ k : Fin (m + 1), A (s k) (s (cycSucc k))) = openW A s (s 0) := by
    intro s
    rw [openW, Fin.prod_univ_castSucc, cycSucc_last]
    refine congrArg₂ (· * ·) ?_ rfl
    exact Finset.prod_congr rfl fun k _ => by rw [cycSucc_castSucc]
  have hRHS : (∑ s : Fin (m + 1) → ι, ∏ k : Fin (m + 1), A (s k) (s (cycSucc k)))
      = ∑ ip : ι × (Fin m → ι), openW A (Fin.cons ip.1 ip.2) ip.1 := by
    refine (Fintype.sum_equiv (Fin.consEquiv (fun _ : Fin (m + 1) => ι))
      (fun ip => openW A (Fin.cons ip.1 ip.2) ip.1)
      (fun s => ∏ k : Fin (m + 1), A (s k) (s (cycSucc k))) ?_).symm
    intro ip
    rw [hclosed]
    simp [Fin.consEquiv]
  rw [Matrix.trace, hRHS, Fintype.sum_prod_type]
  simp only [Matrix.diag_apply]
  exact Finset.sum_congr rfl fun i _ => pow_succ_apply_eq_sum A m i i

end Ising2D.Abstract
