/-
主張「シフト行列の特性多項式は、格子の一辺を指数とする冪と単位元の逆元との和の、
軌道の個数を指数とする冪の因子である」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.ShiftCharDvdPowL`）の証明は、
各添字について相手を 1 つ選んでその有限積を商とし、前セクションの
`prod_pair_eq_pow_card` を `s = univ` と取って当てるものである。証明手順は具体版と同じ
（相手を選ぶ段 → 商を有限積として置く段 → 個数を `univ` の元の個数へ書き換える段 →
2 つの有限積の積の等式を当てる段）。

  使っている性質                なぜ削れないか
  `CommMonoid M`                有限積を取ること、および `prod_pair_eq_pow_card_necSuf` が要求する。
  `DecidableEq ι`               `prod_pair_eq_pow_card_necSuf` が `insert` で帰納法を回すのに要る。
  `Fintype ι`                   添字の全体にわたる有限積と `Fintype.card ι` を書くのに要る
                                （部分集合版では `s` がもとから有限だったので不要だった）。

削れたもの: 加法・零元・分配則、値が多項式であること、添字が軌道であること、
`a i` が和として作られていること、`c` が `t ^ L + u` の形であること。
すなわちこの段は**特性多項式の話も軌道の話も一切使っていない**。
「各因子が `c` を割る」から「積が `c ^ (添字の個数)` を割る」を出すだけの言明である。

住処: ここに ℝ / ℂ は現れない（値は一般の可換モノイド、個数は ℕ）。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.ProdPairEqPowCard

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- 必要十分版の本体。すべての添字 `i` について `a i * g = c` を満たす `g` が存在するならば、
`∏ i, a i` は `c ^ (添字の個数)` を割る。 -/
theorem prod_dvd_pow_card_necSuf {ι : Type*} [DecidableEq ι] [Fintype ι] {M : Type*}
    [CommMonoid M] (a : ι → M) (c : M) (h : ∀ i : ι, ∃ g : M, a i * g = c) :
    (∏ i : ι, a i) ∣ c ^ Fintype.card ι := by
  -- 各添字について相手を 1 つ選ぶ（人手証明の `b` を置く段）。
  choose b hb using h
  -- 商はその有限積である（人手証明の `g` を置く段）。
  refine ⟨∏ i : ι, b i, ?_⟩
  calc c ^ Fintype.card ι
      -- 個数を `univ` の元の個数へ書き換える。
      = c ^ (Finset.univ : Finset ι).card := by rw [Finset.card_univ]
      -- 2 つの有限積の積の等式（前セクション）を `s = univ` と取ったもの。
    _ = (∏ i : ι, a i) * ∏ i : ι, b i :=
        (prod_pair_eq_pow_card_necSuf a b c Finset.univ (fun i _ => hb i)).symm

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
