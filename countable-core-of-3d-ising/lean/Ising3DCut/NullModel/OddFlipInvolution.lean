/-
人手証明の主張「奇数側だけ反転する写像は全単射である」
（ラベル `claim_odd_flip_involution`）の具体版。

人手証明の場合分けとこのファイルの対応:

  配位 σ : V_L → {+1,-1}                      `Config`（値 `Spin` は ±1 の整数）
  奇数側だけ反転する写像 T                     `oddFlip`
  a が奇数側: -(-σ(a)) = σ(a)                 `negSpin_negSpin`（`oddFlip_oddFlip` の第一の場合）
  a が偶数側: (T(Tσ))(a) = σ(a)               `oddFlip_oddFlip` の第二の場合
  どの点でも値が一致するので写像として等しい    `funext`
  T は自分自身を逆写像に持つので全単射          `oddFlip_bijective`

人手証明の「逆写像を持つ写像は全単射である」も既製の一般論へ委ねず、
単射（両辺へ T を当てて `oddFlip_oddFlip` で戻す）と全射（`oddFlip σ` が原像）を
このファイルの中で示す。

住処: `Fin`、`Nat`、`Bool`、整数 ±1 のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NullModel.EdgeEndpointParity

namespace Ising3DCut.NullModel

/-- 配位の値。`+1` か `-1` の整数。 -/
def Spin := {z : ℤ // z = 1 ∨ z = -1}

/-- 値の符号反転。`-(+1) = -1`、`-(-1) = +1` なので値の集合に閉じる。 -/
def negSpin (z : Spin) : Spin :=
  ⟨-z.1, by rcases z.2 with h | h <;> omega⟩

/-- 人手証明の「符号反転を二回すると元に戻る」。 -/
lemma negSpin_negSpin (z : Spin) : negSpin (negSpin z) = z := by
  apply Subtype.ext
  simp [negSpin]

/-- 配位。箱の点に ±1 を割り当てる写像。 -/
def Config (L : ℕ) := Site L → Spin

/-- 奇数側だけ反転する写像 T。座標和が奇数の点でだけ値の符号を反転する。 -/
def oddFlip {L : ℕ} (σ : Config L) : Config L :=
  fun a => if parity a then negSpin (σ a) else σ a

/-- `claim_odd_flip_involution` の前半の具体版。`T(Tσ) = σ`。 -/
theorem oddFlip_oddFlip {L : ℕ} (σ : Config L) : oddFlip (oddFlip σ) = σ := by
  funext a
  by_cases h : parity a
  · simp [oddFlip, h, negSpin_negSpin]
  · simp [oddFlip, h]

/-- `claim_odd_flip_involution` の後半の具体版。T は全単射である。 -/
theorem oddFlip_bijective {L : ℕ} : Function.Bijective (oddFlip (L := L)) := by
  constructor
  · intro σ τ h
    have h2 := congrArg oddFlip h
    rwa [oddFlip_oddFlip, oddFlip_oddFlip] at h2
  · intro σ
    exact ⟨oddFlip σ, oddFlip_oddFlip σ⟩

end Ising3DCut.NullModel
