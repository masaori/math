/-
# エルミート行列の冪級数の部分和と極限はエルミート（必要十分版）

具体版: `Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimExpOfHermitianIsHermitian.lean`
（人手 `exp_of_hermitian_is_hermitian`）。具体版をこのファイルの特殊化として得るのは
`Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimExpOfHermitianIsHermitianFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `star_identity_entry_tensorPow`（`\overline{δ_{lk}} = δ_{lk}` の場合分け） | `star_ite_one_zero'` の同じ場合分け（`star 1 = 1`・`star 0 = 0` は仮定 `h1`・`h0`） |
| `identity_conjTranspose_tensorPow`（`(I^*)_{kl}` の 5 段） | `one_conjTranspose_matrix'` の同じ 5 段 |
| `tensorPow_mul_pow_comm`（`SS^m = S^mS`） | `mul_pow_comm_self'`（`SeriesOfSymmetricIsSymmetric.lean`。転置の版と共用） |
| `tensorPow_pow_conjTranspose_of_conjTranspose_eq`（`(S^m)^* = S^m` の帰納法の 3 段と 6 段） | `pow_conjTranspose_of_conjTranspose_eq'` の同じ段 |
| `expPartialSum_conjTranspose_apply`（`((E_N)^*)_{kl}` の 8 段）と `expPartialSum_conjTranspose` | `partialSum_conjTranspose_apply'` の同じ 8 段と `partialSum_conjTranspose'` |
| `matExp_conjTranspose_of_conjTranspose_eq` の極限の段（`star_preserves_norm_and_limits` (3) と極限の一意性） | `limit_conjTranspose_of_forall_conjTranspose_eq'` の同じ段（`limit_conjTranspose_of_conjTranspose_eq'` は部分和の段と合わせる） |

## 何が効いているか / 効いていないか

複素共役の性質は、具体版が使った形のまま仮定にした（`StarPreservesNormAndLimits.lean` と同じ書き方）。共役が対合であること
（`\overline{\overline{z}} = z`）はどの段でも効いていない。

- `I^* = I` で効いているのは、共役が `1` と `0` を動かさないこと（`h1`・`h0`）だけである。係数に積も和も要らない。
- `(S^m)^* = S^m` で効いているのは、積の共役転置が共役転置を逆の順に掛けた積であること（`conjTranspose_mul_matrix'`。共役が有限和と交換すること `hsum`、
  積を同じ順の積へ移すこと `hmul`、係数の**積の交換律**が要る）と、`I^* = I` である。
  係数の積の交換律は削れない: 共役を恒等写像に取ると `S^* = S^⊤` なので、転置の版（`SeriesOfSymmetricIsSymmetric.lean`）の反例
  （`S = [[i, j], [j, 0]]`、係数は四元数）がそのまま `(S^2)^* ≠ S^2` を与える（恒等写像は `hsum`・`hmul`・`h0`・`h1` を満たす）。
- 部分和の段で効いているのは、`(S^m)^* = S^m`（上の段の仮定）に加えて、和とスカラー倍が成分ごとであること、
  共役が `Finset.range` の上の有限和と交換すること（`hsumRange`）、`hmul`、係数の列の各項が共役で動かないこと
  （`hc`。具体版では `(1/m!)_ℂ` が実数の像であること）だけである。上の段の `h0`（`star 0 = 0`）は `hsumRange` の空の和から出るので、
  この段からは仮定に置かない（`star_zero_of_star_sum_range'`）。`(S^m)^* = S^m` の段だけでは、添字の型が空でない限り `h0` は他の仮定から出ないので残す。
  `1/m!` であること（`exp` であること）は効いていない。係数を `α` の元に取るのは、具体版の 4 行目が `\overline{(1/m!)_ℂ\,(S^m)_{lk}}` を
  `hmul` で分ける段で、係数と成分が同じ型の積であることを使うからである。
  `hc` は削れない: `α = ℂ`、`S = I`、`c 0 = i_ℂ`、`c m = 0`（`m ≥ 1`）なら `E_0 = i_ℂ I` で `E_0^* = −i_ℂ I ≠ E_0`。
