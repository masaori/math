/-
主張「軌道の元が巡回シフトで動かないことと、その軌道の元の個数が 1 であることは同値である」の
必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.OrbitFixedIffCardOne`）の証明は、
反復の第 1 項が一歩の写像に一致すること（準備の第二）と、もとへ戻る回数が周期の倍数であること
（既出）を合わせて、`e ∣ 1` を `e = 1` へ直す議論である。証明手順は具体版と同じで、
`e ∣ 1 ⇒ e = 1` の段は人手証明どおり `1 = e·q` から `q ≥ 1` と `e ≥ 2` の矛盾で出す
（mathlib の `Nat.dvd_one` へ委ねない）。

  使っている性質                なぜ削れないか
  `hstep : it 1 τ = f τ`        結論を反復の言葉から一歩の写像の言葉へ移す唯一の経路。
  `hdvd : it 1 τ = τ ↔ ∃ q, 1 = e * q`
                                周期が倍数を特徴づけること。これが無いと `e` と写像が無関係になる。
  `hpos : 1 ≤ e`                `e = 0` を排除する。`e = 0` なら `1 = 0·q` が起きえないので
                                左向きの `e = 1` が導けるが、右向きで `e = 0` が残ってしまう。

削れたもの: 台が軌道であること、`f` が巡回シフトであること、`f` が全単射であること、
反復の再帰 2 式（第 1 項の値だけあればよい）、型の有限性・相等の決定可能性、順序 `≺`、
そして「軌道の元の個数」という数え上げそのもの（`e` は勝手な自然数でよい）。
人手証明の側で言えば、この段は $\lvert O\rvert=e(\tau)$ を準備として受け取ってしまえば、
軌道についても巡回シフトについても何も使っていない。

住処: ここに ℝ / ℂ は現れない（点は一般の型、回数は ℕ）。
-/
import Mathlib.Data.Nat.Basic
import Mathlib.Tactic.Common

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 人手証明の主張「一歩の写像が点を動かさないことと、その点の周期が 1 であることは同値である」の
本体。

証明は人手証明どおり 2 つの向きを別々に示す。第一の向きでは `1 = e * q` から
`q ≥ 1` を出し、`e ≥ 2` とすると `2 ≤ e * q = 1` となって矛盾することで `e = 1` を得る。 -/
theorem step_eq_self_iff_period_eq_one {α : Type*} {f : α → α} {it : ℕ → α → α} {τ : α}
    {e : ℕ} (hstep : it 1 τ = f τ) (hpos : 1 ≤ e)
    (hdvd : it 1 τ = τ ↔ ∃ q : ℕ, 1 = e * q) :
    f τ = τ ↔ e = 1 := by
  rw [hstep] at hdvd
  constructor
  · -- 第一の向き。f τ = τ ならば e = 1。
    intro hfix
    obtain ⟨q, hq⟩ := hdvd.mp hfix
    rcases Nat.lt_or_ge e 2 with hlt | hge
    · omega
    · exfalso
      rcases Nat.eq_zero_or_pos q with rfl | hq1
      · simp at hq
      · have hmul : 2 * 1 ≤ e * q := Nat.mul_le_mul hge hq1
        rw [← hq] at hmul
        omega
  · -- 第二の向き。e = 1 ならば f τ = τ。
    intro he
    exact hdvd.mpr ⟨1, by rw [he]⟩

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
