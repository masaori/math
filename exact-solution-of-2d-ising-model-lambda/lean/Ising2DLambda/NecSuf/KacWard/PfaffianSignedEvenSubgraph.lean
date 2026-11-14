import Mathlib

/-!
「反対称化した行列の Pfaffian は符号付き偶部分グラフ多項式に等しい」
（`claim_pfaffian_signed_even_subgraph`）の式鎖の五行目から八行目
（二次符号を指数の形へ書き、切断線偶奇を巻き付き偶奇へ替え、係数を送る段）の必要十分版。

具体版 `Ising2DLambda.KacWard.gaugedPfaffian_eq_signedEvenSubgraphPolynomial` の五行目以降と同じ手順
（各項の符号を送り先の符号の像に書く → 二つの偶奇を取り替える → 環準同型で和と積を戻す）を、
次の仮定だけで行う。

* 補辺の型 `Y` と偶奇の型 `B` は任意で、`W` は有限集合であればよい。格子・巻き付きの定義は使わない。
* 送り先の符号 `χ` は、各補辺の偶奇の組で、送り元の符号 `φ` の像に等しい（`hsign`。具体版の
  `def_torus_quadratic_sign` と指数の偶奇）。`W` の外の偶奇の組には何も要求しない。
* 二つの偶奇は `W` の上で一致する（`hh`・`hv`。具体版の切断線偶奇と巻き付き偶奇の一致）。
* `f` は半環の準同型で、和と積を保つことだけを使う（具体版の係数の包含 `ℤ ↪ Qbar`）。
  単射性・可換性・減法は使わない。
-/

namespace Ising2DLambda.NecSuf.KacWard

open Finset

theorem sum_sign_weights_eq_map_of_parity_agreement
    {Y B R S : Type*} [Semiring R] [Semiring S]
    (W : Finset Y) (f : R →+* S) (χ : B → B → S) (φ : B → B → R)
    (h v h' v' : Y → B) (w : Y → R)
    (hsign : ∀ y ∈ W, χ (h y) (v y) = f (φ (h y) (v y)))
    (hh : ∀ y ∈ W, h y = h' y) (hv : ∀ y ∈ W, v y = v' y) :
    ∑ y ∈ W, χ (h y) (v y) * f (w y) = f (∑ y ∈ W, φ (h' y) (v' y) * w y) := by
  calc ∑ y ∈ W, χ (h y) (v y) * f (w y)
      = ∑ y ∈ W, f (φ (h y) (v y)) * f (w y) := by
        -- 各補辺の符号を送り元の符号の像に書く
        apply Finset.sum_congr rfl
        intro y hy
        rw [hsign y hy]
    _ = ∑ y ∈ W, f (φ (h' y) (v' y)) * f (w y) := by
        -- 二つの偶奇を取り替える
        apply Finset.sum_congr rfl
        intro y hy
        rw [hh y hy, hv y hy]
    _ = f (∑ y ∈ W, φ (h' y) (v' y) * w y) := by
        -- 準同型は積と有限和を保つ
        rw [map_sum]
        apply Finset.sum_congr rfl
        intro y _
        rw [map_mul]

end Ising2DLambda.NecSuf.KacWard