- 極限の段（`limit_conjTranspose_of_forall_conjTranspose_eq'`）で効いているのは、列の各項がエルミートであること、共役転置が極限を保つこと
  （`conjTranspose_tendsto'`。共役が成分のノルムを保つこと `hnorm` と差と交換すること `hsub`）と、極限の一意性だけである。
  一意性には、ノルムが `‖x‖ = 0 → x = 0` を満たすことが要る（`NormedAddCommGroup`）: すべての元のセミノルムが `0` なら収束の仮定はどの `L` でも成り立ち、
  エルミートでない `L` で結論が偽になる。
- `limit_conjTranspose_of_conjTranspose_eq'` は部分和の段と極限の段を合わせるだけである。係数を `NormedCommRing` とするのは、
  可換な積（部分和の段）とノルム（極限の段）を同じ型に持たせるためで、`‖xy‖ ≤ ‖x‖‖y‖` は効いていない。
  `CommSemiring α` と `NormedAddCommGroup α` を別々に仮定すると、加法の構造が 2 つ入って型クラスが衝突するので、両方を持つ最小の既製のクラスとして置いた。
  `exp` の級数が収束することの証明は使わない（収束は仮定 `h` で受け取る）。
-/
import Ising2D.NecSuf.StarPreservesNormAndLimits
import Ising2D.NecSuf.SeriesOfSymmetricIsSymmetric

namespace Ising2D.NecSuf

open Matrix Filter Topology

attribute [local instance] Matrix.frobeniusNormedAddCommGroup

/-- **`\overline{δ_{lk}} = δ_{lk}`**（具体版 `star_identity_entry_tensorPow`）。共役が `1` と `0` を動かさないことだけ。 -/
theorem star_ite_one_zero' {α : Type*} [Zero α] [One α] [Star α]
    (h0 : star (0 : α) = 0) (h1 : star (1 : α) = 1) (p : Prop) [Decidable p] :
    star (if p then (1 : α) else 0) = if p then (1 : α) else 0 := by
  by_cases h : p
  · rw [if_pos h]                                                                -- `δ = 1`
    exact h1
  · rw [if_neg h]                                                                -- `δ = 0`
    exact h0

/-- **単位行列の共役転置は単位行列**（具体版 `identity_conjTranspose_tensorPow`）。 -/
theorem one_conjTranspose_matrix' {n α : Type*} [DecidableEq n] [Zero α] [One α] [Star α]
    (h0 : star (0 : α) = 0) (h1 : star (1 : α) = 1) :
    (1 : Matrix n n α)ᴴ = 1 :=
  Matrix.ext fun k l =>
    calc (1 : Matrix n n α)ᴴ k l
        = star ((1 : Matrix n n α) l k) := rfl                                   -- 共役転置の定義
      _ = star (if l = k then (1 : α) else 0) := by rw [Matrix.one_apply]       -- 単位行列の定義
      _ = if l = k then (1 : α) else 0 := star_ite_one_zero' h0 h1 _             -- `\overline{δ_{lk}} = δ_{lk}`
      _ = if k = l then (1 : α) else 0 := by simp only [eq_comm]                -- `l = k` と `k = l` は同じ条件
      _ = (1 : Matrix n n α) k l := Matrix.one_apply.symm                        -- 単位行列の定義

