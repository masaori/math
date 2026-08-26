import Mathlib

/-!
「有理点が整数のとき分子は多重度ゼロの値から 1 を引いた数の 2 倍を割る」の必要十分版。

具体版が実際に使っているのは、有限和・冪・自然数の減法ではない。
対象が `x = r + a * s` の形へ分かれること、それだけである。
分かれた片方は `a` の倍数なので、`k * (x - c)` の整除は `k * (r - c)` の整除へ移る。
したがって残る仮定は可換環であることと、この加法的な分解ひとつだけになる。

具体版に現れた「$m=0$ の項の分離」は `hdecomposition` の実例であり、
「両辺から 1 を引いて 2 倍する」は `k` と `c` の実例である。
自然数へ戻すのは減法の向きの都合だけなので、抽象版は可換環で述べる。
-/

namespace Ising3DCut.NecSuf

/-- 加法的な分解 `x = r + a * s` に沿って、`a` による整除は補正項を落として移る。 -/
theorem dvd_of_additive_decomposition {R : Type*} [CommRing R] {a k x r s c : R}
    (hdecomposition : x = r + a * s) (hdvd : a ∣ k * (x - c)) :
    a ∣ k * (r - c) := by
  have hrewrite : k * (r - c) = k * (x - c) - a * (k * s) := by
    rw [hdecomposition]; ring
  rw [hrewrite]
  exact dvd_sub hdvd ⟨k * s, rfl⟩

end Ising3DCut.NecSuf
