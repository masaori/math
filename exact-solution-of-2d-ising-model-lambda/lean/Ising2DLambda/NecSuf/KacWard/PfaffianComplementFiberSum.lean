import Mathlib

/-!
「反対称化した行列の Pfaffian は符号付き偶部分グラフ多項式に等しい」
（`claim_pfaffian_signed_even_subgraph`）の式鎖の一行目から四行目
（展開の非零項を補辺ごとに束ね、各項の位相を代入し、局所対合の符号付き和を代入する段）の必要十分版。

具体版 `Ising2DLambda.KacWard.gaugedPfaffian_eq_seamSignedEvenSubgraphSum` と同じ手順
（零の項を落とす → 補辺ごとの有限和へ再添字付けする → 各項を「補辺の重み × 項の符号」に書き換える
→ 分配則で補辺の重みを外へ出す → 符号の和の一を代入する）を、次の仮定だけで行う。

* 項の型 `X` と補辺の型 `Y` は任意で、項の集合 `S` と補辺の集合 `W` は有限集合であればよい。
  完全マッチング・標識・格子・偶部分グラフの定義は使わない。
* 非零の項の補辺は `W` に属する（`hmaps`。具体版の `claim_tagged_matching_even_complement`）。
  零の項には何も要求しない。零の項の補辺が `W` の外にあっても和は変わらないので、
  この仮定を全ての項へ強めない。
* 非零の項は「補辺の重み `c` × 項の符号 `ε`」に等しい（`hweight`。具体版の
  `claim_tagged_matching_quadratic_crossing_weight`）。
* 各補辺の上の非零項の符号の和は一である（`hsign`。具体版の `claim_local_pairing_signed_sum`）。
* 値は `NonAssocSemiring`。分配則（重みを和の外へ出す）と乗法の単位元（`c * 1 = c`）だけを使う。
  乗法の結合性・可換性・減法は使わない。
-/

namespace Ising2DLambda.NecSuf.KacWard

open Finset
open scoped Classical

theorem sum_eq_sum_over_complements_of_fiber_signs
    {X Y R : Type*} [DecidableEq Y] [NonAssocSemiring R]
    (S : Finset X) (W : Finset Y) (f : X → R) (g : X → Y) (c : Y → R) (ε : X → R)
    (hmaps : ∀ x ∈ S, f x ≠ 0 → g x ∈ W)
    (hweight : ∀ x ∈ S, f x ≠ 0 → f x = c (g x) * ε x)
    (hsign : ∀ y ∈ W, ∑ x ∈ S.filter (fun x => f x ≠ 0 ∧ g x = y), ε x = 1) :
    ∑ x ∈ S, f x = ∑ y ∈ W, c y := by
  calc ∑ x ∈ S, f x
      = ∑ x ∈ S.filter (fun x => f x ≠ 0), f x := by
        -- 零の項は和に寄与しない
        exact (Finset.sum_filter_ne_zero S).symm
    _ = ∑ y ∈ W, ∑ x ∈ (S.filter (fun x => f x ≠ 0)).filter (fun x => g x = y), f x := by
        -- 非零の項の補辺は `W` に属するので、補辺ごとの和へ再添字付けする
        refine (Finset.sum_fiberwise_of_maps_to (fun x hx => ?_) f).symm
        obtain ⟨hxS, hx0⟩ := Finset.mem_filter.mp hx
        exact hmaps x hxS hx0
    _ = ∑ y ∈ W, ∑ x ∈ S.filter (fun x => f x ≠ 0 ∧ g x = y), c y * ε x := by
        -- 各非零項を「補辺の重み × 項の符号」に書き換える
        apply Finset.sum_congr rfl
        intro y _
        rw [Finset.filter_filter]
        apply Finset.sum_congr rfl
        intro x hx
        obtain ⟨hxS, hx0, hxy⟩ := Finset.mem_filter.mp hx
        rw [hweight x hxS hx0, hxy]
    _ = ∑ y ∈ W, c y * ∑ x ∈ S.filter (fun x => f x ≠ 0 ∧ g x = y), ε x := by
        -- 分配則
        apply Finset.sum_congr rfl
        intro y _
        exact (Finset.mul_sum _ _ _).symm
    _ = ∑ y ∈ W, c y := by
        -- 各補辺の上の符号の和は一
        apply Finset.sum_congr rfl
        intro y hy
        rw [hsign y hy, mul_one]

end Ising2DLambda.NecSuf.KacWard
