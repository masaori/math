import Mathlib

/-!
「分配多項式の両側評価を対数順序群の鎖へ移す」（`claim_partition_log_order_bounds`）のうち、
有理数での両側評価から対数の鎖を得る段の必要十分版。

具体版 `Ising2DLambda.KacWard.partitionLogOrderTransfer` と同じ手順で示す:
下界は `M ≤ 4Z`、`lg M ≤ lg(4Z) = lg 4 + lg Z = 2·lg 2 + lg Z`、両辺に `-2·lg 2` を加える。
上界は `lg Z ≤ lg(2M) = lg 2 + lg M = lg M + lg 2`。

使うのは次だけである。
* 係数の体 `K` は線型順序体。`M/4` を書くのに `4` の逆元が、`M/4 ≤ Z` から `M ≤ 4Z` を得るのに
  正の数を掛けて不等号が保たれることが要る。
* 対数の行き先 `G` は可換加法群で、二項関係 `le` は加法について単調（`hadd`）であればよい。
  `le` の反射律・推移律・反対称律・全順序性は使わない。`-2·lg 2` を加えるのに `G` の逆元が要る。
* 写像 `lg : K → G` は、正の元の上で順序を保つ（`hiff` の右向きだけを使う。左向きは使わない）。
  正の元の積を和へ送る（`hmul`）。具体版が引く冪の法則 `log 4 = 2ℓ₂` は、指数 `2` では
  積の法則を一度当てることそのもの（`lg(2·2) = lg 2 + lg 2`）なので、冪の法則を仮定に置かない。
* `M > 0`（`hM`）と `Z > 0`（`hZ`）。`lg` を当てる四つの元 `M, 4Z, Z, 2M` の正値性に使う。

住処: 一般の線型順序体と可換加法群。実数体・複素数体・実対数は現れない。
-/

namespace Ising2DLambda.NecSuf.KacWard

/-- 必要十分版: `M/4 ≤ Z ≤ 2M`、`M, Z > 0` なら `lg M − 2·lg 2 ≤ lg Z ≤ lg M + lg 2`。 -/
theorem log_order_transfer_of_two_sided_bounds_necSuf {K G : Type*} [Field K] [LinearOrder K]
    [IsStrictOrderedRing K] [AddCommGroup G] (le : G → G → Prop) (lg : K → G)
    (hiff : ∀ {a b : K}, 0 < a → 0 < b → a ≤ b → le (lg a) (lg b))
    (hmul : ∀ {a b : K}, 0 < a → 0 < b → lg (a * b) = lg a + lg b)
    (hadd : ∀ {x y : G}, le x y → ∀ n : G, le (x + n) (y + n))
    (M Z : K) (hM : 0 < M) (hZ : 0 < Z) (hlow : M / 4 ≤ Z) (hup : Z ≤ 2 * M) :
    le (lg M - 2 • lg 2) (lg Z) ∧ le (lg Z) (lg M + lg 2) := by
  have h2 : (0 : K) < 2 := by norm_num
  -- `lg 4 = 2·lg 2`（積の法則を `2·2` に一度）
  have hlog4 : lg 4 = 2 • lg 2 := by
    have h4 : (4 : K) = 2 * 2 := by norm_num
    rw [h4, hmul h2 h2, two_nsmul]
  constructor
  · have h1 : M ≤ 4 * Z := by linarith
    have hle := hiff hM (by positivity) h1
    rw [hmul (by norm_num) hZ, hlog4] at hle
    have h4 := hadd hle (-(2 • lg 2))
    have e1 : lg M + -(2 • lg 2) = lg M - 2 • lg 2 := by abel
    have e2 : 2 • lg 2 + lg Z + -(2 • lg 2) = lg Z := by abel
    rw [e1, e2] at h4
    exact h4
  · have hle := hiff hZ (by positivity) hup
    rw [hmul h2 hM, add_comm (lg 2)] at hle
    exact hle

end Ising2DLambda.NecSuf.KacWard
