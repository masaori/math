/-
主張「巡回シフトの制限は軌道の元の個数より 1 つ少ない個数の互換の合成である」の必要十分版。

具体版は `Ising2DLambda/AlgebraicEigenvalue/OrbitTranspositionCompositeIsShift.lean`。
証明手順は具体版と同じ（各点を `pt r`（`r < n`）の形に直し、`r < n-1` と `r = n-1` の
2 つの場合に分けて値を突き合わせる）であり、仮定だけを、具体版の証明が実際に使っている
性質まで落としてある。

具体版が持っていて、ここで落としたもの:

* 行配位・巡回シフト・軌道・最小周期・軌道の元の個数。使っていない。現れるのは型 `α` と、
  `ℕ` で番号づけられた点の族 `pt : ℕ → α`、写像 `F`（反復合成に当たる）と `s`（一歩に当たる）だけである。
* `F` や `s` が全単射であること、互換であること、反復合成として構成されたものであること。
  使っていない（`F` について使うのは `hval` だけである）。
* 台が有限であること、台の上の順序 `≺`、点が相異なること。使っていない
  （相異なることが要るのは `hval` を作る側であって、この段ではない）。

残した仮定と、それが必要な理由:

* `hn : 1 ≤ n` — `r = n-1` の場合に `(n-1)+1 = n` を使う。`n = 0` ではこれが成り立たない。
* `hstep` — 一歩の写像が番号を 1 つ進めること。`s` について使うのはこれだけである。
* `hper` — `n` 回で出発点へ戻ること。`r = n-1` の場合に `pt 0 = pt n` として使う。
* `hval` — `F` の値の明示的な記述（前のセクションの結論）。`F` について使うのはこれだけである。
* `hx` — その点が `n` 未満の番号の点として書けること。結論は台のうちこれを満たす点についてのみ述べる。
-/
import Mathlib.Data.Nat.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 具体版の主張に対応する。番号づけられた点の族 `pt`、一歩の写像 `s`、そして
`n-1` 段目の写像 `F` が値の記述 `hval` を満たすとき、`n` 未満の番号の点 `x` について

    F x = s x

である。具体版と同じく `x = pt r`（`r < n`）と書いてから `r < n-1` と `r = n-1` に分ける。 -/
theorem composite_eq_of_values {α : Type*} {pt : ℕ → α} {n : ℕ} (hn : 1 ≤ n)
    {F s : α → α}
    (hstep : ∀ r : ℕ, s (pt r) = pt (r + 1))
    (hper : pt n = pt 0)
    (hval : ∀ {r : ℕ}, r < n →
      F (pt r) = if r < n - 1 then pt (r + 1) else if r = n - 1 then pt 0 else pt r)
    {x : α} (hx : ∃ r : ℕ, r < n ∧ pt r = x) :
    F x = s x := by
  obtain ⟨r, hr, rfl⟩ := hx
  rw [hval hr, hstep r]
  -- r < n かつ n ≥ 1 なので r < n-1 か r = n-1 のいずれかである（r > n-1 は起こらない）。
  rcases Nat.lt_or_ge r (n - 1) with hlt | hge
  · -- r < n-1 の場合。値はそのまま pt (r+1) である。
    rw [if_pos hlt]
  · -- r = n-1 の場合。pt 0 = pt n = pt (r+1) である。
    have hrn : r = n - 1 := by omega
    rw [if_neg (Nat.not_lt.mpr hge), if_pos hrn, ← hper]
    have : r + 1 = n := by omega
    rw [this]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
