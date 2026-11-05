/-
# 転置で不変な行列の冪級数の部分和と極限は転置で不変（必要十分版）

具体版: `Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimExpOfSymmetricIsSymmetric.lean`
（人手 `exp_of_symmetric_is_symmetric`）。具体版をこのファイルの特殊化として得るのは
`Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimExpOfSymmetricIsSymmetricFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `identity_transpose_tensorPow`（`(I^⊤)_{kl}` の 4 段） | `one_transpose_matrix'` の同じ 4 段 |
| `tensorPow_mul_pow_comm`（`SS^m = S^mS` の帰納法の 4 段と 4 段） | `mul_pow_comm_self'` の同じ段 |
| `tensorPow_pow_transpose_of_transpose_eq`（`(S^m)^⊤ = S^m` の帰納法の 3 段と 6 段） | `pow_transpose_of_transpose_eq'` の同じ段 |
| `expPartialSum_transpose_apply`（`((E_N)^⊤)_{kl}` の 5 段）と `expPartialSum_transpose` | `partialSum_transpose_apply'` の同じ 5 段と `partialSum_transpose'` |
| `matExp_transpose_of_transpose_eq` の極限の段（`transpose_preserves_matrix_limits` と極限の一意性） | `limit_transpose_of_forall_transpose_eq'` の同じ段（`limit_transpose_of_transpose_eq'` は部分和の段と合わせる） |

## 何が効いているか / 効いていないか

- `SS^m = S^mS` は、行列であることも係数も効かず、積の結合法則と単位元だけで通る（任意の `Monoid`）。
- `(S^m)^⊤ = S^m` で効いているのは、積の転置が転置を逆の順に掛けた積であること（`transpose_mul_matrix'`。係数の**積の交換律**が要る）と、
  単位行列の転置が単位行列であることである。係数の積の交換律は削れない: `S^⊤ = S` のとき
  `((S^2)^⊤)_{kl} = (S^2)_{lk} = Σ_j S_{lj}S_{jk}`、`(S^2)_{kl} = Σ_j S_{kj}S_{jl} = Σ_j S_{jk}S_{lj}` で、係数が非可換なら一般には一致しない
  （`n = 2`、`S = [[a,b],[b,c]]` で `((S^2)^⊤)_{21} = (S^2)_{12} = ab + bc`、`(S^2)_{21} = ba + cb`。`c = 0` とし `a, b` を `ab ≠ ba` の四元数に取れば（例 `a = i`, `b = j` で `ij = k`, `ji = −k`）異なる）。
- 部分和の段で効いているのは、和とスカラー倍が成分ごとであることだけである。係数の列 `c` は任意で、
  `1/m!` であること（`exp` であること）は効いていない。係数 `c m` の型 `K` は `α` へスカラー倍で作用しさえすればよい。
- 極限の段（`limit_transpose_of_forall_transpose_eq'`）で効いているのは、列の各項が転置で不変であること、転置が極限を保つこと
  （`transpose_tendsto'`）と、極限の一意性だけである。列が冪級数の部分和であることも、係数の積も効かず、係数の型は `NormedAddCommGroup` だけを仮定する。
  一意性には、ノルムが `‖x‖ = 0 → x = 0` を満たすことが要る: すべての元のセミノルムが `0` なら収束の仮定はどの `L` でも成り立ち、転置で不変でない `L` で結論が偽になる。
- `limit_transpose_of_transpose_eq'` は部分和の段と極限の段を合わせるだけである。ここで係数を `NormedCommRing` とするのは、
  可換な積（部分和の段）とノルム（極限の段）を同じ型に持たせるためで、`‖xy‖ ≤ ‖x‖‖y‖` は効いていない。
  `exp` の級数が収束することの証明は使わない（収束は仮定 `h` で受け取る）。
-/
import Ising2D.NecSuf.TransposeOfMatrixProduct
import Ising2D.NecSuf.TransposePreservesMatrixNormAndLimits
import Mathlib.Analysis.Normed.Ring.Basic

namespace Ising2D.NecSuf

open Matrix Filter Topology

attribute [local instance] Matrix.frobeniusNormedAddCommGroup

/-- **単位行列の転置は単位行列**（具体版 `identity_transpose_tensorPow`）。係数は `0` と `1` があればよい。 -/
theorem one_transpose_matrix' {n α : Type*} [DecidableEq n] [Zero α] [One α] :
    (1 : Matrix n n α)ᵀ = 1 :=
  Matrix.ext fun k l =>
    calc (1 : Matrix n n α)ᵀ k l
        = (1 : Matrix n n α) l k := rfl                                -- 転置の定義
      _ = if l = k then 1 else 0 := Matrix.one_apply                 -- 単位行列の定義
      _ = if k = l then 1 else 0 := by simp only [eq_comm]           -- `l = k` と `k = l` は同じ条件
      _ = (1 : Matrix n n α) k l := Matrix.one_apply.symm            -- 単位行列の定義

/-- **`SS^m = S^mS`**（具体版 `tensorPow_mul_pow_comm`）。積の結合法則と単位元だけ（任意の `Monoid`）。 -/
theorem mul_pow_comm_self' {R : Type*} [Monoid R] (S : R) (m : ℕ) : S * S ^ m = S ^ m * S := by
  induction m with
  | zero =>
    calc S * S ^ 0 = S * 1 := by rw [pow_zero]
      _ = S := mul_one S
      _ = 1 * S := (one_mul S).symm
      _ = S ^ 0 * S := by rw [pow_zero]
  | succ m ih =>
    calc S * S ^ (m + 1) = S * (S ^ m * S) := by rw [pow_succ]
      _ = (S * S ^ m) * S := (mul_assoc _ _ _).symm
      _ = (S ^ m * S) * S := by rw [ih]
      _ = S ^ (m + 1) * S := by rw [pow_succ]

