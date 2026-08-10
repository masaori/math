/-
主張「最小周期より小さい反復の回数は、行く先で見分けられる」の必要十分版。

具体版は `Ising2DLambda/AlgebraicEigenvalue/RowShiftIterateDistinct.lean`。
証明手順は具体版と同じ（自然数の大小が全順序であることで 2 つの場合に分け、
各場合で「`a ≤ b` の場合」を当てる）であり、仮定だけを、具体版の証明が実際に
使っている性質まで落としてある。

具体版が持っていて、ここで落としたもの:

* 行配位・巡回シフト・反復。使っていない。現れるのは `ℕ` の 2 つ組についての述語だけである。
* 最小周期とその整除性、反復の加法性、反復の単射性。使っていない。
  それらが要るのは「`a ≤ b` の場合」の側であり、この段はそれを仮定として受け取る。
* 上界 `a < e(τ)` と `b < e(τ)`。この段には現れない。述語 `p` の中に畳み込んである
  （具体版では `p a b` を「`a < e(τ)` かつ `b < e(τ)` かつ `S^[a](τ) = S^[b](τ)`」と取る）。

残した仮定と、それが必要な理由:

* `hle : ∀ {a b}, a ≤ b → p a b → a = b` — 各場合で当てる本体である。これが無ければ何も出ない。
* `hsymm : ∀ {a b}, p a b → p b a` — `b ≤ a` の場合に、`a` と `b` を入れ替えて `hle` を
  当てるために要る。具体版でこれが成り立つのは、上界の条件が `a` と `b` について対称で、
  等号 `S^[a](τ) = S^[b](τ)` が対称だからである。`p` が対称でなければ、
  `b ≤ a` の場合に `hle` を当てる形が作れない。
-/
import Mathlib.Data.Nat.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 具体版の一般の場合に対応する。`ℕ` の 2 つ組についての述語 `p` が対称であり、
`a ≤ b` の側で `a = b` を出すならば、`p` は上下の向きを問わず `a = b` を出す。

具体版と同じく `Nat.le_total` で 2 つの場合に分ける。 -/
theorem eq_of_le_of_symm {p : ℕ → ℕ → Prop}
    (hsymm : ∀ {a b : ℕ}, p a b → p b a)
    (hle : ∀ {a b : ℕ}, a ≤ b → p a b → a = b)
    {a b : ℕ} (hab : p a b) : a = b := by
  rcases Nat.le_total a b with h | h
  · exact hle h hab
  · exact (hle h (hsymm hab)).symm

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
