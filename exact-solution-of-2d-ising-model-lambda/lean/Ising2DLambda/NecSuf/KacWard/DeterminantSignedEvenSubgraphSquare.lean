import Mathlib

/-!
「Kac--Ward 行列式は符号付き偶部分グラフ多項式の平方に等しい」
（`claim_determinant_signed_even_subgraph_square`）の必要十分版。

具体版 `Ising2DLambda.KacWard.kacWardDeterminant_eq_signedEvenSubgraphPolynomial_sq` と同じ三行
（行列式の一致 → Pfaffian の平方公式 → Pfaffian の値の代入）を、次の仮定だけで行う。

* 行列の型 `M` と値の型 `R` は任意の型でよい。環の構造は使わない。
* 行列式 `det` と Pfaffian `pf` は `M → R` の写像でありさえすればよい。置換展開・完全マッチング展開の
  中身は使わない（それは二行目・三行目の仮定 `hpf`・`hQ` が担う）。
* 平方 `sq` は `R → R` の写像でありさえすればよい。三行目で `pf K` を `Q` に替えるとき、
  等しいものに同じ写像を施すと等しいことだけを使う。乗法・単位元・可換性は使わない。
* 三つの仮定はどれも削れない。`hdet` が無ければ `D` と行列 `K` が結ばれず、`hpf` が無ければ
  行列式と Pfaffian が結ばれず、`hQ` が無ければ Pfaffian の値と `Q` が結ばれない。
-/

namespace Ising2DLambda.NecSuf.KacWard

theorem eq_sq_of_det_eq_of_pfaffian_sq_eq_det
    {M R : Type*} (det pf : M → R) (sq : R → R) (K : M) (D Q : R)
    (hdet : det K = D) (hpf : sq (pf K) = det K) (hQ : pf K = Q) :
    D = sq Q := by
  calc D
      = det K := hdet.symm
        -- 一行目: 行列式の一致
    _ = sq (pf K) := hpf.symm
        -- 二行目: Pfaffian の平方公式
    _ = sq Q := by
        -- 三行目: Pfaffian の値の代入
        rw [hQ]

end Ising2DLambda.NecSuf.KacWard