/-- **`S^⊤ = S` なら `(S^m)^⊤ = S^m`**（具体版 `tensorPow_pow_transpose_of_transpose_eq`）。係数は可換半環。 -/
theorem pow_transpose_of_transpose_eq' {n α : Type*} [Fintype n] [DecidableEq n] [CommSemiring α]
    (S : Matrix n n α) (hS : Sᵀ = S) (m : ℕ) : (S ^ m)ᵀ = S ^ m := by
  induction m with
  | zero =>
    calc (S ^ 0)ᵀ = (1 : Matrix n n α)ᵀ := by rw [pow_zero]
      _ = 1 := one_transpose_matrix'
      _ = S ^ 0 := (pow_zero S).symm
  | succ m ih =>
    calc (S ^ (m + 1))ᵀ = (S ^ m * S)ᵀ := by rw [pow_succ]
      _ = Sᵀ * (S ^ m)ᵀ := transpose_mul_matrix' _ _
      _ = S * (S ^ m)ᵀ := by rw [hS]
      _ = S * S ^ m := by rw [ih]
      _ = S ^ m * S := mul_pow_comm_self' S m
      _ = S ^ (m + 1) := (pow_succ S m).symm

/-- **部分和の成分の鎖**（具体版 `expPartialSum_transpose_apply`）。係数の列 `c` は任意。 -/
theorem partialSum_transpose_apply' {n α K : Type*} [Fintype n] [DecidableEq n] [CommSemiring α]
    [SMul K α] (c : ℕ → K) (S : Matrix n n α) (hS : Sᵀ = S) (N : ℕ) (k l : n) :
    (∑ m ∈ Finset.range (N + 1), c m • S ^ m)ᵀ k l
      = (∑ m ∈ Finset.range (N + 1), c m • S ^ m) k l :=
  calc (∑ m ∈ Finset.range (N + 1), c m • S ^ m)ᵀ k l
      = (∑ m ∈ Finset.range (N + 1), c m • S ^ m) l k := rfl                      -- 転置の定義
    _ = ∑ m ∈ Finset.range (N + 1), c m • (S ^ m) l k := by
        simp only [Matrix.sum_apply, Matrix.smul_apply]                            -- 成分の式
    _ = ∑ m ∈ Finset.range (N + 1), c m • (S ^ m)ᵀ k l := rfl                      -- 転置の定義を各項へ
    _ = ∑ m ∈ Finset.range (N + 1), c m • (S ^ m) k l := by
        simp only [pow_transpose_of_transpose_eq' S hS]                            -- `(S^m)^⊤ = S^m` を各項へ
    _ = (∑ m ∈ Finset.range (N + 1), c m • S ^ m) k l := by
        simp only [Matrix.sum_apply, Matrix.smul_apply]                            -- 成分の式

/-- **部分和は転置で不変**（具体版 `expPartialSum_transpose`）。 -/
theorem partialSum_transpose' {n α K : Type*} [Fintype n] [DecidableEq n] [CommSemiring α]
    [SMul K α] (c : ℕ → K) (S : Matrix n n α) (hS : Sᵀ = S) (N : ℕ) :
    (∑ m ∈ Finset.range (N + 1), c m • S ^ m)ᵀ = ∑ m ∈ Finset.range (N + 1), c m • S ^ m :=
  Matrix.ext (partialSum_transpose_apply' c S hS N)   -- 全ての成分が一致する

/-- **各項が転置で不変な列の極限は転置で不変**（具体版 `matExp_transpose_of_transpose_eq` の極限の段）。
係数はノルムの定まる加法群だけで、積は効かない。 -/
theorem limit_transpose_of_forall_transpose_eq' {n α : Type*} [Fintype n] [NormedAddCommGroup α]
    (E : ℕ → Matrix n n α) (hE : ∀ N, (E N)ᵀ = E N) (L : Matrix n n α)
    (h : Tendsto (fun N => ‖E N - L‖) atTop (𝓝 0)) :
    Lᵀ = L := by
  -- 転置が極限を保つ
  have hT := transpose_tendsto' E L h
  -- 各項は転置で不変なので、同じ列が `L^⊤` へも収束する
  simp only [hE] at hT
  -- 極限の一意性
  exact tendsto_nhds_unique (tendsto_iff_norm_sub_tendsto_zero.2 hT)
    (tendsto_iff_norm_sub_tendsto_zero.2 h)

/-- **部分和の極限は転置で不変**（具体版 `matExp_transpose_of_transpose_eq`。部分和の段と極限の段を合わせる）。 -/
theorem limit_transpose_of_transpose_eq' {n α K : Type*} [Fintype n] [DecidableEq n] [NormedCommRing α]
    [SMul K α] (c : ℕ → K) (S : Matrix n n α) (hS : Sᵀ = S) (L : Matrix n n α)
    (h : Tendsto (fun N => ‖(∑ m ∈ Finset.range (N + 1), c m • S ^ m) - L‖) atTop (𝓝 0)) :
    Lᵀ = L :=
  limit_transpose_of_forall_transpose_eq' (fun N => ∑ m ∈ Finset.range (N + 1), c m • S ^ m)
    (partialSum_transpose' c S hS) L h

end Ising2D.NecSuf