/-- **`S^* = S` なら `(S^m)^* = S^m`**（具体版 `tensorPow_pow_conjTranspose_of_conjTranspose_eq`）。係数は可換半環。 -/
theorem pow_conjTranspose_of_conjTranspose_eq' {n α : Type*} [Fintype n] [DecidableEq n] [CommSemiring α] [Star α]
    (hsum : ∀ f : n → α, star (∑ j, f j) = ∑ j, star (f j))
    (hmul : ∀ a b : α, star (a * b) = star a * star b)
    (h0 : star (0 : α) = 0) (h1 : star (1 : α) = 1)
    (S : Matrix n n α) (hS : Sᴴ = S) (m : ℕ) : (S ^ m)ᴴ = S ^ m := by
  induction m with
  | zero =>
    calc (S ^ 0)ᴴ = (1 : Matrix n n α)ᴴ := by rw [pow_zero]
      _ = 1 := one_conjTranspose_matrix' h0 h1
      _ = S ^ 0 := (pow_zero S).symm
  | succ m ih =>
    calc (S ^ (m + 1))ᴴ = (S ^ m * S)ᴴ := by rw [pow_succ]
      _ = Sᴴ * (S ^ m)ᴴ := conjTranspose_mul_matrix' hsum hmul _ _
      _ = S * (S ^ m)ᴴ := by rw [hS]
      _ = S * S ^ m := by rw [ih]
      _ = S ^ m * S := mul_pow_comm_self' S m
      _ = S ^ (m + 1) := (pow_succ S m).symm

/-- 共役が `Finset.range` の上の有限和と交換するなら、空の和から `star 0 = 0` が出る。部分和の段は `(S^m)^* = S^m` を通して
`star 0 = 0` を使うが、それを別の仮定に置かずに `hsumRange` の `N = 0` から作る（仮定を必要十分にするため）。 -/
theorem star_zero_of_star_sum_range' {α : Type*} [AddCommMonoid α] [Star α]
    (hsumRange : ∀ (N : ℕ) (f : ℕ → α), star (∑ m ∈ Finset.range N, f m) = ∑ m ∈ Finset.range N, star (f m)) :
    star (0 : α) = 0 := by
  simpa using hsumRange 0 (fun _ => 0)

