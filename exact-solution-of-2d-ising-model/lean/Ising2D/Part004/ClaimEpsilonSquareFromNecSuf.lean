/-
# `ε²=I` — 具体版を必要十分版の特殊化として導出する

対応する人手証明のラベル: `<epsilon_square_identity>`。

具体版 `Ising2D.epsilon_mul_self` は
`Ising2D/Part004/Definition000_TransferMatrixSymbols.lean` にあり、必要十分版
`Ising2D.NecSuf.prefix_terminal_mul_self` は
`Ising2D/NecSuf/EpsilonSquare.lean` にある。

## 本文・具体版・必要十分版の段対応

* サイト作用素積を一因子ずつ伸ばす有限帰納法:
  `sigmaXPrefixProduct_eq_xString` / `NecSuf.prefix_eq_of_same_recursion`。
* 全因子クロネッカー積同士の積を因子別の積へ移す段:
  `siteProd_mul` / モノイド準同型の `map_mul`。
* `(σˣ)²=I₂` と単位因子のクロネッカー積:
  `pauliX_mul_pauliX`, `siteProd_one` / `hfactor`, `map_one`。
-/
import Ising2D.NecSuf.EpsilonSquare
import Ising2D.Part004.Definition000_TransferMatrixSymbols

namespace Ising2D

/-- 因子族への `siteProd` は積と単位元を保つ。必要十分版へ渡す具体的な準同型。 -/
noncomputable def siteProdMonoidHom (M : ℕ) :
    MonoidHom (Fin M → Matrix (Fin 2) (Fin 2) ℂ) (TensorPow M) where
  toFun := siteProd M
  map_one' := siteProd_one M
  map_mul' := siteProd_mul M

/-- **具体版 `epsilon_mul_self` を必要十分版の特殊化として導出した形**。 -/
theorem epsilon_mul_self_of_necSuf (M : ℕ) : epsilon M * epsilon M = 1 := by
  apply NecSuf.prefix_terminal_mul_self
    (siteProdMonoidHom M) (fun _ : Fin M => pauliX)
    M (sigmaXPrefixProduct M) (xString M)
      (fun m => if h : m < M then sigmaX ⟨m, h⟩ else 1)
  · rfl
  · exact xString_zero
  · intro m hm
    rw [sigmaXPrefixProduct, dif_pos hm]
  · intro m hm
    rw [dif_pos hm, xString_succ m hm]
  · change xString M M = siteProd M (fun _ : Fin M => pauliX)
    rw [xString]
    congr 1
    funext i
    rw [if_pos i.isLt]
  · intro i
    exact pauliX_mul_pauliX

end Ising2D