/-- **部分和の成分の鎖**（具体版 `expPartialSum_conjTranspose_apply`）。係数の列 `c` の各項は共役で動かない（`hc`）。 -/
theorem partialSum_conjTranspose_apply' {n α : Type*} [Fintype n] [DecidableEq n] [CommSemiring α] [Star α]
    (hsum : ∀ f : n → α, star (∑ j, f j) = ∑ j, star (f j))
    (hsumRange : ∀ (N : ℕ) (f : ℕ → α), star (∑ m ∈ Finset.range N, f m) = ∑ m ∈ Finset.range N, star (f m))
    (hmul : ∀ a b : α, star (a * b) = star a * star b)
    (h1 : star (1 : α) = 1)
    (c : ℕ → α) (hc : ∀ m, star (c m) = c m)
    (S : Matrix n n α) (hS : Sᴴ = S) (N : ℕ) (k l : n) :
    (∑ m ∈ Finset.range (N + 1), c m • S ^ m)ᴴ k l
      = (∑ m ∈ Finset.range (N + 1), c m • S ^ m) k l :=
  calc (∑ m ∈ Finset.range (N + 1), c m • S ^ m)ᴴ k l
      = star ((∑ m ∈ Finset.range (N + 1), c m • S ^ m) l k) := rfl                -- 共役転置の定義
    _ = star (∑ m ∈ Finset.range (N + 1), c m * (S ^ m) l k) := by
        simp only [Matrix.sum_apply, Matrix.smul_apply, smul_eq_mul]               -- 成分の式
    _ = ∑ m ∈ Finset.range (N + 1), star (c m * (S ^ m) l k) := hsumRange _ _      -- 共役と有限和
    _ = ∑ m ∈ Finset.range (N + 1), star (c m) * star ((S ^ m) l k) :=
        Finset.sum_congr rfl fun _ _ => hmul _ _                                   -- 共役と積を各項へ
    _ = ∑ m ∈ Finset.range (N + 1), c m * star ((S ^ m) l k) := by
        simp only [hc]                                                             -- 係数は共役で動かない（各項へ）
    _ = ∑ m ∈ Finset.range (N + 1), c m * (S ^ m)ᴴ k l := rfl                      -- 共役転置の定義を各項へ
    _ = ∑ m ∈ Finset.range (N + 1), c m * (S ^ m) k l := by
        simp only [pow_conjTranspose_of_conjTranspose_eq' hsum hmul
          (star_zero_of_star_sum_range' hsumRange) h1 S hS]                          -- `(S^m)^* = S^m` を各項へ
    _ = (∑ m ∈ Finset.range (N + 1), c m • S ^ m) k l := by
        simp only [Matrix.sum_apply, Matrix.smul_apply, smul_eq_mul]               -- 成分の式

/-- **部分和はエルミート**（具体版 `expPartialSum_conjTranspose`）。 -/
theorem partialSum_conjTranspose' {n α : Type*} [Fintype n] [DecidableEq n] [CommSemiring α] [Star α]
    (hsum : ∀ f : n → α, star (∑ j, f j) = ∑ j, star (f j))
    (hsumRange : ∀ (N : ℕ) (f : ℕ → α), star (∑ m ∈ Finset.range N, f m) = ∑ m ∈ Finset.range N, star (f m))
    (hmul : ∀ a b : α, star (a * b) = star a * star b)
    (h1 : star (1 : α) = 1)
    (c : ℕ → α) (hc : ∀ m, star (c m) = c m)
    (S : Matrix n n α) (hS : Sᴴ = S) (N : ℕ) :
    (∑ m ∈ Finset.range (N + 1), c m • S ^ m)ᴴ = ∑ m ∈ Finset.range (N + 1), c m • S ^ m :=
  Matrix.ext (partialSum_conjTranspose_apply' hsum hsumRange hmul h1 c hc S hS N)   -- 全ての成分が一致する

/-- **各項がエルミートな列の極限はエルミート**（具体版 `matExp_conjTranspose_of_conjTranspose_eq` の極限の段）。
係数はノルムの定まる加法群と共役だけで、積は効かない。 -/
theorem limit_conjTranspose_of_forall_conjTranspose_eq' {n α : Type*} [Fintype n] [NormedAddCommGroup α] [Star α]
    (hnorm : ∀ a : α, ‖star a‖ = ‖a‖) (hsub : ∀ a b : α, star (a - b) = star a - star b)
    (E : ℕ → Matrix n n α) (hE : ∀ N, (E N)ᴴ = E N) (L : Matrix n n α)
    (h : Tendsto (fun N => ‖E N - L‖) atTop (𝓝 0)) :
    Lᴴ = L := by
  -- 共役転置が極限を保つ
  have hT := conjTranspose_tendsto' hnorm hsub E L h
  -- 各項はエルミートなので、同じ列が `L^*` へも収束する
  simp only [hE] at hT
  -- 極限の一意性
  exact tendsto_nhds_unique (tendsto_iff_norm_sub_tendsto_zero.2 hT)
    (tendsto_iff_norm_sub_tendsto_zero.2 h)

/-- **部分和の極限はエルミート**（具体版 `matExp_conjTranspose_of_conjTranspose_eq`。部分和の段と極限の段を合わせる）。 -/
theorem limit_conjTranspose_of_conjTranspose_eq' {n α : Type*} [Fintype n] [DecidableEq n] [NormedCommRing α] [Star α]
    (hsum : ∀ f : n → α, star (∑ j, f j) = ∑ j, star (f j))
    (hsumRange : ∀ (N : ℕ) (f : ℕ → α), star (∑ m ∈ Finset.range N, f m) = ∑ m ∈ Finset.range N, star (f m))
    (hmul : ∀ a b : α, star (a * b) = star a * star b)
    (h1 : star (1 : α) = 1)
    (hnorm : ∀ a : α, ‖star a‖ = ‖a‖) (hsub : ∀ a b : α, star (a - b) = star a - star b)
    (c : ℕ → α) (hc : ∀ m, star (c m) = c m)
    (S : Matrix n n α) (hS : Sᴴ = S) (L : Matrix n n α)
    (h : Tendsto (fun N => ‖(∑ m ∈ Finset.range (N + 1), c m • S ^ m) - L‖) atTop (𝓝 0)) :
    Lᴴ = L :=
  limit_conjTranspose_of_forall_conjTranspose_eq' hnorm hsub
    (fun N => ∑ m ∈ Finset.range (N + 1), c m • S ^ m)
    (partialSum_conjTranspose' hsum hsumRange hmul h1 c hc S hS) L h

end Ising2D.NecSuf
